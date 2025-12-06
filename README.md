# Homebrew Tap for copilot-exporter

This tap provides the Homebrew formula for [github-copilot-chat-exporter](https://github.com/pandaxbacon/github-copilot-chat-exporter).

## Installation

```bash
brew tap pandaxbacon/tap
brew install copilot-exporter
```

## Usage

```bash
# First-time authentication
copilot-exporter --mode login --url https://github.com/copilot/share/YOUR-SHARE-ID

# Export conversations
copilot-exporter --mode run --url https://github.com/copilot/share/YOUR-SHARE-ID --pdf
```

## About

Export GitHub Copilot shared conversations to clean Markdown and PDF formats. No API key required!

**Features:**
- ✅ Authenticated access via manual login
- ✅ Markdown and PDF export
- ✅ Headless automation with Playwright
- ✅ Works on macOS and Linux

## Links

- **Main Repository:** https://github.com/pandaxbacon/github-copilot-chat-exporter
- **Issues:** Report issues on the main repository

## License

MIT License - See main repository for details.

