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
