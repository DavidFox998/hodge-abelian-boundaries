import Mathlib
import Mathlib.Data.Real.Pi.Bounds
import Defs

/-!
# CERT_Arb Pattern: Prime Verification for S(α₀)

Opera Numerorum | David Fox | 2026

Verifies that the small primes in S_14 satisfy the exceptional-set condition
‖p·α₀‖ < 1/(2·ln p) using the CERT_Arb pattern (rational bounds + norm_num).

## Pattern
For each prime p:
1. Identify the nearest integer n to p·α₀ = 299p + p·π/10
2. Since 299p is integer, |p·α₀ - n| = |p·π/10 - (n - 299p)|
3. Bound |p·π/10 - m| from above using rational π bounds (pi_gt_d6, pi_lt_d6)
4. Bound 1/(2·ln p) from below using exp 1 ≥ 2 (hence exp N ≥ 2^N)
5. Conclude via `round_le`: nearestIntDist(x) ≤ |x - z| for any integer z

## Key lemma: round_le
Mathlib's `round_le` states |x - round(x)| ≤ |x - z| for all z : ℤ.
Since nearestIntDist(x) = |x - round(x)|, we get:
  nearestIntDist(p·α₀) ≤ |p·α₀ - n| < 1/(2·ln p)
without needing to compute round explicitly.

## Primes verified (CERT_Arb, 0 sorry, 0 axiom, 0 native_decide)
- p = 2:   ‖2·α₀‖ ≤ |π/5 - 1| < 0.372 < 0.5 ≤ 1/(2·ln 2)    ✓
- p = 3:   ‖3·α₀‖ ≤ |3π/10 - 1| < 0.058 < 0.25 ≤ 1/(2·ln 3)   ✓
- p = 19:  ‖19·α₀‖ ≤ |19π/10 - 6| < 0.031 < 0.1 ≤ 1/(2·ln 19)  ✓
- p = 191: ‖191·α₀‖ ≤ |191π/10 - 60| < 0.005 < 1/16 ≤ 1/(2·ln 191) ✓

The 3 large primes (3993746143633, 3224057731518397, 631474305334326148720631)
satisfy the condition with extreme margin (distance < 1e-13) but require >20-digit
π bounds not available in Mathlib v4.12.0. They are certified computationally
(M4 certificate, m4.out = Complete: True).

The remaining 7 primes in S_14 are certified via boundary certification
at p7 phase reversal (separate mechanism, not Diophantine approximation).

Clay rules: no sorry · no axiom · no opaque · no native_decide · no fun _ => trivial
-/

namespace HodgeCF

open Real

-- ===========================================================================
-- §1. Exponential helper lemmas
-- ===========================================================================

/-- exp 1 ≥ 2 (from add_one_le_exp: 1 + x ≤ exp x, applied at x = 1). -/
private theorem exp_one_ge_two : (2 : ℝ) ≤ exp 1 := by
  have h := add_one_le_exp (1 : ℝ)
  linarith

/-- exp 2 ≥ 4 (since exp 2 = (exp 1)² ≥ 2² = 4). -/
private theorem exp_two_ge_four : (4 : ℝ) ≤ exp 2 := by
  have h : exp 2 = exp 1 * exp 1 := by
    rw [show (2 : ℝ) = 1 + 1 from by norm_num, ← exp_add]
  rw [h]
  nlinarith [exp_one_ge_two, exp_pos 1]

/-- exp 5 ≥ 32 (since exp 5 = (exp 1)^5 ≥ 2^5 = 32). -/
private theorem exp_five_ge_32 : (32 : ℝ) ≤ exp 5 := by
  have h : exp 5 = exp 1 ^ 5 := by
    rw [show (5 : ℝ) = 1 + 1 + 1 + 1 + 1 from by norm_num]
    rw [← exp_add, ← exp_add, ← exp_add, ← exp_add]
    ring
  rw [h]
  nlinarith [exp_one_ge_two, exp_pos 1, show (2 : ℝ) ^ 5 = 32 from by norm_num]

/-- exp 8 ≥ 256 (since exp 8 = (exp 1)^8 ≥ 2^8 = 256). -/
private theorem exp_eight_ge_256 : (256 : ℝ) ≤ exp 8 := by
  have h : exp 8 = exp 1 ^ 8 := by
    rw [show (8 : ℝ) = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 from by norm_num]
    rw [← exp_add, ← exp_add, ← exp_add, ← exp_add,
        ← exp_add, ← exp_add, ← exp_add]
    ring
  rw [h]
  nlinarith [exp_one_ge_two, exp_pos 1, show (2 : ℝ) ^ 8 = 256 from by norm_num]

-- ===========================================================================
-- §2. Logarithm upper bounds
-- ===========================================================================

/-- ln 2 ≤ 1 (since exp 1 ≥ 2, so log 2 ≤ log(exp 1) = 1). -/
private theorem ln2_le_one : log 2 ≤ 1 := by
  exact log_le_log (by norm_num) exp_one_ge_two

/-- ln 3 < 2 (since exp 2 ≥ 4 > 3, so log 3 < log(exp 2) = 2). -/
private theorem ln3_lt_two : log 3 < 2 := by
  have h : (3 : ℝ) < exp 2 := by linarith [exp_two_ge_four]
  exact log_lt_log (by norm_num) h

/-- ln 19 < 5 (since exp 5 ≥ 32 > 19, so log 19 < log(exp 5) = 5). -/
private theorem ln19_lt_five : log 19 < 5 := by
  have h : (19 : ℝ) < exp 5 := by linarith [exp_five_ge_32]
  exact log_lt_log (by norm_num) h

/-- ln 191 < 8 (since exp 8 ≥ 256 > 191, so log 191 < log(exp 8) = 8). -/
private theorem ln191_lt_eight : log 191 < 8 := by
  have h : (191 : ℝ) < exp 8 := by linarith [exp_eight_ge_256]
  exact log_lt_log (by norm_num) h

-- ===========================================================================
-- §3. nearestIntDist ≤ |x - n| (from Mathlib's round_le)
-- ===========================================================================

/-- nearestIntDist(x) ≤ |x - z| for any integer z.
    This is Mathlib's `round_le`: |x - round(x)| ≤ |x - z|.
    Since nearestIntDist(x) = |x - round(x)|, the result follows. -/
private theorem nearestIntDist_le (x : ℝ) (z : ℤ) :
    Defs.nearestIntDist x ≤ |x - (z : ℝ)| := by
  unfold Defs.nearestIntDist
  exact round_le x z

-- ===========================================================================
-- §4. Prime p = 2
-- ===========================================================================

/-- S_alpha_0 2: ‖2·α₀‖ < 1/(2·ln 2).
    2·α₀ = 598 + π/5. Nearest integer: 599.
    |2·α₀ - 599| = |π/5 - 1| = 1 - π/5 (since π < 5).
    Upper bound: π > 3.1415926 → 1 - π/5 < 1 - 3.1415926/5 < 0.372.
    Lower bound: ln 2 ≤ 1 → 1/(2·ln 2) ≥ 1/2.
    0.372 < 0.5 ✓ -/
theorem S_alpha_0_prime_2 : Defs.S_alpha_0 2 := by
  unfold Defs.S_alpha_0
  refine ⟨by norm_num, ?_⟩
  -- nearestIntDist(2 * alpha_0) ≤ |2 * alpha_0 - 599|
  apply le_trans (nearestIntDist_le ((2 : ℝ) * Defs.alpha_0) 599)
  -- |2 * alpha_0 - 599| = |π/5 - 1| = 1 - π/5
  have h_sub : (2 : ℝ) * Defs.alpha_0 - 599 = Real.pi / 5 - 1 := by
    unfold Defs.alpha_0; ring
  have h_pi_lt_5 : Real.pi < 5 := by linarith [pi_lt_d6]
  have h_abs : |Real.pi / 5 - 1| = 1 - Real.pi / 5 := by
    rw [abs_of_nonpos]; linarith [h_pi_lt_5]; linarith [h_pi_lt_5]
  rw [h_sub, h_abs]
  -- Need: 1 - π/5 < 1 / (2 * log 2)
  -- Strategy: dist ≤ 1 - 3.1415926/5 < 1/2 ≤ 1/(2 * log 2)
  have h_pi_gt : 3.1415926 < Real.pi := pi_gt_d6
  have h_ln2_le : log 2 ≤ 1 := ln2_le_one
  have h_log2_pos : 0 < log 2 := log_pos (by norm_num : (1 : ℝ) < 2)
  -- 1 - π/5 ≤ 1 - 3.1415926/5 (since π ≥ 3.1415926)
  have h_dist_ub : 1 - Real.pi / 5 ≤ 1 - 3.1415926 / 5 := by linarith [h_pi_gt]
  -- 1 - 3.1415926/5 < 1/2 (norm_num)
  have h_mid : 1 - 3.1415926 / 5 < 1 / 2 := by norm_num
  -- 1/2 ≤ 1/(2 * log 2) (since log 2 ≤ 1 and log 2 > 0)
  have h_thresh_lb : 1 / 2 ≤ 1 / (2 * log 2) := by
    have h_2log_le_2 : 2 * log 2 ≤ 2 := by linarith
    have h_2log_pos : 0 < 2 * log 2 := by linarith [h_log2_pos]
    exact (div_le_div_iff (by norm_num : (0 : ℝ) < 2) h_2log_pos).mpr h_2log_le_2
  linarith [h_dist_ub, h_mid, h_thresh_lb, h_log2_pos]

-- ===========================================================================
-- §5. Prime p = 3
-- ===========================================================================

/-- S_alpha_0 3: ‖3·α₀‖ < 1/(2·ln 3).
    3·α₀ = 897 + 3π/10. Nearest integer: 898.
    |3·α₀ - 898| = |3π/10 - 1| = 1 - 3π/10 (since 3π/10 < 1).
    Upper bound: π > 3.1415926 → 1 - 3π/10 < 0.058.
    Lower bound: ln 3 < 2 → 1/(2·ln 3) > 1/4.
    0.058 < 0.25 ✓ -/
theorem S_alpha_0_prime_3 : Defs.S_alpha_0 3 := by
  unfold Defs.S_alpha_0
  refine ⟨by norm_num, ?_⟩
  apply le_trans (nearestIntDist_le ((3 : ℝ) * Defs.alpha_0) 898)
  have h_sub : (3 : ℝ) * Defs.alpha_0 - 898 = 3 * Real.pi / 10 - 1 := by
    unfold Defs.alpha_0; ring
  have h_pi_lt : 3 * Real.pi / 10 < 1 := by linarith [pi_lt_d6]
  have h_abs : |3 * Real.pi / 10 - 1| = 1 - 3 * Real.pi / 10 := by
    rw [abs_of_nonpos]; linarith [h_pi_lt]; linarith [h_pi_lt]
  rw [h_sub, h_abs]
  -- dist ≤ 1 - 3*3.1415926/10 < 1/4 < 1/(2 * log 3)
  have h_pi_gt : 3.1415926 < Real.pi := pi_gt_d6
  have h_ln3_lt : log 3 < 2 := ln3_lt_two
  have h_log3_pos : 0 < log 3 := log_pos (by norm_num : (1 : ℝ) < 3)
  have h_dist_ub : 1 - 3 * Real.pi / 10 ≤ 1 - 3 * 3.1415926 / 10 := by linarith [h_pi_gt]
  have h_mid : 1 - 3 * 3.1415926 / 10 < 1 / 4 := by norm_num
  have h_thresh_lb : 1 / 4 < 1 / (2 * log 3) := by
    have h2pos : 0 < 2 * log 3 := by linarith [h_log3_pos]
    exact (div_lt_div_iff (by norm_num : (0 : ℝ) < 4) h2pos).mpr
      (by linarith [h_log3_pos, h_ln3_lt])
  linarith [h_dist_ub, h_mid, h_thresh_lb, h_log3_pos]

-- ===========================================================================
-- §6. Prime p = 19
-- ===========================================================================

/-- S_alpha_0 19: ‖19·α₀‖ < 1/(2·ln 19).
    19·α₀ = 5681 + 19π/10. Nearest integer: 5687.
    |19·α₀ - 5687| = |19π/10 - 6| = 6 - 19π/10 (since 19π/10 < 6).
    Upper bound: π > 3.1415926 → 6 - 19π/10 < 0.031.
    Lower bound: ln 19 < 5 → 1/(2·ln 19) > 1/10.
    0.031 < 0.1 ✓ -/
theorem S_alpha_0_prime_19 : Defs.S_alpha_0 19 := by
  unfold Defs.S_alpha_0
  refine ⟨by norm_num, ?_⟩
  apply le_trans (nearestIntDist_le ((19 : ℝ) * Defs.alpha_0) 5687)
  have h_sub : (19 : ℝ) * Defs.alpha_0 - 5687 = 19 * Real.pi / 10 - 6 := by
    unfold Defs.alpha_0; ring
  have h_pi_lt : 19 * Real.pi / 10 < 6 := by linarith [pi_lt_d6]
  have h_abs : |19 * Real.pi / 10 - 6| = 6 - 19 * Real.pi / 10 := by
    rw [abs_of_nonpos]; linarith [h_pi_lt]; linarith [h_pi_lt]
  rw [h_sub, h_abs]
  -- dist ≤ 6 - 19*3.1415926/10 < 1/10 < 1/(2 * log 19)
  have h_pi_gt : 3.1415926 < Real.pi := pi_gt_d6
  have h_ln19_lt : log 19 < 5 := ln19_lt_five
  have h_log19_pos : 0 < log 19 := log_pos (by norm_num : (1 : ℝ) < 19)
  have h_dist_ub : 6 - 19 * Real.pi / 10 ≤ 6 - 19 * 3.1415926 / 10 := by linarith [h_pi_gt]
  have h_mid : 6 - 19 * 3.1415926 / 10 < 1 / 10 := by norm_num
  have h_thresh_lb : 1 / 10 < 1 / (2 * log 19) := by
    have h2pos : 0 < 2 * log 19 := by linarith [h_log19_pos]
    exact (div_lt_div_iff (by norm_num : (0 : ℝ) < 10) h2pos).mpr
      (by linarith [h_log19_pos, h_ln19_lt])
  linarith [h_dist_ub, h_mid, h_thresh_lb, h_log19_pos]

-- ===========================================================================
-- §7. Prime p = 191
-- ===========================================================================

/-- S_alpha_0 191: ‖191·α₀‖ < 1/(2·ln 191).
    191·α₀ = 57109 + 191π/10. Nearest integer: 57169.
    |191·α₀ - 57169| = |191π/10 - 60| = 191π/10 - 60 (since 191π/10 > 60).
    Upper bound: π < 3.1415927 → 191π/10 - 60 < 0.005.
    Lower bound: ln 191 < 8 → 1/(2·ln 191) > 1/16.
    0.005 < 0.0625 ✓ -/
theorem S_alpha_0_prime_191 : Defs.S_alpha_0 191 := by
  unfold Defs.S_alpha_0
  refine ⟨by norm_num, ?_⟩
  apply le_trans (nearestIntDist_le ((191 : ℝ) * Defs.alpha_0) 57169)
  have h_sub : (191 : ℝ) * Defs.alpha_0 - 57169 = 191 * Real.pi / 10 - 60 := by
    unfold Defs.alpha_0; ring
  have h_pi_gt_60 : 60 < 191 * Real.pi / 10 := by linarith [pi_gt_d6]
  have h_abs : |191 * Real.pi / 10 - 60| = 191 * Real.pi / 10 - 60 := by
    rw [abs_of_nonneg]; linarith [h_pi_gt_60]
  rw [h_sub, h_abs]
  -- dist ≤ 191*3.1415927/10 - 60 < 1/16 < 1/(2 * log 191)
  have h_pi_lt : Real.pi < 3.1415927 := pi_lt_d6
  have h_ln191_lt : log 191 < 8 := ln191_lt_eight
  have h_log191_pos : 0 < log 191 := log_pos (by norm_num : (1 : ℝ) < 191)
  have h_dist_ub : 191 * Real.pi / 10 - 60 ≤ 191 * 3.1415927 / 10 - 60 := by linarith [h_pi_lt]
  have h_mid : 191 * 3.1415927 / 10 - 60 < 1 / 16 := by norm_num
  have h_thresh_lb : 1 / 16 < 1 / (2 * log 191) := by
    have h2pos : 0 < 2 * log 191 := by linarith [h_log191_pos]
    exact (div_lt_div_iff (by norm_num : (0 : ℝ) < 16) h2pos).mpr
      (by linarith [h_log191_pos, h_ln191_lt])
  linarith [h_dist_ub, h_mid, h_thresh_lb, h_log191_pos]

-- ===========================================================================
-- §8. Summary theorem
-- ===========================================================================

/-- The first 4 primes of S_14 satisfy S_alpha_0 (the exceptional-set condition
    ‖p·α₀‖ < 1/(2·ln p)), verified by the CERT_Arb pattern.

    The remaining primes are certified by:
    - Primes 5-7 (3993746143633, 3224057731518397, 631474305334326148720631):
      Computational certificate (m4.out = Complete: True). These satisfy the
      condition with extreme margin (distance < 1e-13) but require >20-digit
      π bounds not available in Mathlib v4.12.0.
    - Primes 8-14: Boundary certification at p7 phase reversal (separate mechanism). -/
theorem S_14_small_primes_certified :
    ∀ p ∈ ({2, 3, 19, 191} : Finset ℕ), Defs.S_alpha_0 p := by
  intro p hp
  simp only [Finset.mem_insert, Finset.mem_singleton] at hp
  rcases hp with rfl | rfl | rfl | rfl | _
  · exact S_alpha_0_prime_2
  · exact S_alpha_0_prime_3
  · exact S_alpha_0_prime_19
  · exact S_alpha_0_prime_191

end HodgeCF
