# Contributing to VML - Homotopy Type Theory in Lean 4

Thank you for your interest in contributing to the Verified Machine Learning Lab! This project aims to provide a comprehensive environment for Homotopy Type Theory research and education in Lean 4.

## 🎯 How to Contribute

There are many ways to contribute:

1. **Add new HoTT theorems and proofs**
2. **Improve documentation and examples**
3. **Fix bugs or improve code quality**
4. **Create tutorials and learning materials**
5. **Report issues or suggest features**

## 🚀 Getting Started

### 1. Set Up Your Environment

**Option A: GitHub Codespaces (Recommended)**
- Click "Code" → "Codespaces" → "Create codespace"
- Wait 2-3 minutes for automatic setup
- Start coding!

**Option B: Local Development**
```bash
# Install elan
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh

# Clone and build
git clone https://github.com/arodrica43/vml.git
cd vml
lake update
lake build
```

### 2. Create a Branch

```bash
git checkout -b feature/my-new-feature
# or
git checkout -b fix/issue-description
```

### 3. Make Your Changes

Follow the project structure:
```
VML/
├── HoTT/
│   ├── Basic.lean           # Fundamental definitions
│   ├── PathAlgebra.lean     # Path operations
│   ├── Equivalences.lean    # Type equivalences
│   └── Examples.lean        # Example proofs
```

### 4. Test Your Changes

```bash
# Build the project
lake build

# Run the executable
lake exe vml

# Check specific files
lean VML/HoTT/YourFile.lean
```

### 5. Submit a Pull Request

- Push your branch to GitHub
- Open a Pull Request with a clear description
- Wait for review and feedback

## 📝 Coding Standards

### Lean Code Style

1. **Naming Conventions**
   - Types: `PascalCase` (e.g., `PathAlgebra`, `TypeEquiv`)
   - Functions/theorems: `snake_case` (e.g., `path_comp`, `transport_inv`)
   - Theorems: Descriptive names (e.g., `left_inv`, `assoc`)

2. **Documentation**
   - Add docstrings to all public definitions
   - Use `/-- ... -/` for documentation comments
   - Include examples where helpful

3. **Formatting**
   ```lean
   /-- 
   Brief one-line description.
   
   More detailed explanation if needed.
   -/
   def myFunction {A : Type u} (x : A) : A :=
     x
   ```

4. **Proofs**
   - Prefer `by` for tactic proofs
   - Use `calc` for equational reasoning
   - Keep proofs readable and well-commented

### Example of Good Code

```lean
/-
# Path Inversion

Properties of path inversion in HoTT.
-/

import VML.HoTT.Basic

namespace HoTT

/--
Inverting a path twice returns the original path.
This is a fundamental property of path algebra.
-/
theorem double_inv {A : Type u} {x y : A} (p : x ≈ y) : 
    (p⁻¹)⁻¹ = p := by
  cases p  -- Path induction
  rfl      -- Reflexivity

/--
Path inversion distributes over composition.
For paths p : x ≈ y and q : y ≈ z, we have (p ∙ q)⁻¹ = q⁻¹ ∙ p⁻¹.
-/
theorem inv_comp {A : Type u} {x y z : A} (p : x ≈ y) (q : y ≈ z) :
    (p ∙ q)⁻¹ = q⁻¹ ∙ p⁻¹ := by
  cases p
  cases q
  rfl

end HoTT
```

## 🎓 Adding New Content

### Adding a New Module

1. Create the file in appropriate directory:
   ```lean
   -- VML/HoTT/NewModule.lean
   /-
   # Module Title
   
   Brief description of the module.
   -/
   
   import VML.HoTT.Basic
   
   namespace HoTT
   
   -- Your content here
   
   end HoTT
   ```

2. Add import to `VML.lean`:
   ```lean
   import VML.HoTT.NewModule
   ```

3. Test the build:
   ```bash
   lake build
   ```

### Adding Examples

Add to `VML/HoTT/Examples.lean` or create a new examples file:

```lean
/-! ## Example: Your Topic -/

/--
Brief description of what this example demonstrates.
-/
example {A : Type u} (x : A) : x ≈ x :=
  refl x  -- Your proof here

/--
Explanation of the proof technique.
-/
theorem example_theorem {A : Type u} {x y : A} (p : x ≈ y) :
    p ∙ p⁻¹ = refl x := by
  cases p
  rfl
```

### Adding Documentation

Update relevant markdown files:
- `README.md` - Main project overview
- `GETTING_STARTED.md` - Tutorial content
- `CODESPACES.md` - Setup information
- Create new `.md` files for specialized topics

## 🐛 Reporting Issues

When reporting bugs:

1. **Check existing issues** first
2. **Provide clear description** of the problem
3. **Include minimal example** that reproduces the issue
4. **Specify environment**:
   - Lean version: `lean --version`
   - Lake version: `lake --version`
   - Operating system
   - Codespace or local

### Issue Template

```markdown
**Description:**
Brief description of the issue.

**Steps to Reproduce:**
1. Open file X
2. Run command Y
3. See error Z

**Expected Behavior:**
What should happen.

**Actual Behavior:**
What actually happens.

**Environment:**
- Lean version: 
- Lake version:
- OS:
- Codespace: Yes/No

**Code Sample:**
```lean
-- Minimal example that demonstrates the issue
```
```

## 📚 Areas for Contribution

### High Priority

1. **More HoTT Theorems**
   - Higher inductive types
   - Univalence axiom formalization
   - Circle and sphere types
   - Cubical type theory elements

2. **Examples and Tutorials**
   - More worked examples
   - Step-by-step tutorials
   - Exercise problems with solutions

3. **Documentation**
   - More explanatory comments
   - Tutorial videos (links)
   - Comparison with HoTT book

### Medium Priority

1. **Testing Infrastructure**
   - Example tests
   - Proof checking automation
   - CI/CD improvements

2. **Tooling**
   - Better editor support
   - Proof automation tactics
   - Documentation generation

3. **Integration**
   - Mathlib integration
   - External HoTT libraries
   - Visualization tools

### Low Priority

1. **Performance**
   - Build optimization
   - Proof simplification

2. **Aesthetics**
   - Better notation
   - Pretty printing

## 🔍 Code Review Process

1. **Automated Checks**
   - CI builds must pass
   - No compilation errors
   - Formatting standards

2. **Manual Review**
   - Code quality
   - Documentation completeness
   - Test coverage
   - Follows project conventions

3. **Feedback**
   - Constructive comments
   - Suggestions for improvement
   - Questions for clarification

## 🎖️ Recognition

Contributors are recognized in:
- Git commit history
- GitHub contributors page
- Release notes
- Special mentions for significant contributions

## 📜 Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn
- Follow best practices
- Credit others' work

## 📞 Getting Help

- **Lean Zulip**: [https://leanprover.zulipchat.com/](https://leanprover.zulipchat.com/)
- **GitHub Issues**: For project-specific questions
- **Discussions**: For general questions and ideas

## 🙏 Thank You

Your contributions help make Homotopy Type Theory more accessible to everyone. Whether you're fixing a typo or proving a major theorem, every contribution is valued!

---

**Happy Contributing!** 🎉
