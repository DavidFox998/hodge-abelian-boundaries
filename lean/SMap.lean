-- Axiom status: Uses [propext, Classical.choice, Quot.sound]
-- Scope: HONEST bridge from the 12-curve scaffold (Twelve) to the SINGLE
--        certified α₀ exceptional set (Defs / Modules 1–5). NO per-curve S_X
--        family (the documents define none); NO computation over reals; NO
--        BostBound proof. Everything load-bearing stays a NAMED ATTESTED Prop.
/-
================================================================
Towers / Hodge / SMap  —  cross-reference of the 12-curve set
                          with Battle Plan v1.6 Modules 1–5
================================================================

**THIS FILE IS NOT A BRICK.** It connects `Towers/Hodge/Twelve.lean` to the
genuine, SHA-attested α₀ certificate chain (Modules 1–5, Machine Certificate
v1.6) using REAL data only. It proves nothing, discharges no open surface, and
makes no Hodge / BSD / Bost-violation claim.

WHAT THE DOCUMENTS ACTUALLY PROVIDE (and what they do NOT):

  * There is ONE exceptional set, `S(α₀) = { p prime : ‖p·α₀‖ < 1/p }`
    (`Defs.S_alpha_0`), α₀ = 299 + π/10 (Module 1). It is curve-independent.
  * Module 4 certifies the finite window: `S(α₀) ∩ [1,10^4000] = S_14`, the 14
    explicit primes already in `Defs.S_14` (parent SHA of M4 stdout
    `53315d4e6649a40b…`, depends on M3 stdout `e687bb09a55e4eda…`).
  * Module 5 certifies the Bost bound on the leading prefix
    `S_4 = {2,3,19,191}` (`Defs.S_4`): `C(S_4) ≈ 11.4221 > 2√13 ≈ 7.2111`,
    with `C(s) = Σ_{p∈s} log p · p/(p-1)` (`Twelve.C`).
  * The documents give NO per-curve family `S_X` indexed by the 12 CM levels.
    The "S_k" objects (S_4, S_5, …, S_14) are NESTED PREFIXES of the single
    `S(α₀)`, sized by a genus bound — not one set per curve. So the same
    `S(α₀)` window serves every level; `S_of_curve` below is the constant
    `Sexc`, with the unused-curve argument made explicit (`_X`).

THREE PIECES OF THE DRAFTED SPEC ARE REFUSED — each is impossible or would
fabricate data / break a lock:

  1. `def S_of_level d := Finset.filter S_alpha_0 (Finset.range 5000)` —
     `S_alpha_0` is a REAL inequality with π. It IS classically decidable
     (`by classical` / `Classical.propDecidable` supplies `DecidablePred`), but
     the resulting `Finset.filter` is NONCOMPUTABLE, so it cannot drive the
     requested `#eval!` workflow. It also IGNORES `d` (not per-curve), and
     `range 5000` contradicts the 10^4000 window (p₅ = 3.99×10¹² ≫ 5000, so it
     could only ever return ⊆ S_4).
  2. Overwriting `Twelve.S` (the honest `opaque`) with that map — refused; the
     `opaque` is correct precisely because no per-curve data exists.
  3. `#eval! … C (S X) … decide (C (S X) > 2√13)` — `C` is NONCOMPUTABLE
     (`Real.log`/`Real.sqrt`); the M5 bound is an external `arb` interval
     certificate, not an in-kernel computation. No `#eval!`/`decide` is possible.

HONEST OBSERVATION (asserted by no theorem): under the real certified data the
"violation conjecture" `Twelve.TwelveViolation_Surface` has NO support — there
is one set `S(α₀)`, every prefix `S_4 ⊆ … ⊆ S_14` has only positive Bost terms,
and `C` only GROWS (M10: `C(S_5) = 40.438`). So the certificates point AWAY from
any Bost-bound violation. It stays OPEN and unasserted (neither it nor its
negation is proved here).

SORRY: 0. Axioms: classical trio only.
-/
import Towers.Hodge.Twelve
import Towers.Hodge.Defs

namespace TheoremaAureum.Towers.Hodge.SMap

open TheoremaAureum.Towers.Hodge

/-- The SINGLE certified exceptional-set window from Module 4:
`S(α₀) ∩ [1,10^4000] = S_14`. Reused from `Defs` — REAL certified primes, not a
recomputation. Curve-independent. -/
def Sexc : Finset ℕ := Defs.S_14

/-- The exceptional set attached to a curve. Because the documents define ONE
set `S(α₀)` (not a per-curve family), this is the constant `Sexc` for every
`X`; the curve argument is unused (`_X`) to make the curve-independence explicit
in the code. This is NOT a fabricated per-curve map. -/
def S_of_curve (_X : Twelve.CM_Curve) : Finset ℕ := Sexc

/-- M4 ATTESTATION (named, asserted by NO theorem): on the inclusive window
`[1,10^4000]`, the α₀ exceptional set is exactly `S_14`. The upper bound is
inclusive (`p ≤ 10^4000`) to match the certificate's `∩ [1,10^4000]`; the lower
bound `1 ≤ p` is implied by `Nat.Prime p` inside `S_alpha_0`, so it is omitted.
This is the Module-4 external certificate (Legendre + the Module-3
continued-fraction bound `p₅ > 82829`), NOT a Lean computation. -/
def M4_window_eq : Prop :=
  ∀ p : ℕ, p ≤ 10 ^ 4000 → (Defs.S_alpha_0 p ↔ p ∈ Defs.S_14)

/-- The Module-5 Bost sum of `S_4`, via `Twelve.C`. Noncomputable (real logs);
M5 certifies its value at `≈ 11.4221`. -/
noncomputable def C_S4 : ℝ := Twelve.C Defs.S_4

/-- M5 ATTESTATION (named, asserted by NO theorem): the Bost bound holds for the
leading prefix `S_4`, i.e. `C(S_4) > 2√13`. External `arb` certificate
(`paper/modules/m05-bostbound.tex`), NOT proved here. -/
def M5_BostBound_S4 : Prop := Twelve.BostBound Defs.S_4

/-- Companion attestation for the full certified window: the Bost bound also
holds for `Sexc = S_14` (`C(S_14) > 2√13`), since `S_4 ⊆ S_14` and every Bost
term is positive. Named, asserted by NO theorem. -/
def M5_BostBound_Sexc : Prop := Twelve.BostBound Sexc

end TheoremaAureum.Towers.Hodge.SMap
