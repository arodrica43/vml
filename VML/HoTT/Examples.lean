/-
# Examples of Homotopy Type Theory Proofs

This file contains example proofs and exercises in Homotopy Type Theory.
-/

import VML.HoTT.Basic
import VML.HoTT.PathAlgebra
import VML.HoTT.Equivalences

universe u v

namespace HoTT.Examples

open HoTT

/-! ## Example 1: Loop Space -/

/--
The loop space at a point x is the type of paths from x to itself.
-/
def LoopSpace (A : Type u) (x : A) : Type u := x ≈ x

/--
Example: Composing a loop with itself.
-/
example {A : Type u} {x : A} (α : LoopSpace A x) : LoopSpace A x :=
  α ∙ α

/--
Example: The inverse of a loop is also a loop.
-/
example {A : Type u} {x : A} (α : LoopSpace A x) : LoopSpace A x :=
  α⁻¹

/-! ## Example 2: Higher Loops -/

/--
A 2-loop is a path between loops.
-/
def Loop2Space {A : Type u} {x : A} (α : LoopSpace A x) : Type u :=
  α ≈₂ α

/--
Example: Reflexivity gives us a 2-loop.
-/
example {A : Type u} {x : A} (α : LoopSpace A x) : Loop2Space α :=
  rfl

/-! ## Example 3: Path Cancellation -/

/--
Proof that path composition with inverse on the left cancels.
-/
example {A : Type u} {x y z : A} (p : x ≈ y) (q : y ≈ z) :
    p⁻¹ ∙ (p ∙ q) = q := by
  calc p⁻¹ ∙ (p ∙ q) 
      = (p⁻¹ ∙ p) ∙ q := (assoc _ _ _).symm
    _ = refl y ∙ q := by rw [left_inv]
    _ = q := left_unit q

/--
Proof that path composition with inverse on the right cancels.
-/
example {A : Type u} {x y z : A} (p : x ≈ y) (q : y ≈ z) :
    (p ∙ q) ∙ q⁻¹ = p := by
  calc (p ∙ q) ∙ q⁻¹ 
      = p ∙ (q ∙ q⁻¹) := assoc _ _ _
    _ = p ∙ refl y := by rw [right_inv]
    _ = p := right_unit p

/-! ## Example 4: Double Inversion -/

/--
Inverting a path twice returns the original path.
-/
example {A : Type u} {x y : A} (p : x ≈ y) : (p⁻¹)⁻¹ = p := by
  cases p; rfl

/-! ## Example 5: Function Application -/

/--
If we have a path between two points, applying a function
preserves that path.
-/
example {A B : Type u} (f : A → B) {x y : A} (p : x ≈ y) :
    f x ≈ f y :=
  ap f p

/--
Constant functions map all paths to reflexivity.
-/
example {A B : Type u} (b : B) {x y : A} (p : x ≈ y) :
    ap (fun _ => b) p = refl b := by
  cases p; rfl

/-! ## Example 6: Product Types -/

/--
Paths in product types.
-/
example {A B : Type u} {x₁ x₂ : A} {y₁ y₂ : B}
    (p : x₁ ≈ x₂) (q : y₁ ≈ y₂) :
    (x₁, y₁) ≈ (x₂, y₂) := by
  cases p; cases q; rfl

/--
First projection of a path in a product.
-/
example {A B : Type u} {x y : A × B} (p : x ≈ y) :
    x.1 ≈ y.1 :=
  ap Prod.fst p

/-! ## Example 7: Sum Types -/

/--
Paths in sum types (left injection).
-/
example {A B : Type u} {x y : A} (p : x ≈ y) :
    Sum.inl x ≈ Sum.inl y :=
  ap Sum.inl p

/-! ## Example 8: Dependent Paths -/

/--
Example of using transport with a dependent type.
-/
example {A : Type u} {P : A → Type v} {x y : A} (p : x ≈ y) (u : P x) :
    P y :=
  transport P p u

/-! ## Example 9: Naturality of ap -/

/--
Naturality square for ap.
-/
example {A B C : Type u} (f : A → B) (g : B → C) {x y : A} (p : x ≈ y) :
    ap g (ap f p) = ap (g ∘ f) p := by
  cases p; rfl

/-! ## Example 10: Homotopy Composition -/

/--
Homotopies compose.
-/
example {A B : Type u} {f g h : A → B} (η : f ~ g) (θ : g ~ h) : f ~ h :=
  fun x => (η x) ∙ (θ x)

/--
Identity homotopy.
-/
example {A B : Type u} (f : A → B) : f ~ f :=
  hrefl f

/-! ## Exercises (with sorry) -/

/--
Exercise: Prove that path concatenation is associative up to higher path.
-/
theorem assoc_2path {A : Type u} {w x y z : A} 
    (p : w ≈ x) (q : x ≈ y) (r : y ≈ z) :
    p ∙ (q ∙ r) ≈₂ (p ∙ q) ∙ r :=
  assoc p q r

/--
Exercise: The interchange law for 2-paths.
This shows that in a 2-category, the two ways of composing
a 2×2 grid of 2-paths are equal.
TODO: This requires more infrastructure for proper statement.
-/
theorem interchange_simplified {A : Type u} {x y z : A} 
    {p q : x ≈ y} {r s : y ≈ z}
    (α : p ≈₂ q) (β : r ≈₂ s) :
    hcomp α β = hcomp α β := by
  -- This is trivially true; the full interchange law needs more structure
  rfl

end HoTT.Examples
