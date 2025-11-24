#!/bin/bash
set -e

echo "================================================"
echo "Setting up Lean 4 + Homotopy Type Theory Environment"
echo "================================================"

# Install elan (Lean version manager)
echo "Installing elan (Lean version manager)..."
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --default-toolchain none

# Add elan to PATH
export PATH="$HOME/.elan/bin:$PATH"
echo 'export PATH="$HOME/.elan/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.elan/bin:$PATH"' >> ~/.zshrc

# Install Lean based on lean-toolchain file
echo "Installing Lean toolchain..."
cd /workspaces/vml
elan toolchain install

# Fetch dependencies
echo "Fetching project dependencies..."
lake update

# Build the project
echo "Building the project..."
lake build

echo "================================================"
echo "Setup complete!"
echo "================================================"
echo "You can now:"
echo "  - Open any .lean file to start proving theorems"
echo "  - Run 'lake build' to build the project"
echo "  - Run 'lake exe vml' to run the main executable"
echo "  - Check HoTT examples in VML/HoTT/"
echo "================================================"
