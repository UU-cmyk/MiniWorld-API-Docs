# MiniWorld API Description

![VS Code](https://img.shields.io/badge/VS%20Code-^1.125.0-blue)
![Lua](https://img.shields.io/badge/Lua-5.1%2B-yellow)

A VS Code extension providing Lua type declarations, API search, and event completion for MiniWorld UGC development.

## English

### Features

#### 📦 Type declarations

The extension provides Lua declaration files for **UGC 2.0** and **UGC 3.0** and automatically syncs the selected declaration version to the Lua language service.

The `miniworld.completion` setting controls the completion mode:

| Value | Behavior |
| :-: | :-: |
| `2.0` | Enables UGC 2.0 declaration completion and 2.0 event completion |
| `3.0` | Enables UGC 3.0 declaration completion and 3.0 event completion |
| `off` | Removes MiniWorld declarations and disables event completion |

The default value is `2.0`.

#### 🔍 API Search

Open the API search view from the activity bar or command palette to search for functions, enums, events, and parameter information.

- Supports filtering by version, module, and type
- Supports click-to-jump behavior
- Refreshes the index with a dedicated command

#### ⚡ Event completion

The extension completes events in relevant contexts such as `ScriptSupportEvent([=[...]=])` and after `TriggerEvent.` / `ObjectEvent.`.

### Commands

| Command | Description |
| :-: | :-: |
| `MiniWorld API Description: 添加 MiniWorld UGC 声明` | Select a version and set the completion mode automatically |
| `MiniWorld API Description: 清除 MiniWorld UGC 补全` | Clear completion configuration |
| `MiniWorld API Description: 打开 API 搜索` | Open the API search view |
| `MiniWorld API Description: 刷新 API 搜索索引` | Refresh the API search index |
| `MiniWorld API Description: 清空 ID 数据缓存` | Clear cached ID data and redownload it |

### Settings

| Setting | Description |
| :-: | :-: |
| `miniworld.completion` | Completion mode: `2.0`, `3.0`, or `off` |
| `miniworld.serverUrl` | Server used to fetch ID data, default `desc.cmyk.dpdns.org` |

### Requirements

- [VS Code](https://code.visualstudio.com/) ^1.125.0
- [Lua Language Server (sumneko.lua)](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)

### Notes

- This extension targets **UGC 2.0** and **UGC 3.0** only.
- Some API behavior may differ from the actual game, so use the game as the final reference.
- For bug reports or feature requests, please open an [Issue](https://github.com/LK-cmyk/MiniWorld-API-Desc/issues).

### License

[MIT](https://github.com/LK-cmyk/MiniWorld-API-Desc/blob/main/LICENSE)

---

# MiniWorld API Description

![VS Code](https://img.shields.io/badge/VS%20Code-^1.125.0-blue)
![Lua](https://img.shields.io/badge/Lua-5.1%2B-yellow)

为《迷你世界》UGC 开发提供 Lua 类型声明、API 搜索和事件补全的 VS Code 扩展。

## 中文

### 功能

#### 📦 类型声明

扩展为 **UGC 2.0** 和 **UGC 3.0** 提供 Lua 声明文件，并根据 `miniworld.completion` 自动同步对应版本到 Lua 语言服务。

`miniworld.completion` 控制补全模式：

| 值 | 行为 |
| :-: | :-: |
| `2.0` | 启用 UGC 2.0 声明补全和 2.0 事件补全 |
| `3.0` | 启用 UGC 3.0 声明补全和 3.0 事件补全 |
| `off` | 移除 MiniWorld 声明并关闭事件补全 |

默认值为 `2.0`。

#### 🔍 API 搜索

可从活动栏或命令面板打开 API 搜索视图，快速搜索函数、枚举、事件和参数信息。

- 支持按版本、模块、类型筛选
- 支持点击跳转到声明位置
- 可通过命令刷新索引

#### ⚡ 事件补全

扩展会在 `ScriptSupportEvent([=[...]=])` 等场景中提供相应版本事件补全，并在 `TriggerEvent.` / `ObjectEvent.` 后补全 3.0 事件字段。

### 扩展命令

| 命令 | 说明 |
| :-: | :-: |
| `MiniWorld API Description: 添加 MiniWorld UGC 声明` | 选择版本并自动设置补全模式 |
| `MiniWorld API Description: 清除 MiniWorld UGC 补全` | 清除补全配置 |
| `MiniWorld API Description: 打开 API 搜索` | 打开 API 搜索视图 |
| `MiniWorld API Description: 刷新 API 搜索索引` | 刷新 API 搜索索引 |
| `MiniWorld API Description: 清空 ID 数据缓存` | 清空 ID 缓存并重新下载 |

### 设置项

| 设置项 | 说明 |
| :-: | :-: |
| `miniworld.completion` | 补全模式：`2.0`、`3.0` 或 `off` |
| `miniworld.serverUrl` | 下载 ID 数据的服务器地址，默认 `desc.cmyk.dpdns.org` |

### 依赖要求

- [VS Code](https://code.visualstudio.com/) ^1.125.0
- [Lua 语言服务（sumneko.lua）](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)

### 注意事项

- 本扩展仅面向 **UGC 2.0** 和 **UGC 3.0**。
- 部分 API 行为可能与实际游戏存在差异，最终以游戏表现为准。
- 如发现问题或需要补充 API，欢迎提交 [Issue](https://github.com/LK-cmyk/MiniWorld-API-Desc/issues)。

### 许可

[MIT](https://github.com/LK-cmyk/MiniWorld-API-Desc/blob/main/LICENSE)
