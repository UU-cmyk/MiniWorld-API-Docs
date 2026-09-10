<div align="center">

# MiniWorld-API-Desc

API declaration library, code completion plugin, and auxiliary toolset for MiniWorld UGC Lua development.

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

> **No longer recommended to use declaration files for declarations, declaration plugins are recommended.**  
> After installing this extension, you can automatically configure declaration paths by executing corresponding commands via `Ctrl+Shift+P`, no manual operation required.

📚 **Table of Contents**

- [Quick Start](#quick-start)
- [API Search](#api-search)
- [Plugin Commands](#plugin-commands)
- [Project Structure](#project-structure)
- [Tool Scripts](#tool-scripts)
- [AI Usage Recommendations](#ai-usage-recommendations)
- [Building from Source](#building-from-source)
- [Applicability](#applicability)
- [Contributing Guidelines](#contributing-guidelines)
- [Important Notes](#important-notes)
- [License](#license)

---

Provides complete Lua type declaration files,配合 VS Code's [Lua Language Service (sumneko.lua)](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) to get intelligent completion, type hints, and parameter documentation; also provides event completion plugins, code snippet templates, and API comparison scripts to enhance UGC component development efficiency.

## Quick Start

### Prerequisites

| Dependency | Required | Description |
| :-- | :-: | :-: |
| [VS Code](https://code.visualstudio.com/) | Yes | Provides code completion, type hints, and other features |
| [Lua Language Service Plugin (sumneko.lua)](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) | Yes | Provides Lua language service, plugin installation required |
| Python 3.10+ | No | Only required when using tool scripts |
| Node.js | No | Only required when building extension from source |
| PowerShell 5.1+ | No | Only required when building extension from source |

### Install Extension

1. Download `.vsix` file from [GitHub Releases](https://github.com/LK-cmyk/MiniWorld-API-Desc/releases)
2. Open Extensions panel (`Ctrl+Shift+X`)
3. Click `···` in top-right corner → `Install from VSIX...`
4. Select the downloaded `.vsix` file

After installation, press `Ctrl+Shift+P` and execute any of the following commands to enable type hints

- `MiniWorld API Description: Add MiniWorld UGC 3.0 Declaration`
- `MiniWorld API Description: Add MiniWorld UGC 2.0 Declaration`

> 💡 2.0 and 3.0 declarations are mutually exclusive and cannot coexist

### First Use Workflow

When opening any `.lua` file, the plugin automatically checks if declaration paths are configured. If not configured, a prompt window appears:

| Option | Behavior |
| :-: | :-: |
| **Do not add declaration** | No prompt for 4 hours |
| **Never remind** | Never prompt again |
| **Add 2.0 / 3.0 declaration** | Opens scope selection, writes declaration path to specified scope |

## Plugin Commands

Press `Ctrl+Shift+P` to open command palette, enter keyword `MiniWorld` to find the following commands:

| Command | Description |
| :-: | :-: |
| `MiniWorld API Description: Add MiniWorld UGC 2.0 Declaration` | Add 2.0 declaration directory to `Lua.workspace.library` |
| `MiniWorld API Description: Remove MiniWorld UGC 2.0 Declaration` | Remove 2.0 declaration directory from configuration |
| `MiniWorld API Description: Add MiniWorld UGC 3.0 Declaration` | Add 3.0 declaration directory to `Lua.workspace.library` |
| `MiniWorld API Description: Remove MiniWorld UGC 3.0 Declaration` | Remove 3.0 declaration directory from configuration |
| `MiniWorld API Description: Open API Search` | Open API search panel for quick search of functions, enums, events |
| `MiniWorld API Description: Refresh API Search Index` | Rescan declaration files and update search index |

### Scopes

- When executing add/remove commands, you can choose the scope for configuration writing

  | Scope | Description |
  | :-: | :-: |
  | **Global** | Write to user settings, effective for all workspaces |
  | **Workspace** | Write to `.vscode/settings.json`, effective only for current workspace |
  | **WorkspaceFolder** | Write to workspace folder settings |

The plugin automatically filters available options based on the current configuration status of each scope: when adding, only shows scopes that do not include the declaration; when removing, only shows scopes that already include the declaration

### Usage Examples

```lua
-- Example using type hints
local actor = MNActor.create("testActor")
local pos = actor:GetPosition()  -- Smart completion and type hints
actor:SetPosition(pos.x + 1, pos.y, pos.z)
```

```lua
-- Using event system
local function onPlayerJoin(player)
    print("Player joined: " .. player.name)
end

MNGame.addEventListener("onPlayerJoin", onPlayerJoin)
```

## API Search

v0.6.1 introduces the **API Search Panel**, supporting quick search of all MiniWorld APIs in the VS Code sidebar without leaving the editor to browse documentation

### Opening Methods

| Method | Operation |
| :-: | :-: |
| **Command Palette** | `Ctrl+Shift+P` → Enter **MiniWorld API Description: Open API Search** |
| **Sidebar Button** | Click the 🔍 **MiniWorld API Search** icon in the left activity bar |

### Feature Introduction

- **Fuzzy Search** — Enter keywords to fuzzy match by name, parameters, description, supports first-letter abbreviations (e.g., enter `GP` to match `GetPosition`)
- **Filtering** — Filter by version (2.0 / 3.0), module, type (function / enum / event)
- **Detail View** — Click search results to view complete parameter lists, return values, enum values, and event parameters
- **Click to Jump** — Click result entries to jump to the source code location of the corresponding declaration file
- **Refresh Index** — Execute **MiniWorld API Description: Refresh API Search Index** command to rescan declaration files

### Keyboard Shortcuts

Press `Ctrl+K` in the search input box to quickly clear search content.

## Project Structure

The repository is organized into separate layers for extension code, declaration sources, tooling, and worker services, which keeps the project easier to maintain and extend:

```bash
MiniWorld-API-Desc/
├── addon/                    # VS Code extension source and extension environment
│   ├── src/                 # TypeScript entry points and logic
│   ├── out/                 # build artifacts (generated)
│   ├── package.json         # extension manifest / npm scripts
│   ├── tsconfig.json        # TypeScript config
│   ├── eslint.config.mjs    # ESLint config
│   ├── .vscodeignore        # publish ignore rules
│   ├── .vscode-test.mjs     # VS Code test config
│   └── README.md            # extension-specific documentation
├── declarations/             # versioned Lua declaration source files
│   ├── 2.0/
│   └── 3.0/
├── tools/                    # Python tooling and shared logic
│   ├── common/              # reusable parsing, compare, and merge logic
│   ├── main.py              # unified CLI entry point
│   ├── pack.py              # VSIX packaging script
│   ├── out.py               # output packaging tool
│   └── README.md            # tool usage notes
├── server/                   # Cloudflare Worker / API proxy
│   ├── src/
│   └── test/
├── docs/                     # API references and docs
├── img/                      # icons and assets
├── out/                      # generated reports and packaged artifacts
├── .github/                  # GitHub settings
├── .vscode/                  # local editor configuration
├── config.ini                # local configuration
├── config.example.ini        # config template
├── pyproject.toml            # Python dependency config
├── README.md                 # Chinese documentation
├── README.en.md              # English documentation
├── LICENSE                   # license
├── uv.lock                   # Python lockfile
├── package-lock.json         # root lockfile if workspace installs are used
└── node_modules/             # local dependencies (generated as needed)
```

### Structure Principles

- `addon/` contains only VS Code extension logic, not declaration source files.
- `declarations/` keeps declaration sources split by version and module for easier reviews and merges.
- `tools/` groups all automation in one place, avoiding scattered version-specific scripts.
- `server/` handles worker-side functionality separately from the local VS Code extension.
- `out/` is reserved for generated files and artifacts only.

## Tool Scripts

Run the following commands from the repo root (requires Python 3.12+, see `pyproject.toml`):

### Unified CLI

| Category | Command | Description |
| :-: | :-- | :-: |
| List all commands | `python tools/main.py list` | Show supported actions |
| Compare functions | `python tools/main.py compare func --version 2.0` | Compare 2.0 function differences |
| Compare events | `python tools/main.py compare event --version 3.0` | Compare 3.0 event differences |
| Compare enums | `python tools/main.py compare enum --version 3.0` | Compare 3.0 enum differences |
| Full comparison | `python tools/main.py compare all` | Run all comparison types |
| Merge declarations | `python tools/main.py merge --version 3.0` | Merge 3.0 source declarations |
| Generate AI text | `python tools/main.py desc --version 3.0` | Generate AI-friendly description docs |
| Save results to file | `python tools/main.py compare all --output out/report.txt` | Write comparison results to a file |

### Build and Packaging

| Category | Command | Description |
| :-: | :-- | :-: |
| Package extension | `python tools/pack.py` | Compile + lint + package VSIX |
| Compile only | `python tools/pack.py --compile-only` | Run compile only |
| Clean output | `python tools/pack.py --clean` | Remove generated build artifacts |
| Worker build | `npm run build:worker` | Build the Cloudflare Worker |
| Extension build | `cd addon; npm run compile` | Compile the TypeScript extension |

### Notes

- The unified entry point is `tools/main.py`, and shared logic lives under `tools/common/`.
- Older version-specific scripts like `tools/3.0` and `tools/2.0` have been consolidated into a single CLI to reduce duplication.
- Exported build artifacts can be assembled with `python tools/out.py` when you want a single packaging workflow.

## AI Usage Recommendations

Providing the following file contents to AI assistants can help them understand UGC:

- UGC 3.0
  - [SKILL.md](./docs/miniworld-ugc-30/SKILL.md)
  - [API.txt](./docs/miniworld-ugc-30/references/API.txt)
- UGC 2.0
  - [API.txt](./docs/miniworld-ugc-20/references/API.txt)

## Building from Source

Requires Node.js environment. Execute in the project root directory:

### Build Options

| Command | Description |
| :-- | :-: |
| `./pack.ps1` | Complete build (compile + check + package) |
| `./pack.ps1 -CompileOnly` | Compile only, do not package |
| `./pack.ps1 -SkipLint` | Skip lint check |
| `./pack.ps1 -SkipInstall` | Skip npm install |
| `./pack.ps1 -Clean` | Clean build output only |

### Build Process

```bash
npm install # 1. Install dependencies
tsc # 2. Compile TypeScript
./pack.ps1 # 3. Package extension
code --install-extension MiniWorld-API-Desc.vsix # 4. Install extension (optional)
```

After packaging, a `.vsix` file will be generated in the root directory, which can be directly installed to VS Code.

## Applicability

| Project | Version |
| :-- | :-: |
| MiniWorld Game | v1.58+ |
| UGC Development Kit | 3.0 & 2.0 |
| Python | 3.10+ |
| VS Code | ^1.125.0 |

### System Requirements

- **Operating System**: Windows, macOS, Linux
- **Memory**: Minimum 4GB RAM
- **Storage**: Minimum 100MB available space
- **Network**: Stable internet connection (for downloading extensions)

### Known Limitations

- Only supports UGC 3.0 and 2.0 versions
- Some advanced features may require VS Code restart
- Large projects may require VS Code performance adjustments

## Important Notes

- This repository's declaration files and extension are only for **UGC 3.0** & **UGC 2.0**, do not use for other versions
- Some interfaces may differ from actual game versions, please refer to actual game behavior
- If you find issues or need API additions, welcome to submit [Issues](https://github.com/LK-cmyk/MiniWorld-API-Desc/issues) or create Pull Requests

## Star History

[![Star History Chart](https://api.star-history.com/chart?repos=UU-cmyk/MiniWorld-API-Desc&type=date&legend=top-left&sealed_token=4cyhbjVHKRN0PDaVtuWiTHVlDqVePSy4bhXV9-kk7E4mAvoA3Trj5OWw-BoAwRDDB-V8WyDJgFxBYsSqzpp4ygy20daMLZUrhQOa_RA0OYiQkMPonOTlgOHkVJbJczSog89zshYnQf_PDPnhpIOlre6oK7jsVZks9VhrSXEotmzuzAJpl-EIvX9jgxKz)](https://www.star-history.com/?repos=UU-cmyk%2FMiniWorld-API-Desc&type=date&legend=top-left)

## Contributing Guidelines

Welcome to contribute code or submit issues to this project!

### Reporting Issues

- Use [GitHub Issues](https://github.com/LK-cmyk/MiniWorld-API-Desc/issues) to report bugs
- Provide detailed reproduction steps and error information
- Attach relevant code snippets and logs

## License

This project is licensed under the [MIT](./LICENSE) license
