# GitHub Codespaces Setup Guide

This document explains how the GitHub Codespaces environment is configured for Lean 4 and Homotopy Type Theory development.

## 🏗️ Architecture

The Codespaces environment consists of:

1. **Base Container**: Ubuntu 22.04 with common development tools
2. **Lean 4**: Installed via elan (Lean version manager)
3. **VS Code Extensions**: Lean 4 extension for interactive theorem proving
4. **Project Dependencies**: Mathlib4 and project-specific libraries

## 📁 Configuration Files

### `.devcontainer/devcontainer.json`

This is the main configuration file for GitHub Codespaces:

```json
{
  "name": "Lean 4 - Homotopy Type Theory",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu-22.04",
  "features": { ... },
  "customizations": { ... },
  "postCreateCommand": "bash .devcontainer/setup.sh"
}
```

**Key sections:**

- **image**: Base Docker image (Ubuntu 22.04)
- **features**: Additional tools (Git, GitHub CLI, zsh)
- **customizations.vscode.extensions**: Required VS Code extensions
  - `leanprover.lean4` - Lean 4 language support
  - `GitHub.copilot` - AI pair programming
  - `GitHub.copilot-chat` - AI assistance
- **customizations.vscode.settings**: Lean-specific settings
- **postCreateCommand**: Script to run after container creation

### `.devcontainer/setup.sh`

Automated setup script that runs when the Codespace is created:

```bash
#!/bin/bash
set -e

# 1. Install elan (Lean version manager)
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --default-toolchain none

# 2. Add elan to PATH
export PATH="$HOME/.elan/bin:$PATH"

# 3. Install Lean toolchain from lean-toolchain file
elan toolchain install

# 4. Fetch project dependencies
lake update

# 5. Build the project
lake build
```

**What it does:**

1. Installs elan (Lean's version manager)
2. Configures the PATH for the current and future sessions
3. Installs the Lean version specified in `lean-toolchain`
4. Downloads all project dependencies (including Mathlib4)
5. Builds the entire project

### `lean-toolchain`

Specifies the exact Lean version to use:

```
leanprover/lean4:v4.13.0
```

This ensures everyone uses the same Lean version for consistency.

### `lakefile.lean`

Lake is Lean's build system and package manager. This file configures:

- Package name and metadata
- Library and executable targets
- External dependencies (like Mathlib4)

```lean
package «vml» where
  -- package configuration

lean_lib «VML» where
  -- library configuration

@[default_target]
lean_exe «vml» where
  root := `Main

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.13.0"
```

## 🚀 Startup Process

When you create or open a Codespace:

1. **Container Creation** (~30 seconds)
   - GitHub spins up the Ubuntu container
   - Installs specified features (Git, GitHub CLI, etc.)

2. **Post-Create Script** (~2-3 minutes)
   - Runs `.devcontainer/setup.sh`
   - Installs elan and Lean 4
   - Downloads dependencies (~200 MB for Mathlib4)
   - Builds the project

3. **VS Code Initialization** (~10 seconds)
   - Installs Lean 4 extension
   - Configures workspace settings
   - Starts Lean language server

4. **Ready to Code!** ✅
   - Open any `.lean` file
   - See live feedback as you type
   - Auto-completion and error checking work

## 🔧 Customization

### Adding New Extensions

Edit `.devcontainer/devcontainer.json`:

```json
"customizations": {
  "vscode": {
    "extensions": [
      "leanprover.lean4",
      "GitHub.copilot",
      "your-new-extension-id"
    ]
  }
}
```

### Changing Lean Version

Edit `lean-toolchain`:

```
leanprover/lean4:v4.14.0
```

Then rebuild the Codespace or run:

```bash
elan toolchain install
lake update
lake build
```

### Adding Dependencies

Edit `lakefile.lean`:

```lean
require some_package from git
  "https://github.com/user/package.git" @ "v1.0.0"
```

Then run:

```bash
lake update
lake build
```

### VS Code Settings

Workspace-specific settings are in `.vscode/settings.json`:

```json
{
  "lean4.elaboration.trace": "warning",
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000
}
```

## 🐛 Troubleshooting

### Problem: Lean Extension Not Working

**Solution:**
```bash
# Reload VS Code window
Ctrl/Cmd + Shift + P → "Developer: Reload Window"

# Or restart Lean server
Ctrl/Cmd + Shift + P → "Lean 4: Restart Server"
```

### Problem: Build Fails

**Solution:**
```bash
# Clean and rebuild
lake clean
lake update
lake build

# Check Lean version
lean --version
cat lean-toolchain
```

### Problem: Dependencies Not Found

**Solution:**
```bash
# Re-fetch dependencies
lake update

# Check lake-packages directory
ls -la lake-packages/
```

### Problem: Out of Memory

**Solution:**
```bash
# Build with fewer parallel jobs
LEAN_BUILD_WORKERS=1 lake build

# Or increase Codespace machine size
# (Settings → Change machine type)
```

### Problem: Slow Performance

**Solutions:**
- Increase Codespace machine type (4-core or 8-core)
- Close unused tabs and extensions
- Disable auto-save temporarily: `"files.autoSave": "off"`
- Reduce Lean's elaboration trace level

## 📊 Resource Usage

Typical resource requirements:

| Component | Disk Space | Memory | Build Time |
|-----------|------------|--------|------------|
| Lean 4 + elan | ~200 MB | ~500 MB | ~30s |
| Mathlib4 | ~500 MB | ~2 GB | ~2m |
| VML Project | ~10 MB | ~100 MB | ~10s |
| **Total** | **~1 GB** | **~3 GB** | **~3m** |

**Recommended Codespace:**
- **Machine type**: 4-core (16 GB RAM)
- **Storage**: 32 GB (default)

## 🔒 Security Notes

1. **No Secrets Required**: The setup doesn't need any secrets or credentials
2. **Public Dependencies**: All dependencies are from public repositories
3. **Sandboxed Environment**: Codespaces are isolated containers
4. **Automatic Updates**: Dependabot can update dependencies

## 📝 Best Practices

1. **Commit Regularly**: Use `git commit` to save your work
2. **Push Often**: Codespaces can be deleted; push to GitHub frequently
3. **Use Prebuilds**: Configure prebuilds for faster startup (optional)
4. **Monitor Usage**: Check GitHub billing for Codespaces hours
5. **Stop When Done**: Stop your Codespace when not in use to save hours

## 🌟 Advanced Features

### Prebuilds

For faster startup, configure prebuilds in repository settings:
- Prebuilds run the setup script in advance
- New Codespaces start in ~30 seconds instead of ~3 minutes
- Costs extra GitHub Actions minutes

### Port Forwarding

If you build a web interface:
```bash
# Forward port 8080
# Codespaces automatically detects and forwards ports
```

### Multiple Codespaces

You can run multiple Codespaces for:
- Different branches
- Different experiments
- Collaborative work

## 🆘 Getting Help

If you encounter issues:

1. **Check the terminal output** during setup
2. **View logs**: `.devcontainer/setup.sh` output
3. **Rebuild container**: Command Palette → "Codespaces: Rebuild Container"
4. **Open an issue** on GitHub
5. **Ask on Lean Zulip**: [https://leanprover.zulipchat.com/](https://leanprover.zulipchat.com/)

## 🎓 Learning More

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Dev Container Specification](https://containers.dev/)
- [Lean 4 Documentation](https://lean-lang.org/lean4/doc/)
- [Lake Build System](https://github.com/leanprover/lake)

---

**Your Codespace is configured for maximum productivity in Homotopy Type Theory research!** 🚀
