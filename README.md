# VML - Verified Machine Learning Lab

A GitHub Codespaces-ready repository for proving **Homotopy Type Theory** statements in **Lean 4**.

## 🎯 Overview

This project provides a complete, professional development environment for working with **Homotopy Type Theory (HoTT)** in Lean 4. The repository is fully configured for GitHub Codespaces, allowing you to start coding immediately without any local setup.

### What is Homotopy Type Theory?

Homotopy Type Theory (HoTT) is a modern foundation for mathematics that:
- Interprets types as spaces and terms as points
- Views equality proofs as paths between points
- Enables reasoning about higher-dimensional structures
- Connects type theory with algebraic topology

## 🚀 Quick Start

### Using GitHub Codespaces (Recommended)

1. Click the "Code" button on this repository
2. Select "Codespaces" tab
3. Click "Create codespace on main" (or your branch)
4. Wait for the environment to set up automatically (~2-3 minutes)
5. Start coding! Open any `.lean` file to begin

The Codespace automatically installs:
- ✅ Lean 4 (version 4.13.0)
- ✅ Mathlib4 (Lean's mathematical library)
- ✅ Lean 4 VS Code extension
- ✅ All project dependencies

### Local Development

If you prefer to work locally:

```bash
# Install elan (Lean version manager)
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh

# Clone the repository
git clone https://github.com/arodrica43/vml.git
cd vml

# Install dependencies and build
lake update
lake build
```

## 📚 Project Structure

```
vml/
├── .devcontainer/          # GitHub Codespaces configuration
│   ├── devcontainer.json   # Codespace settings and extensions
│   └── setup.sh            # Automated setup script
├── VML/                    # Main library
│   └── HoTT/               # Homotopy Type Theory modules
│       ├── Basic.lean      # Fundamental HoTT definitions
│       ├── PathAlgebra.lean # Path operations and 2-paths
│       ├── Equivalences.lean # Type equivalences
│       └── Examples.lean   # Example proofs and exercises
├── Main.lean               # Entry point
├── VML.lean                # Library root
├── lakefile.lean           # Lake build configuration
├── lean-toolchain          # Lean version specification
└── README.md               # This file
```

## 📖 What's Included

### HoTT Foundations (`VML/HoTT/Basic.lean`)

- **Path types**: Interpretation of equality as paths
- **Path operations**: Reflexivity, inversion, composition
- **Transport**: Moving along paths in type families
- **Function application**: How functions preserve paths
- **Homotopy**: Pointwise equality of functions

### Path Algebra (`VML/HoTT/PathAlgebra.lean`)

- **2-dimensional paths**: Paths between paths
- **Horizontal/vertical composition**: Composing 2-paths
- **Whiskering**: Path operations
- **Eckmann-Hilton argument**: Loop space commutativity
- **Transport properties**: Laws for moving along paths

### Type Equivalences (`VML/HoTT/Equivalences.lean`)

- **Quasi-inverses**: Functions with two-sided inverses
- **Equivalences**: Functions with contractible fibers
- **Univalence** (stated): Type equality is equivalent to type equivalence
- **Example equivalences**: Product and sum symmetry

### Examples and Exercises (`VML/HoTT/Examples.lean`)

- Loop spaces and higher loops
- Path cancellation proofs
- Function application examples
- Homotopy composition
- Practice exercises

## 🛠️ Usage

### Building the Project

```bash
lake build
```

### Running the Main Program

```bash
lake exe vml
```

### Working with Lean Files

1. Open any `.lean` file in VS Code
2. The Lean extension will activate automatically
3. See live feedback as you type
4. Use `Ctrl/Cmd + Shift + Enter` to check your proofs
5. Hover over definitions to see types and documentation

### Example: Your First HoTT Proof

Create a new file `MyProofs.lean`:

```lean
import VML.HoTT.Basic

open HoTT

-- Prove that inverting a path twice gives the original path
theorem double_inv {A : Type u} {x y : A} (p : x ≈ y) : 
    (p⁻¹)⁻¹ = p := by
  cases p
  rfl
```

## 📝 Learning Resources

### Recommended Reading

1. **HoTT Book**: [https://homotopytypetheory.org/book/](https://homotopytypetheory.org/book/)
2. **Lean 4 Documentation**: [https://lean-lang.org/documentation/](https://lean-lang.org/documentation/)
3. **Theorem Proving in Lean 4**: [https://leanprover.github.io/theorem_proving_in_lean4/](https://leanprover.github.io/theorem_proving_in_lean4/)

### Key Concepts

- **Type**: A collection of terms (think: a space)
- **Term**: An element of a type (think: a point)
- **Path**: A proof of equality (think: a path between points)
- **2-Path**: A proof that two paths are equal (think: a homotopy)
- **Transport**: Moving elements along paths
- **Equivalence**: Isomorphism in the world of types

## 🔧 Development Commands

| Command | Description |
|---------|-------------|
| `lake build` | Build the entire project |
| `lake clean` | Clean build artifacts |
| `lake update` | Update dependencies |
| `lake exe vml` | Run the main executable |

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Add more HoTT theorems and proofs
2. Create tutorials and examples
3. Improve documentation
4. Report issues or bugs

## 📄 License

See [LICENSE](LICENSE) file for details.

## 🌟 Features

- ✨ **Zero-setup environment** with GitHub Codespaces
- 🔧 **Pre-configured** Lean 4 with latest stable version
- 📚 **Complete HoTT library** with fundamental definitions
- 💡 **Interactive development** with VS Code extensions
- 🎓 **Example proofs** to learn from
- 🚀 **Professional structure** following Lean best practices

## 🐛 Troubleshooting

### Lean extension not working

1. Reload the VS Code window: `Ctrl/Cmd + Shift + P` → "Developer: Reload Window"
2. Check that Lean is installed: `lean --version` in terminal
3. Verify the project builds: `lake build`

### Build errors

1. Update dependencies: `lake update`
2. Clean and rebuild: `lake clean && lake build`
3. Check your Lean version matches `lean-toolchain` file

### Codespace issues

1. Rebuild the container: Command Palette → "Codespaces: Rebuild Container"
2. Check setup logs in the terminal
3. Ensure you're using the latest version of the repository

## 📬 Support

For questions or issues:
- Open an issue on GitHub
- Check existing issues for solutions
- Consult the Lean Zulip chat: [https://leanprover.zulipchat.com/](https://leanprover.zulipchat.com/)

---

**Happy Theorem Proving! 🎉**
