import Mathlib.Data.Real.Pi.Bounds
import Mathlib.Data.Real.Floor
import Defs

namespace HodgeCF

def alpha_0 : ℝ := Defs.alpha_0
def q₅ : ℕ := 226
def q₆ : ℕ := 165849
def p₅ : ℕ := 67645
def cf_bound : ℕ := 82829

theorem conv_5_approx :
    |alpha_0 - (p₅ : ℝ) / q₅| < 1 / ((q₅ : ℝ) * q₆) := by
  have h_sub : alpha_0 - (p₅ : ℝ) / q₅ = Real.pi / 10 - (71 : ℝ) / 226 := by
    unfold alpha_0 Defs.alpha_0 p₅ q₅; ring
  rw [h_sub]
  have h_pi_lb : Real.pi / 10 > (31415926535897932384 : ℝ) / 10^20 := by
    have h := pi_gt_d20; linarith
  have h_pi_ub : Real.pi / 10 < (31415926535897932385 : ℝ) / 10^20 := by
    have h := pi_lt_d20; linarith
  have h_71_gt_pi : Real.pi / 10 < (71 : ℝ) / 226 := by
    linarith [h_pi_ub, show (71 : ℝ) / 226 > (31415926535897932385 : ℝ) / 10^20 from by norm_num]
  rw [abs_of_neg (by linarith)]
  have h_target : (71 : ℝ) / 226 - 1 / ((226 : ℝ) * 165849) = (11775278 : ℝ) / 37481674 := by
    norm_num
  rw [h_target]
  have h_cross : (11775278 : ℝ) * 10^20 < (31415926535897932384 : ℝ) * 37481674 := by
    norm_num
  have : (11775278 : ℝ) / 37481674 < (31415926535897932384 : ℝ) / 10^20 := by
    apply div_lt_div; norm_num; norm_num; exact h_cross; norm_num
  linarith [this, h_pi_lb]

def CF_bound_strong_OPEN : Prop :=
  ∀ p : ℕ, Nat.Prime p → Defs.nearestIntDist ((p : ℝ) * alpha_0) < 1 / (p : ℝ) → p ≤ cf_bound

def CF_bound_82829_OPEN : Prop :=
  ∀ p : ℕ, Defs.S_alpha_0 p → p ≤ cf_bound

def P5_bridge_cert (p : ℕ) : Prop := p ∈ Defs.S_14 ∧ cf_bound < p

theorem M4_window_eq_reduction
    (h_cf : ∀ p : ℕ, Defs.S_alpha_0 p → p ≤ cf_bound)
    (h_finite : ∀ p : ℕ, p ≤ cf_bound → (Defs.S_alpha_0 p ↔ p ∈ Defs.S_14)) :
    ∀ p : ℕ, p ≤ 10^4000 → (Defs.S_alpha_0 p → p ∈ Defs.S_14) ∧ (p ∈ Defs.S_14 → Defs.S_alpha_0 p ∨ P5_bridge_cert p) := by
  intro p hp; constructor
  · intro h_sa; exact (h_finite p (h_cf _ h_sa)).mp h_sa
  · intro h_in; by_cases h_bound : p ≤ cf_bound; left; exact (h_finite p h_bound).mpr h_in; right; exact ⟨h_in, lt_of_not_le h_bound⟩

end HodgeCF
