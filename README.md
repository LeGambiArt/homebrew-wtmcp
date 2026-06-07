# homebrew-wtmcp

Homebrew tap for [wtmcp](https://github.com/LeGambiArt/wtmcp) — an MCP server with plugin-based integrations for developer tools.

## Installation

```bash
brew tap LeGambiArt/wtmcp
brew install wtmcp
```

To install the latest development version directly from the `main` branch, use:

```bash
brew install --HEAD wtmcp
```

> **Note:** HEAD builds track unreleased changes and may be unstable. Tagged releases are recommended for production use.

## Usage

```bash
wtmcp --version
wtmcpctl --version
```

Plugins are installed to `$(brew --prefix)/share/wtmcp/plugins/`.

Configure credentials in `~/.config/wtmcp/env.d/`.

### User Plugins

User plugins can be installed to `~/.config/wtmcp/plugins/`. They are disabled by default. To enable them, run:

```bash
wtmcpctl plugins user-plugins enable
```

User plugins cannot override system plugins, declare authentication providers, or use symlinks in handler paths.

### Agent Configuration

To configure the MCP server for an agent in the current project directory, run:

```bash
wtmcpctl agent enable <agent>
```

Supported agents: `claude-code`, `gemini`, `cursor`.

This writes the MCP server configuration to the agent's config file (e.g., `.mcp.json` for Claude Code). To remove it:

```bash
wtmcpctl agent disable <agent>
```
