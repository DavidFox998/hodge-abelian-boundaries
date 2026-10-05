# G1_J0_26 — two varieties from X₀(26)

**What is in this folder.** One Lean file, four definitions: `factor26a1_standalone`, `factor26b1_standalone`, `qexp26a1_prefix_eq_ledger`, and `qexp26b1_prefix_eq_ledger`.

| | `26a(1,26)` | `26b(1,26)` |
| --- | --- | --- |
| Cremona | `26a1` | `26b1` |
| Weierstrass | `[1, 0, 1, -5, -8]` | `[1, -1, 1, -3, 3]` |
| Δ | `-17576` | `-1664` |
| q-expansion | `a₀` through `a₂₀`, length 21 | `a₀` through `a₂₀`, length 21 |
| BSD L/Ω | `1/3` | `1/7` |

**How it works.** The file imports nothing. The length checks are `rfl`. There is no `axiom` and no `sorry` in this file. The BSD numerals come from `J0_26_BSD_26a1_26b1.lean` in beal-conjecture. The certificate `certs/j0_26_decomposition.json` is the v1.3.0 Sage record (`e657d15c`).

**How it fits.** The 200 measured classes for g=3, 4, and 5 stay in `lean/Consolidated_Abelian_Definitions.lean`. This directory adds the g=1 J₀(26) factors beside that record. It does not prove that the prefixes determine `criterionBound`, and it does not prove the Hodge conjecture.

**Build.** `lake build HodgeAbelianStandalone`
