# HoTT in Lean 4 - Quick Reference

## 🎯 Essential Commands

### Building and Running

```bash
lake build              # Build the entire project
lake clean              # Clean build artifacts
lake update             # Update dependencies
lake exe vml            # Run the main executable
lean --version          # Check Lean version
```

### Git Operations

```bash
git status              # Check current status
git add .               # Stage all changes
git commit -m "msg"     # Commit changes
git push                # Push to remote
```

## 📚 Core HoTT Concepts

### Types as Spaces

| Concept | Interpretation |
|---------|---------------|
| Type `A` | A space |
| Term `x : A` | A point in space A |
| Function `f : A → B` | A continuous map |
| Dependent type `P : A → Type` | A fibration over A |

### Paths (Equality)

```lean
-- Path between x and y
p : x ≈ y           -- or p : x = y

-- Reflexivity (constant path)
refl x : x ≈ x

-- Path composition
p ∙ q : x ≈ z       -- when p : x ≈ y, q : y ≈ z

-- Path inverse
p⁻¹ : y ≈ x         -- when p : x ≈ y

-- Apply function to path
ap f p : f x ≈ f y  -- when p : x ≈ y
```

### Transport

```lean
-- Move along paths in dependent types
transport P p u : P y    -- when p : x ≈ y, u : P x
```

### Homotopy

```lean
-- Two functions are homotopic
f ~ g ≡ ∀ x, f x ≈ g x
```

## 🔤 Notation Guide

| Symbol | Meaning | How to Type | Example |
|--------|---------|-------------|---------|
| `≈` | Path/equality | `\~~` or `\approx` | `x ≈ y` |
| `∙` | Path composition | `\.` or `\cdot` | `p ∙ q` |
| `⁻¹` | Path inverse | `\-1` | `p⁻¹` |
| `~` | Homotopy | `\~` | `f ~ g` |
| `≃` | Equivalence | `\~=` or `\simeq` | `A ≃ B` |
| `≈₂` | 2-path | `\~~\_2` | `p ≈₂ q` |
| `→` | Function type | `\to` or `\->` | `A → B` |
| `Π` | Pi type | `\Pi` | `Π (x : A), P x` |
| `Σ` | Sigma type | `\Sigma` | `Σ (x : A), P x` |
| `×` | Product type | `\times` | `A × B` |
| `⊕` | Sum type | `\oplus` | `A ⊕ B` |

## 📖 Common Proof Patterns

### Path Induction

```lean
theorem my_theorem {A : Type} {x y : A} (p : x ≈ y) : ... := by
  cases p  -- Reduce to reflexivity case
  rfl      -- Check reflexivity
```

### Equational Reasoning

```lean
theorem path_calc {A : Type} {x y z : A} (p : x ≈ y) (q : y ≈ z) : ... := by
  calc x ≈ y := p
     _ ≈ z := q
```

### Function Application

```lean
theorem ap_example {A B : Type} (f : A → B) {x y : A} (p : x ≈ y) :
    f x ≈ f y := ap f p
```

### Transport Usage

```lean
theorem transport_example {A : Type} (P : A → Type) 
    {x y : A} (p : x ≈ y) (u : P x) : P y :=
  transport P p u
```

## 🎓 Key Theorems

### Path Algebra

```lean
-- Associativity
assoc : p ∙ (q ∙ r) = (p ∙ q) ∙ r

-- Unit laws
left_unit : refl x ∙ p = p
right_unit : p ∙ refl y = p

-- Inverse laws
left_inv : p⁻¹ ∙ p = refl y
right_inv : p ∙ p⁻¹ = refl x

-- Double inverse
double_inv : (p⁻¹)⁻¹ = p
```

### Function Application

```lean
-- ap preserves composition
ap_comp : ap f (p ∙ q) = ap f p ∙ ap f q

-- ap preserves inverse
ap_inv : ap f (p⁻¹) = (ap f p)⁻¹

-- ap of identity
ap_id : ap id p = p

-- ap of composition
ap_comp_fun : ap (g ∘ f) p = ap g (ap f p)
```

### Transport Properties

```lean
-- Transport along refl
transport_refl : transport P (refl x) u = u

-- Transport composition
transport_comp : transport P (p ∙ q) u = 
                 transport P q (transport P p u)
```

## 🗂️ Project Structure

```
vml/
├── README.md                    # Main documentation
├── GETTING_STARTED.md          # Beginner tutorial
├── CODESPACES.md               # Setup guide
├── CONTRIBUTING.md             # Contribution guide
├── QUICK_REFERENCE.md          # This file
├── Main.lean                   # Entry point
├── VML.lean                    # Library root
├── lakefile.lean               # Build config
├── lean-toolchain              # Lean version
├── VML/HoTT/
│   ├── Basic.lean              # Fundamental definitions
│   ├── PathAlgebra.lean        # Path operations
│   ├── Equivalences.lean       # Type equivalences
│   └── Examples.lean           # Example proofs
├── .devcontainer/              # Codespaces config
├── .github/workflows/          # CI/CD
└── .vscode/                    # Editor settings
```

## 💡 Tips and Tricks

### VS Code Shortcuts

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Check proof | `Ctrl+Shift+Enter` | `Cmd+Shift+Enter` |
| Go to definition | `F12` | `F12` |
| Find references | `Shift+F12` | `Shift+F12` |
| Restart Lean | `Ctrl+Shift+P` → Restart | `Cmd+Shift+P` → Restart |
| View goal | Cursor on `by` | Cursor on `by` |

### Proof Strategies

1. **Start with cases**: For path arguments, try `cases p`
2. **Use calc**: For equational reasoning
3. **Check types**: Hover to see what Lean expects
4. **Build incrementally**: Add `sorry` and fill in later
5. **Read errors carefully**: Lean's errors are informative

### Common Errors

| Error | Solution |
|-------|----------|
| "type mismatch" | Check types with hover, may need transport |
| "unknown identifier" | Add import or check namespace |
| "invalid field notation" | Check structure/namespace |
| "tactic failed" | Try different tactic or `cases` |

## 🔗 Quick Links

- **Lean 4 Manual**: https://lean-lang.org/lean4/doc/
- **HoTT Book**: https://homotopytypetheory.org/book/
- **Theorem Proving in Lean 4**: https://leanprover.github.io/theorem_proving_in_lean4/
- **Lean Zulip Chat**: https://leanprover.zulipchat.com/
- **Mathlib4 Docs**: https://leanprover-community.github.io/mathlib4_docs/

## 🎯 Next Steps

1. Read `GETTING_STARTED.md` for tutorial
2. Open `VML/HoTT/Examples.lean` and work through examples
3. Try proving simple theorems
4. Explore `VML/HoTT/Basic.lean` for definitions
5. Read the HoTT book chapters 1-2
6. Create your own `.lean` files and experiment

---

**Keep this reference handy while coding!** 📚
