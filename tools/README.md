# Tools 说明

本目录集中放置 MiniWorld-API-Desc 的 Python 工具脚本，用于：

- 对比本地声明与网页 API 文档的差异
- 合并不同版本的 Lua 声明文件
- 生成 AI 可直接读取的描述文档
- 打包扩展产物并导出最终文件
- 上传 JSON 数据到服务端 Worker

## 目录结构

```bash
tools/
├── common/  # 公共逻辑：解析、比较、合并、配置、运行器
├── main.py  # 统一命令入口
├── pack.py  # VS Code 扩展打包脚本
├── out.py  # 导出压缩包与 VSIX 的批处理脚本
└── README.md  # 本说明文件
```

## 前置条件

- Python 3.12+
- 已安装项目依赖

推荐在仓库根目录执行：

```bash
python -m pip install -e .
```

如果项目使用的是 uv，也可以：

```bash
uv sync
```

## 统一入口：main.py

在仓库根目录执行：

```bash
python tools/main.py --help
```

支持的主要命令如下：

### 1. 对比 API 差异

```bash
python tools/main.py compare func --version 2.0
python tools/main.py compare enum --version 3.0
python tools/main.py compare event --version 2.0
python tools/main.py compare all
python tools/main.py compare all --output out/report.txt
```

参数说明：

- `func`：函数差异
- `enum`：枚举差异
- `event`：事件差异
- `all`：全部类型
- `--version 2.0|3.0|all`：指定版本
- `--output`：将结果写入文件

### 2. 合并声明文件

```bash
python tools/main.py merge --version 2.0
python tools/main.py merge --version 3.0
```

用于把 `declarations/2.0` 或 `declarations/3.0` 中的 Lua 声明文件合并为可供后续处理的统一输出。

### 3. 生成 AI 描述文档

```bash
python tools/main.py desc --version 2.0
python tools/main.py desc --version 3.0
```

将合并后的声明转换成 AI 更适合读取的描述文件，供后续文档分析或模型使用。

### 4. 批量运行全部对比

```bash
python tools/main.py all
python tools/main.py all --output out/report.txt
```

等价于批量执行 `func + enum + event` 的全版本对比。

### 5. 列出全部命令

```bash
python tools/main.py list
```

### 6. 上传 JSON 到 Worker

```bash
python tools/main.py upload --type item --file out/data.json
```

此外还支持：

- `--url`：自定义 Worker 地址
- `--token`：指定上传 token

## pack.py：扩展打包

`pack.py` 负责把 VS Code 扩展打包成 `.vsix` 文件，流程大致包括：

1. 清理旧编译输出
2. 执行 `npm install`
3. 执行 `npm run compile`
4. 执行 ESLint 检查
5. 打包为 VSIX

常用命令：

```bash
python tools/pack.py
python tools/pack.py --compile-only
python tools/pack.py --clean
python tools/pack.py --skip-install
python tools/pack.py --skip-lint
```

说明：

- `--compile-only`：只编译，不打包
- `--clean`：仅清理输出目录
- `--skip-install`：跳过 npm install
- `--skip-lint`：跳过 ESLint

## out.py：集中导出

`out.py` 会执行一组最终产出动作：

- 生成 2.0 / 3.0 AI 描述压缩包
- 执行扩展打包
- 将生成的 VSIX 文件移动到 `out/` 目录

常用命令：

```bash
python tools/out.py
```

输出目录通常为：

```bash
out/
├── ai-desc-2.0.zip
├── ai-desc-3.0.zip
├── miniworld-api-desc-addon.vsix
└── report.txt   # 若执行 compare --output 时生成
```

## 常见工作流

### 生成对比报告

```bash
python tools/main.py compare all --output out/report.txt
```

### 生成 AI 文档

```bash
python tools/main.py desc --version 3.0
```

### 构建扩展包

```bash
python tools/pack.py
```

### 最终统一导出

```bash
python tools/out.py
```

## 设计说明

工具链按职责分层：

- `main.py`：负责命令解析与 CLI 入口
- `common/`：负责解析、比较、配置、模型、合并逻辑
- `pack.py`：负责扩展打包
- `out.py`：负责最终导出流程

这样可以避免脚本散落到版本目录中，同时方便后续扩展更多 API 版本或分析任务。

## 相关文件

- [README.md](../README.md)：项目总说明
- [pyproject.toml](../pyproject.toml)：Python 依赖配置
- [declarations/](../declarations)：本地 Lua 声明源文件
- [addon/](../addon)：VS Code 扩展源码
