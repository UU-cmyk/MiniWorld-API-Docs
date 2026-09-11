(function () {
    const vscode = acquireVsCodeApi();

    const el = {
        searchView: document.getElementById('searchView'),
        detailView: document.getElementById('detailView'),
        detailContent: document.getElementById('detailContent'),
        detailBack: document.getElementById('detailBack'),
        searchInput: document.getElementById('searchInput'),
        searchClear: document.getElementById('searchClear'),
        results: document.getElementById('results'),
        pagination: document.getElementById('pagination'),
        stats: document.getElementById('resultCount'),
        loading: document.getElementById('loading'),
        secondFilters: document.getElementById('secondFilters'),
        idFilters: document.getElementById('idFilters'),
        moduleSelect: document.getElementById('moduleFilter'),
    };
    el.selectTrigger = el.moduleSelect.querySelector('.select-trigger');
    el.selectDropdown = el.moduleSelect.querySelector('.select-dropdown');

    // SVG 图标内容（从 body data-* 属性读取，直接内联到 HTML）
    const SVG = {
        copy: document.body.dataset.copySvg || '',
        check: document.body.dataset.checkSvg || '',
        search: document.body.dataset.searchSvg || '',
    };

    const PAGE_SIZE = 25;
    const FADE_IN_MAX = 10; // 错峰淡入动画的最大条数上限
    const SEARCH_DEBOUNCE_MS = 150;
    const LOADING_MIN_MS = 150; // loading 至少显示时长，避免闪烁
    const COPY_FEEDBACK_MS = 1200;

    const KIND_LABELS = { function: '函数', enum: '枚举', event: '事件' };
    const KIND_CLASSES = { function: 'kind-function', enum: 'kind-enum', event: 'kind-event' };
    const FIELD_TITLES = { event: '事件字段', enum: '枚举值' };
    const MODULE_DISABLED_KINDS = new Set(['event', 'enum']);

    const HTML_ESCAPE_MAP = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' };
    const HTML_ESCAPE_RE = /[&<>"']/g;

    const state = {
        version: 'all',
        module: 'all',
        kind: 'function',
        activeTab: 'function',
        query: '',
        idData: { item: {}, actor: {}, buff: {} },
        idDataVersion: -1,
        idCategory: 'item',
        idError: '',
        modules20: [],
        modules30: [],
        totalCount: 0,
        currentPage: 1,
        totalPages: 1,
        // ID 标签页使用客户端分页 (数据较小且已预排序)，其他标签页使用服务端分页
        idResults: [],
        idCurrentPage: 1,
        // 预排序的 ID 条目缓存：category -> 排序后的 [id, entry][]
        idSortedCache: new Map(),
    };

    function updateModuleOptions(version) {
        const mods = version === '2.0'
            ? state.modules20
            : version === '3.0'
                ? state.modules30
                : [...new Set([...state.modules20, ...state.modules30])].sort();

        const currentVal = el.selectTrigger.dataset.value;

        const parts = [
            `<button class="select-option${currentVal === 'all' ? ' active' : ''}" data-value="all">全部模块</button>`,
        ];
        for (const mod of mods) {
            const active = mod === currentVal ? ' active' : '';
            parts.push(`<button class="select-option${active}" data-value="${escapeHtml(mod)}">${escapeHtml(mod)}</button>`);
        }
        el.selectDropdown.innerHTML = parts.join('');

        // 当前选中项在新版本下不存在时，回退到"全部模块"
        const keep = currentVal !== 'all' && mods.includes(currentVal);
        if (!keep) {
            setModuleAll();
        }

        setModuleFilterEnabled(!MODULE_DISABLED_KINDS.has(state.kind));
        closeDropdown();
    }

    function setModuleAll() {
        el.selectTrigger.dataset.value = 'all';
        el.selectTrigger.textContent = '全部模块';
        state.module = 'all';
    }

    function setModuleFilterEnabled(enabled) {
        el.moduleSelect.classList.toggle('disabled', !enabled);
    }

    function applyModuleSelection(value, label) {
        el.selectTrigger.dataset.value = value;
        el.selectTrigger.textContent = label;

        el.selectDropdown.querySelectorAll('.select-option').forEach(o => {
            o.classList.toggle('active', o.dataset.value === value);
        });

        state.module = value;
        closeDropdown();
        doSearch(1);
    }

    function toggleDropdown() {
        if (el.moduleSelect.classList.contains('disabled')) return;
        el.selectDropdown.classList.contains('open') ? closeDropdown() : openDropdown();
    }
    function openDropdown() {
        el.selectDropdown.classList.add('open');
        el.selectTrigger.classList.add('open');
    }
    function closeDropdown() {
        el.selectDropdown.classList.remove('open');
        el.selectTrigger.classList.remove('open');
    }

    function setActiveView(name) {
        el.searchView.classList.toggle('hidden', name !== 'search');
        el.detailView.classList.toggle('hidden', name !== 'detail');
    }

    function doSearch(page) {
        showLoading();
        vscode.postMessage({
            type: 'search',
            query: state.query,
            version: state.version,
            module: state.module,
            kind: state.kind,
            page: page || 1,
            pageSize: PAGE_SIZE,
        });
    }

    function runSearch(page) {
        if (state.activeTab === 'id') {
            renderIdView();
        } else {
            doSearch(page);
        }
    }

    function handleQueryChange(value) {
        state.query = value;
        el.searchClear.classList.toggle('visible', value.length > 0);
        runSearch(1);
    }

    function clearQuery() {
        el.searchInput.value = '';
        handleQueryChange('');
    }

    let loadingHideTimer = null;
    function showLoading() {
        clearTimeout(loadingHideTimer);
        el.loading.classList.remove('hidden');
    }
    function hideLoading() {
        clearTimeout(loadingHideTimer);
        loadingHideTimer = setTimeout(() => el.loading.classList.add('hidden'), LOADING_MIN_MS);
    }

    /** 获取或构建某分类下已排序的 ID 条目数组 */
    function getIdSortedEntries(category) {
        let arr = state.idSortedCache.get(category);
        if (arr) return arr;
        const map = state.idData[category] || {};
        arr = Object.entries(map).sort((a, b) => a[0].localeCompare(b[0], undefined, { numeric: true }));
        state.idSortedCache.set(category, arr);
        return arr;
    }

    function invalidateIdCache() {
        state.idSortedCache.clear();
    }

    function renderIdView() {
        hideLoading();
        const q = state.query.trim().toLowerCase();
        const sorted = getIdSortedEntries(state.idCategory);
        const filtered = q
            ? sorted.filter(([id, e]) =>
                id.toLowerCase().includes(q) ||
                (e.name || '').toLowerCase().includes(q) ||
                (e.desc || '').toLowerCase().includes(q))
            : sorted;

        if (state.idError && sorted.length === 0) {
            renderEmpty('ID 数据加载失败', state.idError);
            el.stats.textContent = '0 / 0 个 ID';
            return;
        }

        if (filtered.length === 0) {
            if (sorted.length === 0 && !q) {
                renderEmpty('该分类暂无 ID 数据', '可在服务器上传对应分类数据');
            } else {
                renderEmpty('未找到匹配 ID', '尝试使用更短的搜索词');
            }
            el.stats.textContent = '0 / ' + sorted.length + ' 个 ID';
            return;
        }

        state.idResults = filtered.map(([id, e]) => ({ id, name: e.name || '', desc: e.desc }));
        state.idCurrentPage = 1;
        renderIdCurrentPage();
    }

    function renderEmpty(title, subtitle) {
        el.results.innerHTML =
            `<div class="empty">
                <div class="empty-icon">${SVG.search}</div>
                <div class="title">${escapeHtml(title)}</div>
                <div class="subtitle">${escapeHtml(subtitle)}</div>
            </div>`;
        el.pagination.innerHTML = '';
    }

    function renderIdCurrentPage() {
        el.searchView.scrollIntoView({ behavior: 'smooth', block: 'start' });

        const total = state.idResults.length;
        const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE));
        const page = state.idCurrentPage;
        const start = (page - 1) * PAGE_SIZE;
        const end = Math.min(start + PAGE_SIZE, total);
        const pageItems = state.idResults.slice(start, end);

        el.stats.textContent = `${end} / ${total} 个 ID`;

        el.results.innerHTML = '';
        for (const item of pageItems) {
            const card = document.createElement('div');
            card.className = 'result-item fade-in';
            card.innerHTML = `
                <div class="result-header">
                    <span class="result-name">${escapeHtml(item.name || item.id)}</span>
                </div>
                <div class="result-tags">
                    <span class="result-kind kind-id">ID</span>
                    <span class="result-module id-id">${escapeHtml(item.id)}</span>
                    <button class="copy-btn result-copy-btn" data-copy="${escapeHtml(item.id)}" title="复制 ID">${SVG.copy}</button>
                </div>
                ${item.desc ? '<div class="result-desc">' + escapeHtml(item.desc) + '</div>' : ''}
            `;

            const copyBtn = card.querySelector('.result-copy-btn');
            copyBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                copyToClipboard(item.id, copyBtn);
            });
            card.addEventListener('click', () => showIdDetail(item.id));
            el.results.appendChild(card);
        }

        renderPagination(page, totalPages, (newPage) => {
            state.idCurrentPage = newPage;
            renderIdCurrentPage();
        });
    }

    function showDetail(name, sourceFile, sourceLine, kind) {
        vscode.postMessage({ type: 'showDetail', name, sourceFile, sourceLine, kind });
        setActiveView('detail');
        el.detailContent.innerHTML = '<div class="loading">加载中…</div>';
    }

    function showIdDetail(id) {
        const e = (state.idData[state.idCategory] || {})[id];
        if (!e) return;

        let html = `<div class="detail-name" style="font-family:var(--font-mono);font-weight:700;font-size:16px;color:var(--vscode-textLink-foreground,#3794ff);word-break:break-all;margin-bottom:6px">${escapeHtml(e.name || id)}</div>`;
        html += `<div style="display:flex;align-items:center;gap:6px;flex-wrap:wrap;margin-bottom:8px">
            <span class="result-kind kind-id">ID</span>
            <span class="id-id" style="font-size:12px;opacity:0.85">${escapeHtml(id)}</span>
            <button class="copy-btn detail-copy-btn" data-copy="${escapeHtml(id)}" title="复制 ID">${SVG.copy}</button>
        </div>`;

        if (e.desc) {
            html += `<div class="detail-section"><div class="detail-section-title">描述</div><div class="detail-desc markdown-body">${renderMarkdown(e.desc)}</div></div>`;
        }

        el.detailContent.innerHTML = html;

        const copyBtn = el.detailContent.querySelector('.detail-copy-btn');
        if (copyBtn) {
            copyBtn.addEventListener('click', () => copyToClipboard(id, copyBtn));
        }
        setActiveView('detail');
    }

    function renderDetail(d) {
        const kindLabel = KIND_LABELS[d.kind] || d.kind;
        const kindClass = KIND_CLASSES[d.kind] || '';
        const verClass = d.version === '2.0' ? 'version-2\\.0-tag' : 'version-3\\.0-tag';

        const detailDisplayName = d.kind === 'function'
            ? (d.className ? `${d.className}:${d.name}()` : `${d.name}()`)
            : d.name;
        const detailCopyText = detailDisplayName;

        let html = `<div class="detail-name" style="font-family:var(--font-mono);font-weight:700;font-size:16px;color:var(--vscode-textLink-foreground,#3794ff);word-break:break-all;margin-bottom:6px">${escapeHtml(detailDisplayName)}</div>`;

        html += `<div style="display:flex;align-items:center;gap:6px;flex-wrap:wrap;margin-bottom:8px">
            <span class="result-kind ${kindClass}">${kindLabel}</span>
            <span class="result-version ${verClass}">${d.version}</span>
            <span style="font-size:11px;opacity:0.6">${escapeHtml(d.module)}</span>
            <button class="copy-btn detail-copy-btn" data-copy="${escapeHtml(detailCopyText)}" title="复制名称">${SVG.copy}</button>
        </div>`;

        if (d.description) {
            html += `<div class="detail-section"><div class="detail-desc markdown-body">${renderMarkdown(d.description)}</div></div>`;
        }

        if (d.parameters && d.parameters.length > 0) {
            html += `<div class="detail-section">
                <div class="detail-section-title">参数</div>
                <div class="detail-grid">
                    <div class="grid-header"><span class="h-name">名称</span><span class="h-type">类型</span><span class="h-desc">说明</span></div>`;
            for (const p of d.parameters) {
                html += `<div class="grid-row"><span class="grid-cell cell-name">${escapeHtml(p.name)}</span><span class="grid-cell cell-type">${escapeHtml(p.type)}</span><span class="grid-cell cell-desc markdown-body">${renderMarkdownInline(p.desc)}</span></div>`;
            }
            html += `</div></div>`;
        }

        if (d.returns && d.returns.length > 0) {
            html += `<div class="detail-section">
                <div class="detail-section-title">返回值</div>
                <div class="detail-grid">
                    <div class="grid-header"><span class="h-type">类型</span><span class="h-desc">说明</span></div>`;
            for (const r of d.returns) {
                html += `<div class="grid-row"><span class="grid-cell cell-type">${escapeHtml(r.type)}</span><span class="grid-cell cell-desc markdown-body">${renderMarkdownInline(r.desc)}</span></div>`;
            }
            html += `</div></div>`;
        }

        if (d.fields && d.fields.length > 0) {
            const fieldTitle = FIELD_TITLES[d.kind] || '字段';
            html += `<div class="detail-section">
                <div class="detail-section-title">${fieldTitle}</div>
                <div class="detail-grid">
                    <div class="grid-header"><span class="h-name">名称</span><span class="h-type">类型</span><span class="h-desc">说明</span></div>`;
            for (const f of d.fields) {
                const fullName = d.name.includes('.') ? f.name : d.name + '.' + f.name;
                html += `<div class="grid-row"><span class="grid-cell cell-name">${escapeHtml(fullName)}</span><span class="grid-cell cell-type">${escapeHtml(f.type)}</span><span class="grid-cell cell-desc markdown-body">${renderMarkdownInline(f.desc)}</span></div>`;
            }
            html += `</div></div>`;
        }

        html += `<div class="detail-source">${escapeHtml(d.sourceFile)} : ${d.sourceLine}</div>`;
        el.detailContent.innerHTML = html;

        const detailCopyBtn = el.detailContent.querySelector('.detail-copy-btn');
        if (detailCopyBtn) {
            detailCopyBtn.addEventListener('click', () => copyToClipboard(detailCopyText, detailCopyBtn));
        }

        ensureDetailResizeObserver();
        if (detailResizeObserver) {
            detailResizeObserver.disconnect();
            el.detailContent.querySelectorAll('.detail-grid').forEach(g => detailResizeObserver.observe(g));
        }
        adjustDetailLayout();
    }

    let detailResizeObserver = null;

    function ensureDetailResizeObserver() {
        if (detailResizeObserver || typeof ResizeObserver === 'undefined') return;
        detailResizeObserver = new ResizeObserver(() => adjustDetailLayout());
    }

    function adjustDetailLayout() {
        const grids = el.detailContent.querySelectorAll('.detail-grid');
        for (const grid of grids) {
            const narrow = grid.offsetWidth < 500;
            const rows = grid.querySelectorAll('.grid-row');
            const header = grid.querySelector('.grid-header');

            for (const row of rows) {
                row.style.flexDirection = narrow ? 'column' : 'row';
                if (narrow) {
                    // 清除横排时 syncGridAlignment 写入的行内宽度约束
                    for (const cell of row.querySelectorAll('.grid-cell')) {
                        cell.style.flex = '';
                        cell.style.minWidth = '';
                        cell.style.overflow = '';
                        cell.style.textOverflow = '';
                    }
                }
            }
            if (header) {
                header.style.display = narrow ? 'none' : '';
            }
        }
        syncGridAlignment();
    }

    function syncGridAlignment() {
        const grids = el.detailContent.querySelectorAll('.detail-grid');
        for (const grid of grids) {
            const header = grid.querySelector('.grid-header');
            const rows = grid.querySelectorAll('.grid-row');
            if (!header || rows.length === 0) continue;
            if (header.style.display === 'none') continue;

            const headerCells = header.querySelectorAll('span');
            if (headerCells.length === 0) continue;

            // 批量读取，避免读写交替触发多次回流
            const widths = new Array(headerCells.length);
            for (let i = 0; i < headerCells.length; i++) {
                widths[i] = headerCells[i].offsetWidth;
            }

            for (const row of rows) {
                const cells = row.querySelectorAll('.grid-cell');
                cells.forEach((cell, i) => {
                    if (i < widths.length) {
                        cell.style.cssText = `flex:0 0 ${widths[i]}px;min-width:${widths[i]}px;overflow:hidden;text-overflow:ellipsis;`;
                    }
                });
            }
        }
    }

    function renderPagination(page, totalPages, onPaging) {
        if (totalPages <= 1) {
            el.pagination.innerHTML = '';
            return;
        }

        el.pagination.innerHTML = `
            <div class="page-nav-row">
                <button class="page-prev" ${page <= 1 ? 'disabled' : ''}>◀ 上一页</button>
                <button class="page-next" ${page >= totalPages ? 'disabled' : ''}>下一页 ▶</button>
            </div>
            <div class="page-input-row">
                <span class="page-info">第</span>
                <input type="number" class="page-input" value="${page}" min="1" max="${totalPages}" />
                <span class="page-info">/ ${totalPages} 页</span>
            </div>`;

        const prevBtn = el.pagination.querySelector('.page-prev');
        const nextBtn = el.pagination.querySelector('.page-next');
        const pageInput = el.pagination.querySelector('.page-input');

        prevBtn.addEventListener('click', () => { if (page > 1) onPaging(page - 1); });
        nextBtn.addEventListener('click', () => { if (page < totalPages) onPaging(page + 1); });
        pageInput.addEventListener('change', () => {
            let p = parseInt(pageInput.value, 10);
            if (isNaN(p) || p < 1) p = 1;
            if (p > totalPages) p = totalPages;
            onPaging(p);
        });
        pageInput.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') pageInput.dispatchEvent(new Event('change'));
        });
    }

    function renderSearchResultsPage(data) {
        hideLoading();
        state.currentPage = data.page || 1;
        state.totalPages = data.totalPages || 1;
        state.totalCount = data.totalCount || 0;

        const pageItems = data.results || [];
        const total = state.totalCount;
        const end = Math.min(state.currentPage * PAGE_SIZE, total);

        if (total === 0) {
            renderEmpty('未找到匹配结果', '尝试使用更短的搜索词，或调整筛选条件');
            el.stats.textContent = data.totalCount + ' 条 API · 无匹配结果';
            return;
        }

        el.stats.textContent = `${end} / ${total} 条结果`;

        el.results.innerHTML = '';
        pageItems.forEach((item, idx) => {
            const card = document.createElement('div');
            card.className = `result-item version-${item.version.replace('.', '\\.')}`;

            const kindLabel = KIND_LABELS[item.kind] || item.kind;

            const metaParts = [];
            if (item.kind === 'function') {
                if (item.paramCount > 0) metaParts.push(`${item.paramCount} 参数`);
                if (item.returnCount > 0) metaParts.push(`${item.returnCount} 返回值`);
            } else if (item.kind === 'enum' || item.kind === 'event') {
                if (item.fieldCount > 0) metaParts.push(`${item.fieldCount} 字段`);
            }

            const briefDesc = item.description ? item.description.split('\n')[0] : '';
            const paramsPreview = item.parameters && item.parameters.length > 0
                ? item.parameters.map(p => `<code>${escapeHtml(p.name)}: ${escapeHtml(p.type)}</code>`).join(', ')
                : '';
            const displayName = item.displayName || item.name;

            card.innerHTML = `
                <div class="result-header">
                    <span class="result-name">${escapeHtml(displayName)}</span>
                </div>
                <div class="result-tags">
                    <span class="result-kind kind-${item.kind}">${kindLabel}</span>
                    <span class="result-version version-${item.version}-tag">${item.version}</span>
                    <span class="result-module">${escapeHtml(item.module)}</span>
                    <button class="copy-btn result-copy-btn" data-copy="${escapeHtml(displayName)}" title="复制名称">${SVG.copy}</button>
                </div>
                ${briefDesc ? '<div class="result-desc">' + escapeHtml(briefDesc) + '</div>' : ''}
                ${paramsPreview ? '<div class="result-meta">' + paramsPreview + '</div>' : ''}
                ${metaParts.length > 0 ? '<div class="result-meta">' + metaParts.join(' · ') + '</div>' : ''}
            `;

            card.style.animationDelay = (Math.min(idx, FADE_IN_MAX) * 0.03) + 's';

            const copyBtn = card.querySelector('.result-copy-btn');
            copyBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                copyToClipboard(displayName, copyBtn);
            });
            card.addEventListener('click', () => showDetail(item.name, item.sourceFile, item.sourceLine, item.kind));
            el.results.appendChild(card);
        });

        renderPagination(state.currentPage, state.totalPages, (newPage) => doSearch(newPage));
    }

    function copyToClipboard(text, btn) {
        const showFeedback = () => {
            btn.innerHTML = SVG.check;
            btn.classList.add('copied');
            setTimeout(() => {
                btn.innerHTML = SVG.copy;
                btn.classList.remove('copied');
            }, COPY_FEEDBACK_MS);
        };
        navigator.clipboard.writeText(text).then(showFeedback).catch(() => {
            vscode.postMessage({ type: 'copy', text });
            showFeedback();
        });
    }

    function renderMarkdown(text) {
        if (!text) return '';
        try {
            return marked.parse(text);
        } catch (e) {
            console.warn('Markdown 渲染失败:', e);
            return escapeHtml(text);
        }
    }

    function renderMarkdownInline(text) {
        if (!text) return '';
        try {
            return marked.parseInline(text);
        } catch (e) {
            console.warn('Markdown 行内渲染失败:', e);
            return escapeHtml(text);
        }
    }

    function escapeHtml(str) {
        if (str == null) return '';
        return String(str).replace(HTML_ESCAPE_RE, (c) => HTML_ESCAPE_MAP[c]);
    }

    // 点击外部关闭下拉
    document.addEventListener('click', (e) => {
        if (!el.moduleSelect.contains(e.target)) closeDropdown();
    });

    // 模块下拉：触发按钮 + 选项点击（事件委托，选项变化时无需重新绑定）
    el.selectTrigger.addEventListener('click', (e) => {
        e.stopPropagation();
        toggleDropdown();
    });
    el.selectDropdown.addEventListener('click', (e) => {
        const opt = e.target.closest('.select-option');
        if (!opt) return;
        e.stopPropagation();
        applyModuleSelection(opt.dataset.value, opt.textContent);
    });

    // 一级：类型标签页（函数/枚举/事件/ID）
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', () => {
            const value = tab.dataset.value;
            document.querySelectorAll('.tab').forEach(t => {
                t.classList.remove('active');
                t.setAttribute('aria-selected', 'false');
            });
            tab.classList.add('active');
            tab.setAttribute('aria-selected', 'true');
            state.activeTab = value;

            if (value === 'id') {
                el.secondFilters.classList.add('hidden');
                el.idFilters.classList.remove('hidden');
                renderIdView();
                return;
            }

            el.secondFilters.classList.remove('hidden');
            el.idFilters.classList.add('hidden');
            state.kind = value;

            if (MODULE_DISABLED_KINDS.has(value)) {
                setModuleFilterEnabled(false);
                setModuleAll();
            } else {
                setModuleFilterEnabled(true);
            }
            doSearch(1);
        });
    });

    // 二级：版本筛选按钮
    document.querySelectorAll('.filter-btn[data-filter="version"]').forEach(btn => {
        btn.addEventListener('click', () => {
            const value = btn.dataset.value;
            document.querySelectorAll('.filter-btn[data-filter="version"]').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            state.version = value;
            updateModuleOptions(value);
            doSearch(1);
        });
    });

    // ID 分类筛选（道具/生物/状态）
    document.querySelectorAll('#idFilters .filter-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const cat = btn.dataset.idCategory;
            document.querySelectorAll('#idFilters .filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            state.idCategory = cat;
            state.idCurrentPage = 1;
            renderIdView();
        });
    });

    // 搜索输入：防抖 + 清空按钮显隐
    let debounceTimer;
    el.searchInput.addEventListener('input', () => {
        el.searchClear.classList.toggle('visible', el.searchInput.value.length > 0);
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
            handleQueryChange(el.searchInput.value);
        }, SEARCH_DEBOUNCE_MS);
    });

    el.searchClear.addEventListener('click', () => {
        clearQuery();
        el.searchInput.focus();
    });

    el.detailBack.addEventListener('click', () => setActiveView('search'));

    window.addEventListener('message', event => {
        const msg = event.data;
        switch (msg.type) {
            case 'initData': {
                state.modules20 = msg.modules20 || [];
                state.modules30 = msg.modules30 || [];
                if (msg.idData !== undefined) {
                    state.idData = msg.idData;
                    state.idDataVersion = msg.idDataVersion ?? 0;
                    invalidateIdCache();
                }
                updateModuleOptions(state.version);
                state.totalCount = msg.counts?.total ?? 0;

                if (msg.counts) {
                    const c = msg.counts;
                    el.stats.textContent = `${c.total} 条 API（函数 ${c.func} · 枚举 ${c.enum} · 事件 ${c.event}）`;
                }
                hideLoading();

                if (state.activeTab === 'id') {
                    renderIdView();
                } else {
                    doSearch(1);
                }
                break;
            }

            case 'idData':
                state.idData = msg.data || { item: {}, actor: {}, buff: {} };
                state.idError = msg.error || '';
                state.idDataVersion = msg.version ?? state.idDataVersion + 1;
                invalidateIdCache();
                if (state.activeTab === 'id') renderIdView();
                break;

            case 'searchResults':
                renderSearchResultsPage(msg);
                break;

            case 'detailResult':
                if (msg.error) {
                    el.detailContent.innerHTML =
                        `<div class="empty">
                            <div class="empty-icon">${SVG.search}</div>
                            <div class="title">${escapeHtml(msg.error)}</div>
                        </div>`;
                } else {
                    renderDetail(msg.detail);
                }
                break;
        }
    });

    el.searchClear.classList.toggle('visible', el.searchInput.value.length > 0);
    vscode.postMessage({ type: 'ready' });
})();