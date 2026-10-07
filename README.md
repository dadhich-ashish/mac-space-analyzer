# Mac Space Analyzer

A hierarchical folder space analyzer for macOS that shows disk usage in both CLI and web interface.

## Features

- 📊 Hierarchical tree visualization
- 🌐 Web interface with interactive expand/collapse
- 💻 CLI tool for quick analysis
- 📈 Real-time size calculations
- 🎯 Custom folder analysis
- 🚀 Fast and lightweight

## Requirements

- macOS 10.12+
- Node.js 14+ (will be checked during installation)

## Installation

### Option 1: Direct Installation (Recommended)

```bash
bash install.sh
```

This will:
- Install dependencies
- Create command shortcuts
- Update your shell configuration

### Option 2: DMG Installer (For Distribution)

```bash
bash create-dmg.sh
```

Creates `MacSpaceAnalyzer-1.0.0.dmg` for easy distribution.

## Usage

### CLI Commands

```bash
# Analyze home directory (default)
space-analyzer

# Analyze specific folder
space-analyzer /Users/username/Documents

# Analyze with custom depth
space-analyzer /path/to/folder 5
```

### Web Interface

```bash
space-analyzer-web
```

Then visit `http://localhost:3000` in your browser.

## Features

- **Expandable Tree View**: Click to expand/collapse folders
- **Real-time Analysis**: Enter any path to analyze
- **Size Display**: Human-readable file sizes (B, KB, MB, GB, TB)
- **Statistics**: Total size, item count, current path
- **Home Button**: Quick return to home directory

## Uninstall

```bash
bash uninstall.sh
```

Or manually:

```bash
rm -rf ~/.local/opt/mac-space-analyzer
rm ~/.local/bin/space-analyzer
rm ~/.local/bin/space-analyzer-web
```

## Performance

- Handles large directories efficiently
- Skips permission-denied folders automatically
- Configurable depth to limit recursion
- Optimized for macOS file systems

## Troubleshooting

**Command not found after installation?**

Restart your terminal or run:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

**Permission denied errors?**

Some system folders require elevated permissions. Run with sudo if needed:
```bash
sudo space-analyzer /System
```

**Web interface won't start?**

Ensure port 3000 is available or modify `server.js` to use a different port.

## License

MIT

## Support

For issues, run `space-analyzer --help` or check the repository.
