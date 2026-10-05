import BealLevel26Foundations.CoefficientLedger_26
import Mathlib.AlgebraicGeometry.EllipticCurve.Weierstrass
import Mathlib.Tactic

namespace Beal.Foundations.J0_26_Decomp

open BealLevel26Foundations.CoefficientLedger26
open WeierstrassCurve

/-!
# v1.3.0 J₀(26) q-expansion decomposition

This module reads the `26a1` and `26b1` q-expansions from
`sagemath/level_26_ledger.json` (promoted in
`BealLevel26Foundations.CoefficientLedger26`) and the SageMath 10.7
prefixes archived in `sagemath/certs/j0_26_decomposition.json`.

Mathlib 4.12 has no modular-curve Jacobian, modular-symbols new-subspace,
or isogeny decomposition of `J₀(N)`.  The certified statement is therefore
finite typed data:

* two distinct newform prefixes;
* each assigned dimension `1`;
* the sum of those dimensions is `2`.

It does not identify `J₀(26)` as a scheme, and it does not prove a
Mordell--Weil theorem.
-/

/-- One SageMath elliptic factor of `J₀(26)`, with its q-expansion prefix. -/
structure NewformFactor26 where
  cremonaLabel : String
  abelianLabel : String
  dimension : Nat
  qexpPrefix : List Int
  a1 : Int
  a2 : Int
  a3 : Int
  a4 : Int
  a6 : Int
  c4 : Int
  c6 : Int
  discriminant : Int

def factor26a1 : NewformFactor26 where
  cremonaLabel := "26a1"
  abelianLabel := "26a(1,26)"
  dimension := 1
  qexpPrefix :=
    [0, 1, -1, 1, 1, -3, -1, -1, -1, -2, 3, 6, 1, 1, 1, -3, 1, -3, 2, 2, -3]
  a1 := 1
  a2 := 0
  a3 := 1
  a4 := -5
  a6 := -8
  c4 := 217
  c6 := 6371
  discriminant := -17576

def factor26b1 : NewformFactor26 where
  cremonaLabel := "26b1"
  abelianLabel := "26b(1,26)"
  dimension := 1
  qexpPrefix :=
    [0, 1, 1, -3, 1, -1, -3, 1, 1, 6, -1, -2, -3, -1, 1, 3, 1, -3, 6, 6, -1]
  a1 := 1
  a2 := -1
  a3 := 1
  a4 := -3
  a6 := 3
  c4 := 129
  c6 := -2241
  discriminant := -1664

theorem factor26a1_label : factor26a1.cremonaLabel = "26a1" :=
  rfl

theorem factor26b1_label : factor26b1.cremonaLabel = "26b1" :=
  rfl

theorem factor26a1_dimension : factor26a1.dimension = 1 :=
  rfl

theorem factor26b1_dimension : factor26b1.dimension = 1 :=
  rfl

/-- Certified additive dimension of the two SageMath factors. -/
def certifiedDecompositionDimension : Nat :=
  factor26a1.dimension + factor26b1.dimension

theorem certifiedDecompositionDimension_eq_two :
    certifiedDecompositionDimension = 2 := by
  decide

/-- The Sage `a₀…a₂₀` prefix for `26a1` is the ledger prefix. -/
theorem qexp26a1_prefix_eq_ledger :
    qExp_26a1.take 21 = factor26a1.qexpPrefix := by
  decide

/-- The Sage `a₀…a₂₀` prefix for `26b1` is the ledger prefix. -/
theorem qexp26b1_prefix_eq_ledger :
    qExp_26b1.take 21 = factor26b1.qexpPrefix := by
  decide

theorem qexp26a1_a1_a2 :
    factor26a1.qexpPrefix[1]? = some 1 ∧
      factor26a1.qexpPrefix[2]? = some (-1) := by
  decide

theorem qexp26b1_a1_a2 :
    factor26b1.qexpPrefix[1]? = some 1 ∧
      factor26b1.qexpPrefix[2]? = some 1 := by
  decide

/-- Two distinct dim-1 newform lines whose dimensions add to 2. -/
theorem certifiedDecomposition_two_distinct_newforms :
    factor26a1.qexpPrefix ≠ factor26b1.qexpPrefix ∧
      factor26a1.dimension = 1 ∧
      factor26b1.dimension = 1 ∧
      certifiedDecompositionDimension = 2 := by
  refine ⟨?_, factor26a1_dimension, factor26b1_dimension,
    certifiedDecompositionDimension_eq_two⟩
  decide

def curve26a1 : WeierstrassCurve Int where
  a₁ := factor26a1.a1
  a₂ := factor26a1.a2
  a₃ := factor26a1.a3
  a₄ := factor26a1.a4
  a₆ := factor26a1.a6

def curve26b1 : WeierstrassCurve Int where
  a₁ := factor26b1.a1
  a₂ := factor26b1.a2
  a₃ := factor26b1.a3
  a₄ := factor26b1.a4
  a₆ := factor26b1.a6

theorem curve26a1_c4 :
    curve26a1.c₄ = factor26a1.c4 := by
  simp only [curve26a1, factor26a1, WeierstrassCurve.c₄, WeierstrassCurve.b₂,
    WeierstrassCurve.b₄]
  norm_num

theorem curve26a1_c6 :
    curve26a1.c₆ = factor26a1.c6 := by
  simp only [curve26a1, factor26a1, WeierstrassCurve.c₆, WeierstrassCurve.b₂,
    WeierstrassCurve.b₄, WeierstrassCurve.b₆]
  norm_num

theorem curve26a1_discriminant :
    curve26a1.Δ = factor26a1.discriminant := by
  simp only [curve26a1, factor26a1, WeierstrassCurve.Δ, WeierstrassCurve.b₂,
    WeierstrassCurve.b₄, WeierstrassCurve.b₆, WeierstrassCurve.b₈]
  norm_num

theorem curve26a1_discriminant_ne_zero :
    curve26a1.Δ ≠ 0 := by
  rw [curve26a1_discriminant]
  decide

theorem curve26b1_c4 :
    curve26b1.c₄ = factor26b1.c4 := by
  simp only [curve26b1, factor26b1, WeierstrassCurve.c₄, WeierstrassCurve.b₂,
    WeierstrassCurve.b₄]
  norm_num

theorem curve26b1_c6 :
    curve26b1.c₆ = factor26b1.c6 := by
  simp only [curve26b1, factor26b1, WeierstrassCurve.c₆, WeierstrassCurve.b₂,
    WeierstrassCurve.b₄, WeierstrassCurve.b₆]
  norm_num

theorem curve26b1_discriminant :
    curve26b1.Δ = factor26b1.discriminant := by
  simp only [curve26b1, factor26b1, WeierstrassCurve.Δ, WeierstrassCurve.b₂,
    WeierstrassCurve.b₄, WeierstrassCurve.b₆, WeierstrassCurve.b₈]
  norm_num

theorem curve26b1_discriminant_ne_zero :
    curve26b1.Δ ≠ 0 := by
  rw [curve26b1_discriminant]
  decide

#print axioms certifiedDecompositionDimension_eq_two
#print axioms certifiedDecomposition_two_distinct_newforms
#print axioms qexp26a1_prefix_eq_ledger
#print axioms qexp26b1_prefix_eq_ledger
#print axioms curve26a1_discriminant_ne_zero
#print axioms curve26b1_discriminant_ne_zero

end Beal.Foundations.J0_26_Decomp
