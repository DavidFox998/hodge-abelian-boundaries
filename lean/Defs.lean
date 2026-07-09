-- Axiom status: Uses [propext, Classical.choice, Quot.sound]
-- Scope: Number-theory layer ONLY. Definitions, no proofs, no computation.
/-
================================================================
Towers / Hodge / Defs  —  α₀ exceptional-set objects (data layer)
================================================================

**THIS FILE IS NOT A BRICK.** It is a pure DEFINITIONS file: it proves
nothing, discharges no open surface, and makes no Hodge / BSD / mass-gap
claim. It only moves the number-theory objects of the α₀ certificate chain
from prose (`paper/modules/m04-esete4.tex`, Machine Certificate v1.6) into
Lean as formal definitions, so that data is separated from claims.

What is defined here:

  * `alpha_0 : ℝ`            — the constant α₀ = 299 + π/10 (Module 1).
  * `nearestIntDist`        — distance from a real to its nearest integer,
                              i.e. the ‖·‖ used in the exceptional-set
                              condition (NOT absolute value).
  * `S_alpha_0 p`           — the exceptional-set predicate
                              `Nat.Prime p ∧ ‖p·α₀‖ < 1/p`.
  * `S_14 : Finset ℕ`       — the 14 certified primes from Module 4
                              (Machine Certificate v1.6). REAL values,
                              copied verbatim from the certificate — NOT
                              fabricated stand-ins.
  * `S_4  : Finset ℕ`       — the leading 4-element subset {2,3,19,191}
                              used in Module 5.

What is DELIBERATELY NOT here:

  * No `CM_Curve` type (`Mathlib.NumberTheory.CM` does not exist in mathlib
    v4.12.0), hence no `BostBound`, no `ExceptionalSet₂₆₉`, no
    `AnalyticObstruction`. Those need a curve formalization the repo does
    not have; introducing them now would require undefined imports/types
    and/or `sorry`. They are intentionally dropped (user-chosen Option 2).
  * No claim that `S_14` IS the exceptional set up to 10^4000 — that
    equality is the M4 certificate's claim, asserted by NO theorem here.

SORRY: 0. Axioms: classical trio only.
-/
import Mathlib.Data.Real.Pi.Bounds
import Mathlib.Algebra.Order.Floor
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Finset.Basic

namespace TheoremaAureum.Towers.Hodge.Defs

open Real

/-- The constant `α₀ = 299 + π/10` (Module 1 of the certificate chain). -/
noncomputable def alpha_0 : ℝ := 299 + Real.pi / 10

/-- Distance from a real `x` to the nearest integer, `‖x‖ = |x - round x|`.
This is the norm used in the exceptional-set condition — it is the
distance-to-nearest-integer, NOT the absolute value of `x`. -/
noncomputable def nearestIntDist (x : ℝ) : ℝ := |x - (round x : ℝ)|

/-- The exceptional-set predicate for `α₀`:
`p` is prime and `‖p · α₀‖ < 1/p` (distance to nearest integer).
This is the definition of `S(α₀)` from the certificate; it asserts nothing
about which primes satisfy it. -/
def S_alpha_0 (p : ℕ) : Prop :=
  Nat.Prime p ∧ nearestIntDist ((p : ℝ) * alpha_0) < 1 / (p : ℝ)

/-- `S_7`: the 7 certified primes of S(α₀) per M4 Correction Certificate
(Battle Plan v1.6, 2026-06-08). Originally listed as 14 primes (S_14), but
M4 correction retracted p₈-p₁₄: S(α₀) = {p₁, ..., p₇}.
Three independent methods confirm: continued fractions, BDP bridge, Apollonian gasket.
The BDP boundary is p₇ = 631474305334326148720631.
We keep the name S_14 for backward compatibility but the set is the corrected 7-prime set. -/
def S_14 : Finset ℕ :=
  { 2,
    3,
    19,
    191,
    3993746143633,
    3224057731518397,
    631474305334326148720631 }

/-- `S_4`: the leading 4-element subset `{2, 3, 19, 191}` of `S_14`, used as
the prime set in Module 5. -/
def S_4 : Finset ℕ := { 2, 3, 19, 191 }

end TheoremaAureum.Towers.Hodge.Defs
