import * as fs from 'fs';
import * as path from 'path';
import * as vscode from 'vscode';

import { COMPLETION_MODE_SETTING, getCompletionMode, type CompletionMode } from './completionMode';

/** 事件定义文件 */
const EVENT_DEFINITIONS_FILE_20 = path.join('declarations', '2.0', 'MNEvent.d.json');
const EVENT_DEFINITIONS_FILE_30 = path.join('declarations', '3.0', 'MNEvent.d.lua');

/** 3.0 模式支持的事件枚举类 */
const EVENT_CLASSES_30 = ['TriggerEvent', 'ObjectEvent'] as const;
type EventClass30 = typeof EVENT_CLASSES_30[number];

export type EventDefinition = {
    desc?: string;
    event_info?: Record<string, string>;
};

/** 事件补全的会话状态，集中管理避免散落的模块级变量 */
type CompletionState = {
    mode: CompletionMode;
    ready: boolean;
    definitions: Map<string, EventDefinition>;
    /** 2.0 模式的完整补全项缓存 */
    flatItems: vscode.CompletionItem[] | null;
    /** 3.0 模式按类名缓存的补全项 */
    classItems: Map<EventClass30, vscode.CompletionItem[]>;
};

const state: CompletionState = {
    mode: '2.0',
    ready: false,
    definitions: new Map(),
    flatItems: null,
    classItems: new Map(),
};

let loadSeq = 0;

function getEventDefinitionsFile(context: vscode.ExtensionContext, mode: '2.0' | '3.0'): string {
    const rel = mode === '3.0' ? EVENT_DEFINITIONS_FILE_30 : EVENT_DEFINITIONS_FILE_20;
    const bundled = path.resolve(context.extensionPath, rel);
    return fs.existsSync(bundled) ? bundled : path.resolve(context.extensionPath, '..', rel);
}

export async function parseEventDefinitions(filePath: string): Promise<Map<string, EventDefinition>> {
    try {
        const raw = await fs.promises.readFile(filePath, 'utf8');
        const parsed = JSON.parse(raw) as Record<string, EventDefinition>;
        return sortEntries(Object.entries(parsed));
    } catch (error) {
        console.warn(`读取事件补全文件失败: ${filePath}`, error);
        return new Map();
    }
}

/** 解析 3.0 MNEvent.d.lua 中的 LuaDoc 事件定义。 */
export async function parseLuaEventDefinitions(filePath: string): Promise<Map<string, EventDefinition>> {
    try {
        const raw = await fs.promises.readFile(filePath, 'utf8');
        return sortEntries(Array.from(parseLuaDefinitions(raw).entries()));
    } catch (error) {
        console.warn(`读取事件补全文件失败: ${filePath}`, error);
        return new Map();
    }
}

/** 将事件键按字典序排序，保证补全列表顺序稳定 */
function sortEntries(entries: [string, EventDefinition][]): Map<string, EventDefinition> {
    entries.sort(([left], [right]) => left.localeCompare(right));
    return new Map(entries);
}

/** 从 LuaDoc 源文本中提取以 `ClassName.fieldName` 为键的事件定义 */
function parseLuaDefinitions(raw: string): Map<string, EventDefinition> {
    const definitions = new Map<string, EventDefinition>();
    let currentClass: EventClass30 | null = null;

    const classRe = /^---\s+@class\s+(TriggerEvent|ObjectEvent)\b/;
    const fieldRe = /^---\s+@field\s+(\w+)\s+\S+\s+@(.+?)(?:\s+\{(.*)\})?\s*$/;

    for (const line of raw.split(/\r?\n/)) {
        const classMatch = classRe.exec(line);
        if (classMatch) {
            currentClass = classMatch[1] as EventClass30;
            continue;
        }

        const fieldMatch = fieldRe.exec(line);
        if (!currentClass || !fieldMatch) {
            continue;
        }

        const [, fieldName, desc, rawParams] = fieldMatch;
        const eventInfo = parseEventInfoParams(rawParams);
        definitions.set(`${currentClass}.${fieldName}`, {
            desc: desc.trim(),
            ...(Object.keys(eventInfo).length > 0 ? { event_info: eventInfo } : {}),
        });
    }

    return definitions;
}

/** 解析 LuaDoc `@field` 的 `{name:type,name2:type2}` 形式参数列表 */
function parseEventInfoParams(rawParams: string | undefined): Record<string, string> {
    const eventInfo: Record<string, string> = {};
    if (!rawParams) {
        return eventInfo;
    }

    for (const part of rawParams.split(/,\s*(?=\w+(?:,\w+)*:)/)) {
        const separator = part.indexOf(':');
        if (separator === -1) {
            continue;
        }
        const value = part.slice(separator + 1).trim();
        for (const name of part.slice(0, separator).split(',')) {
            const trimmed = name.trim();
            if (trimmed) {
                eventInfo[trimmed] = value;
            }
        }
    }
    return eventInfo;
}

/** 构建事件的 Markdown 文档（描述 + 参数表） */
function buildEventDocumentation(definition: EventDefinition): vscode.MarkdownString {
    const sections: string[] = [];

    if (definition.desc) {
        sections.push(`**${definition.desc}**`);
    }
    if (definition.event_info) {
        const lines = Object.entries(definition.event_info).map(([key, value]) => `- ${key}: ${value}`);
        if (lines.length > 0) {
            sections.push(`参数:\n${lines.join('\n')}`);
        }
    }

    const md = new vscode.MarkdownString(sections.join('\n\n'));
    md.isTrusted = true;
    return md;
}

/** 构建 2.0 模式的补全项（键为完整事件名，补全后自动包裹长括号） */
export function buildEventCompletionItems(definitions: Map<string, EventDefinition>): vscode.CompletionItem[] {
    const items: vscode.CompletionItem[] = [];

    for (const [eventName, definition] of definitions) {
        const item = new vscode.CompletionItem(eventName, vscode.CompletionItemKind.Event);
        item.detail = definition.desc ?? 'MiniWorld 事件';
        item.filterText = eventName;
        item.insertText = eventName;
        item.command = {
            command: 'complete.wrapEventBrackets',
            title: '补全事件长括号',
            arguments: [eventName],
        };
        item.documentation = buildEventDocumentation(definition);
        items.push(item);
    }

    return items;
}

/** 构建 3.0 模式指定事件类的补全项（按类名前缀筛选，直接插入字段名） */
export function buildClassCompletionItems(
    definitions: Map<string, EventDefinition>,
    className: EventClass30,
): vscode.CompletionItem[] {
    const prefix = `${className}.`;
    const items: vscode.CompletionItem[] = [];

    for (const [key, definition] of definitions) {
        if (!key.startsWith(prefix)) {
            continue;
        }
        const fieldName = key.substring(prefix.length);
        const item = new vscode.CompletionItem(fieldName, vscode.CompletionItemKind.Event);
        item.detail = definition.desc ?? `MiniWorld ${className} 事件`;
        item.filterText = fieldName;
        item.insertText = fieldName;
        item.documentation = buildEventDocumentation(definition);
        items.push(item);
    }

    return items;
}

/** 取得 3.0 模式下某事件类的补全项，必要时构建并缓存 */
function getClassItems(className: EventClass30): vscode.CompletionItem[] {
    let items = state.classItems.get(className);
    if (!items) {
        items = buildClassCompletionItems(state.definitions, className);
        state.classItems.set(className, items);
    }
    return items;
}

type CompletionContext =
    | { kind: '2.0' }
    | { kind: '3.0'; className: EventClass30 };

/**
 * 判断光标前的补全上下文。
 * - 2.0：`[=[` 与 `]=]` 之间的长括号字符串内
 * - 3.0：`TriggerEvent.` / `ObjectEvent.` 之后
 */
function getCompletionContext(
    document: vscode.TextDocument,
    position: vscode.Position,
    mode: '2.0' | '3.0',
): CompletionContext | null {
    const lineText = document.lineAt(position.line).text;
    const textBefore = lineText.substring(0, position.character);

    if (mode === '3.0') {
        // 前面须为非标识符或行首，避免误匹配 AddTriggerEvent
        const match = /(?:^|[^\w])(TriggerEvent|ObjectEvent)\.[\w.]*$/.exec(textBefore);
        return match ? { kind: '3.0', className: match[1] as EventClass30 } : null;
    }

    const openIdx = textBefore.lastIndexOf('[=[');
    if (openIdx === -1) {
        return null;
    }

    // `[=[` 与光标之间若已出现 `]=]`，说明光标在字符串之外
    if (textBefore.substring(openIdx + 3).includes(']=]')) {
        return null;
    }
    // 光标之后若已有 `]=]`，说明光标在字符串之外
    if (lineText.substring(position.character).includes(']=]')) {
        return null;
    }

    return { kind: '2.0' };
}

/**
 * 注册事件补全提供者和括号包裹命令。
 * 补全模式由设置项 `miniworld.completion` 控制，设置变化时自动重载对应版本定义。
 */
export function registerEventCompletion(context: vscode.ExtensionContext): vscode.Disposable[] {
    const disposables: vscode.Disposable[] = [];

    async function loadEventDefinitions(): Promise<void> {
        const targetMode = getCompletionMode();
        const seq = ++loadSeq;

        state.mode = targetMode;
        state.ready = false;
        state.definitions = new Map();
        state.flatItems = null;
        state.classItems.clear();

        if (targetMode === 'off') {
            return;
        }

        const filePath = getEventDefinitionsFile(context, targetMode);
        const parser = targetMode === '3.0' ? parseLuaEventDefinitions : parseEventDefinitions;

        try {
            const defs = await parser(filePath);
            if (seq !== loadSeq) {
                return;
            }

            state.definitions = defs;
            // 2.0 一次性构建完整缓存；3.0 按需懒构建，避免为未使用的类付出代价
            if (targetMode === '2.0') {
                state.flatItems = buildEventCompletionItems(defs);
            }
            state.ready = true;
        } catch (error) {
            console.warn('加载事件补全定义失败', error);
        }
    }

    void loadEventDefinitions();

    disposables.push(
        vscode.workspace.onDidChangeConfiguration(e => {
            if (e.affectsConfiguration(COMPLETION_MODE_SETTING)) {
                void loadEventDefinitions();
            }
        }),
    );

    disposables.push(
        vscode.languages.registerCompletionItemProvider(
            { language: 'lua' },
            {
                provideCompletionItems(document, position) {
                    if (state.mode === 'off' || !state.ready) {
                        return undefined;
                    }

                    const ctx = getCompletionContext(document, position, state.mode);
                    if (ctx === null) {
                        return undefined;
                    }

                    // 返回缓存项，由 VS Code 基于 filterText 原生过滤；
                    // CompletionList(isIncomplete:false) 让结果被缓存，避免重复触发。
                    if (ctx.kind === '2.0') {
                        return new vscode.CompletionList(state.flatItems ?? [], false);
                    }
                    return new vscode.CompletionList(getClassItems(ctx.className), false);
                },
            },
            '.',
        ),
    );

    disposables.push(
        vscode.commands.registerCommand('complete.wrapEventBrackets', (eventName: unknown) => {
            if (typeof eventName !== 'string' || !eventName) {
                return;
            }

            const editor = vscode.window.activeTextEditor;
            if (!editor) {
                return;
            }

            const document = editor.document;
            const cursor = editor.selection.active;
            const startChar = cursor.character - eventName.length;
            if (startChar < 0) {
                return;
            }

            const lineText = document.lineAt(cursor.line).text;
            const before = lineText.substring(0, startChar);
            const after = lineText.substring(cursor.character);

            const edits = new vscode.WorkspaceEdit();
            const startPos = new vscode.Position(cursor.line, startChar);

            if (!before.endsWith('[=[')) {
                edits.insert(document.uri, startPos, '[=[');
            }
            if (!after.startsWith(']=]')) {
                edits.insert(document.uri, cursor, ']=]');
            }

            if (edits.size > 0) {
                void vscode.workspace.applyEdit(edits);
            }
        }),
    );

    return disposables;
}