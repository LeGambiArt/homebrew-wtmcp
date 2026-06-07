# homebrew-wtmcp

Homebrew tap for [wtmcp](https://github.com/LeGambiArt/wtmcp) — an MCP server with plugin-based integrations for developer tools.

## Install

```bash
brew tap LeGambiArt/wtmcp
brew install --HEAD wtmcp
```

## Usage

```bash
wtmcp --version
wtmcpctl --version
```

Plugins are installed to `$(brew --prefix)/share/wtmcp/plugins/`.

Configure credentials in `~/.config/wtmcp/env.d/`.
