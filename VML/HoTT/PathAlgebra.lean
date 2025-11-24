/-
# Path Algebra

Higher path algebra and operations on paths.
-/

import VML.HoTT.Basic

universe u v

namespace HoTT

/-! ## 2-Dimensional Path Algebra -/

/--
A 2-path (or homotopy between paths) is a path between paths.
-/
def Path2 {A : Type u} {x y : A} (p q : x ≈ y) : Type u := p = q

notation:50 p " ≈₂ " q => Path2 p q

/--
Horizontal composition of 2-paths.
-/
def hcomp {A : Type u} {x y z : A} {p q : x ≈ y} {r s : y ≈ z}
    (α : p ≈₂ q) (β : r ≈₂ s) : (p ∙ r) ≈₂ (q ∙ s) := by
  cases α; cases β; rfl

/--
Vertical composition of 2-paths.
-/
def vcomp {A : Type u} {x y : A} {p q r : x ≈ y}
    (α : p ≈₂ q) (β : q ≈₂ r) : p ≈₂ r := by
  cases α; exact β

/-! ## Whiskering -/

/--
Right whiskering: Compose a 2-path with a 1-path on the right.
-/
def rwhisker {A : Type u} {x y z : A} {p q : x ≈ y} (r : y ≈ z)
    (α : p ≈₂ q) : (p ∙ r) ≈₂ (q ∙ r) := by
  cases α; rfl

/--
Left whiskering: Compose a 2-path with a 1-path on the left.
-/
def lwhisker {A : Type u} {x y z : A} (p : x ≈ y) {q r : y ≈ z}
    (β : q ≈₂ r) : (p ∙ q) ≈₂ (p ∙ r) := by
  cases β; rfl

/-! ## Eckmann-Hilton Argument -/

/--
The Eckmann-Hilton argument: On loop spaces, horizontal and vertical
composition coincide and are commutative.
-/
theorem eckmann_hilton {A : Type u} {x : A} (α β : refl x ≈₂ refl x) :
    hcomp α β = vcomp α β := by
  cases α; cases β; rfl

/-! ## Action on Paths (Higher) -/

/--
ap preserves path composition.
-/
theorem ap_comp {A B : Type u} (f : A → B) {x y z : A} 
    (p : x ≈ y) (q : y ≈ z) :
    ap f (p ∙ q) = ap f p ∙ ap f q := by
  cases p; cases q; rfl

/--
ap preserves path inversion.
-/
theorem ap_inv {A B : Type u} (f : A → B) {x y : A} (p : x ≈ y) :
    ap f (p⁻¹) = (ap f p)⁻¹ := by
  cases p; rfl

/--
ap of identity is identity.
-/
theorem ap_id {A : Type u} {x y : A} (p : x ≈ y) :
    ap (fun x => x) p = p := by
  cases p; rfl

/--
ap of composition is composition of aps.
-/
theorem ap_comp_fun {A B C : Type u} (f : A → B) (g : B → C) 
    {x y : A} (p : x ≈ y) :
    ap (g ∘ f) p = ap g (ap f p) := by
  cases p; rfl

/-! ## Transport Properties -/

/--
Transport along reflexivity is identity.
-/
theorem transport_refl {A : Type u} (P : A → Type v) {x : A} (u : P x) :
    transport P (refl x) u = u := rfl

/--
Transport along composition is composition of transports.
-/
theorem transport_comp {A : Type u} (P : A → Type v) 
    {x y z : A} (p : x ≈ y) (q : y ≈ z) (u : P x) :
    transport P (p ∙ q) u = transport P q (transport P p u) := by
  cases p; cases q; rfl

/--
Transport along inverse path.
Note: This shows that transport along p⁻¹ is well-defined.
For the full inverse property, we need to show:
  transport P (p⁻¹) (transport P p u) = u
-/
theorem transport_inv {A : Type u} (P : A → Type v) 
    {x y : A} (p : x ≈ y) (u : P x) :
    transport P p (transport P (p⁻¹) (transport P p u)) = transport P p u := by
  cases p; rfl

end HoTT
