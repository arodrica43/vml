/-
# Basic Homotopy Type Theory Definitions

This file contains basic definitions and theorems for Homotopy Type Theory (HoTT).
HoTT interprets types as spaces, terms as points, and equalities as paths.
-/

namespace HoTT

/-! ## Identity Types and Paths -/

/--
In HoTT, we interpret equality types as path types.
A path is an identification between two points in a type.
-/
def Path (A : Type u) (x y : A) : Type u := x = y

notation:50 x " ≈ " y => Path _ x y

/--
Reflexivity: Every point has a constant path to itself.
-/
def refl {A : Type u} (x : A) : x ≈ x := rfl

/--
Path inversion: If we have a path from x to y, we have a path from y to x.
-/
def inv {A : Type u} {x y : A} (p : x ≈ y) : y ≈ x := p.symm

notation:max p "⁻¹" => inv p

/--
Path composition: Paths can be composed transitively.
-/
def comp {A : Type u} {x y z : A} (p : x ≈ y) (q : y ≈ z) : x ≈ z := 
  p.trans q

infixl:60 " ∙ " => comp

/-! ## Transport (Path Induction) -/

/--
Transport: If we have a path p : x ≈ y and a type family P over A,
we can transport elements of P x to P y.
-/
def transport {A : Type u} (P : A → Type v) {x y : A} (p : x ≈ y) : P x → P y :=
  fun u => p ▸ u

notation:max "transport" => transport

/--
Path lifting (apd): Dependent version of function application to paths.
-/
def apd {A : Type u} {P : A → Type v} (f : (x : A) → P x) 
    {x y : A} (p : x ≈ y) : transport P p (f x) = f y :=
  by cases p; rfl

/-! ## Function Application -/

/--
Action on paths (ap): Functions preserve paths.
-/
def ap {A : Type u} {B : Type v} (f : A → B) {x y : A} (p : x ≈ y) : f x ≈ f y :=
  congrArg f p

/-! ## Basic Path Algebra Laws -/

theorem left_inv {A : Type u} {x y : A} (p : x ≈ y) : p⁻¹ ∙ p = refl y := by
  cases p; rfl

theorem right_inv {A : Type u} {x y : A} (p : x ≈ y) : p ∙ p⁻¹ = refl x := by
  cases p; rfl

theorem assoc {A : Type u} {x y z w : A} (p : x ≈ y) (q : y ≈ z) (r : z ≈ w) :
    p ∙ (q ∙ r) = (p ∙ q) ∙ r := by
  cases p; cases q; cases r; rfl

theorem left_unit {A : Type u} {x y : A} (p : x ≈ y) : refl x ∙ p = p := by
  cases p; rfl

theorem right_unit {A : Type u} {x y : A} (p : x ≈ y) : p ∙ refl y = p := by
  cases p; rfl

/-! ## Homotopy -/

/--
Homotopy: Two functions are homotopic if they are pointwise equal.
This is the function extensionality principle in HoTT.
-/
def Homotopy {A : Type u} {B : Type v} (f g : A → B) : Type (max u v) :=
  ∀ x : A, f x ≈ g x

notation:50 f " ~ " g => Homotopy f g

/--
Reflexivity of homotopy.
-/
def hrefl {A : Type u} {B : Type v} (f : A → B) : f ~ f :=
  fun x => refl (f x)

end HoTT
