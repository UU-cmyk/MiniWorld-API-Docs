<div align="center">

# MiniWorld-API-Desc

MiniWorld UGC Lua API declaration library, code completion plugin, and supporting toolset.

![GitHub stars](https://img.shields.io/github/stars/LK-cmyk/MiniWorld-API-Desc?style=flat)
![GitHub forks](https://img.shields.io/github/forks/LK-cmyk/MiniWorld-API-Desc?style=flat)
![License](https://img.shields.io/github/license/LK-cmyk/MiniWorld-API-Desc)
![VS Code](https://img.shields.io/badge/VS%20Code-^1.125.0-blue)
![Lua](https://img.shields.io/badge/Lua-5.1%2B-yellow)
<br>

![UGC 3.0](https://img.shields.io/badge/UGC-3.0-blue)
![UGC 2.0](https://img.shields.io/badge/UGC-2.0-blue)

[![Chinese Version README](https://img.shields.io/badge/Chinese-README-blue?logo=markdown)](./README.md)
</div>

> This repo provides the VS Code extension and declaration files, and it's recommended to use the extension to automatically manage declarations.

## Overview

MiniWorld API Description is a VS Code extension designed to:

- provide Lua type declarations for UGC 2.0 and 3.0
- switch completion behavior through `miniworld.completion`
- provide API search from the sidebar
- offer event completion and cache cleanup support

## Features

### 1. Type declarations and completion

The extension automatically syncs the corresponding declaration directory to Lua language service according to the `miniworld.completion` setting.

Supported values:

| Value | Behavior |
| :-: | :-: |
| `2.0` | Loads UGC 2.0 declarations and enables 2.0 event completion |
| `3.0` | Loads UGC 3.0 declarations and enables 3.0 event completion |
| `off` | Removes MiniWorld declarations and disables event completion |

The default value is `2.0`. The extension automatically updates the global `Lua.workspace.library` configuration and removes stale entries from older versions.

### 2. API Search

The extension includes a sidebar API search view that lets you search in-editor for:

- functions
- enums
- events

### 3. Event completion

The extension provides event completion in scenarios such as `ScriptSupportEvent([=[...]=])` and after `TriggerEvent.` / `ObjectEvent.` for UGC 3.0.

### 4. Cache management

There is a command to clear ID data cache so the extension can re-download and refresh cached data.

## Installation and usage

### Prerequisites

- [VS Code](https://code.visualstudio.com/) ^1.125.0
- [Lua Language Server](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)

### Install

1. Download the published `.vsix` package
2. In VS Code, open Extensions → `···` → `Install from VSIX...`
3. Select the file and install it

### First-time setup

Open any `.lua` file and the extension will automatically synchronize the declaration version according to the current `miniworld.completion` setting, usually without manual configuration.

## Extension commands

Press `Ctrl+Shift+P` to access the following commands:

| Command | Description |
| :-: | :-: |
| `MiniWorld API Description: 添加 MiniWorld UGC 声明` | Select a version and set `miniworld.completion`; the extension will sync the matching declarations |
| `MiniWorld API Description: 清除 MiniWorld UGC 补全` | Clear the completion setting and disable completion |
| `MiniWorld API Description: 打开 API 搜索` | Open the sidebar API search view |
| `MiniWorld API Description: 刷新 API 搜索索引` | Rescan declarations and refresh the index |
| `MiniWorld API Description: 清空 ID 数据缓存` | Clear cached ID data and redownload it |

## Configuration

The extension supports the following settings:

| Setting | Description |
| :-: | :-: |
| `miniworld.completion` | Controls completion mode: `2.0`, `3.0`, or `off` |
| `miniworld.serverUrl` | Server address used to download ID data; defaults to `desc.cmyk.dpdns.org` |

## Compatibility

| Project | Version |
| :-: | :-: |
| MiniWorld game | relevant UGC versions |
| UGC SDK | 2.0 / 3.0 |
| VS Code | ^1.125.0 |

## AI

- UGC 3.0
  - [API.txt](./docs/miniworld-ugc-30/references/API.txt)
  - [SKILL.md](./docs/miniworld-ugc-30/SKILL.md)
- UGC 2.0
  - [API.txt](./docs/miniworld-ugc-20/references/API.txt)

## Repository structure

```bash
MiniWorld-API-Desc/
├── addon/  # VS Code extension source
├── declarations/  # UGC 2.0 / 3.0 declaration sources
├── docs/  # docs and reference material
├── tools/  # Python utility scripts
├── server/  # Cloudflare Worker service
├── README.md  # Chinese documentation
├── README.en.md  # English documentation
├── pyproject.toml  # Python dependency config
├── LICENSE  # license
└── ...
```

## Notes

- This extension targets UGC 2.0 / 3.0 only
- Some APIs may differ from real in-game behavior; the game behavior is the final authority
- If you find bugs or want to contribute extra API data, feel free to open an Issue or submit a PR

## License

This project is licensed under the [MIT](./LICENSE) license
