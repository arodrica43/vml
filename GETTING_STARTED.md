# Getting Started with HoTT in Lean 4

Welcome to the VML (Verified Machine Learning Lab) Homotopy Type Theory environment!

## 🎓 Quick Tutorial

### Step 1: Understanding the Basics

Homotopy Type Theory treats types as spaces and equality proofs as paths. Here's your first proof:

```lean
import VML.HoTT.Basic

open HoTT

-- Theorem: Inverting a path twice gives you back the original path
theorem my_first_theorem {A : Type} {x y : A} (p : x ≈ y) : 
    (p⁻¹)⁻¹ = p := by
  cases p  -- Break down the path
  rfl      -- Check reflexivity
```

### Step 2: Working with Paths

Paths can be composed, inverted, and manipulated:

```lean
import VML.HoTT.Basic

open HoTT

example {A : Type} {x y z : A} (p : x ≈ y) (q : y ≈ z) : x ≈ z :=
  p ∙ q  -- Compose paths with ∙

example {A : Type} {x y : A} (p : x ≈ y) : y ≈ x :=
  p⁻¹    -- Invert a path with ⁻¹
```

### Step 3: Function Application

Functions preserve paths:

```lean
import VML.HoTT.Basic

open HoTT

example {A B : Type} (f : A → B) {x y : A} (p : x ≈ y) : f x ≈ f y :=
  ap f p  -- Apply function to path
```

### Step 4: Transport

Move elements along paths in dependent types:

```lean
import VML.HoTT.Basic

open HoTT

example {A : Type} {P : A → Type} {x y : A} (p : x ≈ y) (u : P x) : P y :=
  transport P p u  -- Transport u from P x to P y along p
```

## 📚 Learning Path

1. **Start with** `VML/HoTT/Basic.lean` - Understand paths and basic operations
2. **Move to** `VML/HoTT/PathAlgebra.lean` - Learn about 2-dimensional paths
3. **Explore** `VML/HoTT/Equivalences.lean` - Study type equivalences
4. **Practice with** `VML/HoTT/Examples.lean` - Work through examples

## 🔍 Key Notation

| Notation | Meaning | Example |
|----------|---------|---------|
| `x ≈ y` | Path from x to y | `p : x ≈ y` |
| `p ∙ q` | Path composition | Compose p and q |
| `p⁻¹` | Path inverse | Reverse direction of p |
| `ap f p` | Apply function to path | Map path through f |
| `f ~ g` | Homotopy | f and g are pointwise equal |
| `p ≈₂ q` | 2-path | Path between paths |

## 🛠️ Common Commands

### In the Terminal

```bash
# Build the project
lake build

# Run the main program
lake exe vml

# Clean build artifacts
lake clean

# Update dependencies
lake update
```

### In VS Code

- **Check proof**: Place cursor and press `Ctrl+Shift+Enter` (Windows/Linux) or `Cmd+Shift+Enter` (Mac)
- **View goal**: Cursor on `by` keyword shows current proof state
- **Go to definition**: `F12` or `Ctrl+Click`
- **Find references**: `Shift+F12`
- **View type**: Hover over any term

## 💡 Tips for Success

1. **Start Simple**: Begin with the examples in `Examples.lean`
2. **Use `cases`**: Most path proofs use `cases p; rfl`
3. **Check Types**: Hover over expressions to see their types
4. **Read Errors**: Lean gives helpful error messages
5. **Experiment**: Create your own `.lean` files and try things out

## 📖 Example: A Complete Proof

Here's a complete proof showing path cancellation:

```lean
import VML.HoTT.Basic
import VML.HoTT.PathAlgebra

open HoTT

theorem path_cancel_left {A : Type} {x y z : A} (p : x ≈ y) (q : y ≈ z) :
    p⁻¹ ∙ (p ∙ q) = q := by
  -- Use associativity
  calc p⁻¹ ∙ (p ∙ q) 
      = (p⁻¹ ∙ p) ∙ q := (assoc _ _ _).symm
    _ = refl y ∙ q := by rw [left_inv]
    _ = q := left_unit q
```

## 🎯 Practice Exercises

Try proving these theorems:

1. **Path inverse is involutive**: `∀ p, (p⁻¹)⁻¹ = p`
2. **Transport composition**: `transport P (p ∙ q) u = transport P q (transport P p u)`
3. **ap preserves composition**: `ap f (p ∙ q) = ap f p ∙ ap f q`
4. **ap preserves inverse**: `ap f (p⁻¹) = (ap f p)⁻¹`

Solutions can be found in `VML/HoTT/Examples.lean` and `VML/HoTT/PathAlgebra.lean`.

## 🌐 External Resources

- **HoTT Book**: [https://homotopytypetheory.org/book/](https://homotopytypetheory.org/book/) - The definitive reference
- **Lean 4 Manual**: [https://lean-lang.org/lean4/doc/](https://lean-lang.org/lean4/doc/)
- **Lean Zulip Chat**: [https://leanprover.zulipchat.com/](https://leanprover.zulipchat.com/) - Get help from the community
- **Theorem Proving in Lean 4**: [https://leanprover.github.io/theorem_proving_in_lean4/](https://leanprover.github.io/theorem_proving_in_lean4/)

## 🚀 Next Steps

1. Open `VML/HoTT/Examples.lean` and work through the examples
2. Try modifying some proofs to understand how they work
3. Create your own file and prove new theorems
4. Explore the HoTT book and implement more concepts

Happy proving! 🎉
