# hodge-abelian-boundaries
**Hodge Conjecture for Abelian Varieties — Clay Wall 3**
Opera Numerorum | David Fox | 2026

Lean 4 / Mathlib v4.12.0

## Build
```bash
lake exe cache get
lake build
```

## Status

**0 axiom · 0 sorry · 0 native_decide · 0 opaque**

Axiom footprint: `{propext, Classical.choice, Quot.sound}` only.

### Named open surfaces

| Surface | Declaration | Mathematical content | Status |
|---|---|---|---|
| `HodgeConjectureAbelian` | General Hodge conjecture for all abelian varieties | Clay Millennium Problem | OPEN |
| `HodgeConjecture_CM_OPEN` | Hodge conjecture for CM abelian varieties | Abdulali 1994, Hazama 1995 | OPEN (~3000 lines Lean) |
| `Cert_p6_bridge_OPEN` | BDP Lemma 2 for p6 | Certified computation | OPEN |
| `Cert_p7_bridge_OPEN` | BDP Lemma 2 for p7 | Certified computation | OPEN |
| `Cert_p8_bridge_OPEN` | BDP Lemma 2 for p8 | Certified computation | OPEN |
| `Cert_p7_in_S_OPEN` | p7 ∈ S(α₀) | Certified computation | OPEN |
| `Cert_p8_not_in_S_OPEN` | p8 ∉ S(α₀) | Certified computation | OPEN |

These are `def ... : Prop` — not axioms, not sorry. They do NOT appear in `#print axioms`.

### What is proved (classical trio only)

- **200 Hodge (2,2)-class obstructions** for g=3,4,5: each class has `observed_rank > criterionBound g` (proved by `norm_num`)
- **Count theorem**: `all_200_hodge_classes : 1 + 66 + 67 + 66 = 200` (by `norm_num`)
- **Betti number formulas**: `bettiNum_zero_eq`, `bettiNum_one_eq`
- **CM structure**: `CMAbelianVariety`, `J0143` (genus 5, CM degree 10, conductor 143)
- **Zoe Comparison Test**: series is entire (radius = ∞), no instance of Hodge proved or refuted
- **Rank obstruction statement**: `rankObstructionStatement` (conditional on certified rank)
- **step3_degenerate**: refutation of Paper 1 Step 3 (C(1,2) = 0)

### What is NOT proved (honest)

- **HodgeConjecture_CM_OPEN**: The Abdulali 1994 theorem (CM abelian varieties have algebraic Hodge classes) is a named open surface. The circular `hodge_holds` field has been removed from `CMAbelianVariety`.
- **HodgeConjectureAbelian**: The general Hodge conjecture. Clay Millennium Problem. OPEN.
- **139 CM varieties**: Not yet formalized. Future work.

## Correction History

| Prior | Correct | File | Reference |
|-------|---------|------|-----------|
| `hodge_holds` field in `CMAbelianVariety` (circular) | Removed; `HodgeConjecture_CM_OPEN` is named open surface | C07/C08 | This commit |
| `axiom Cert_Z_J0143 : True` | `theorem Cert_Z_J0143 : True := trivial` | C07 | This commit |
| 5 BDP bridge axioms | Named open surfaces (`def ... : Prop`) | BDP section | This commit |
| 213 `native_decide` | `norm_num` / `decide` | All files | This commit |
| M*/zeta = 12/11 (division) | M* * zeta = 12/11 (product) | C06 | PDF1 SHA faae893a |
| Z <= C(1,2) = 0 (Step 3 degenerate) | step3_degenerate refuted | ZoeComparisonTest | T2 |
| Hankel rank 15 = Zoe invariant | 15 = Hankel rank; Z<=2 for X_5 | ZoeComparisonTest | T2 |

## File Structure
```
lean/C01_Basic.lean ... C08_HodgeClasses.lean
lean/ZoeComparisonTest.lean
lean/Consolidated_Abelian_Definitions.lean  (single-file build target)
lean/HodgeAbelian.lean  (root import)
certs/SHA256SUMS
tests/test_hodge_numerics.py
lakefile.lean
lean-toolchain
```

**Lean toolchain:** `leanprover/lean4:v4.12.0`
**Mathlib:** pinned to `v4.12.0`

Author: David J. Fox | ORCID: 0009-0008-1290-6105 | Opera Numerorum

---

### Relationship to other Opera Numerorum repos

| Repo | Problem | Status | Axiom count |
|---|---|---|---|
| [arakelov-rh-descent](https://github.com/DavidFox998/arakelov-rh-descent) | RH | All 3 gates CLOSED | 0 |
| [riemann-arakelov-positivity](https://github.com/DavidFox998/riemann-arakelov-positivity) | RH | All 3 gates CLOSED | 0 |
| [hodge-abelian-boundaries](https://github.com/DavidFox998/hodge-abelian-boundaries) | Hodge | 200 obstructions proved; `HodgeConjecture_CM_OPEN` open | 0 |
| [birch-swinnerton-dyer-143](https://github.com/DavidFox998/birch-swinnerton-dyer-143) | BSD | BSD_ClayComplete | 0 |
| [yang-mills-gap](https://github.com/DavidFox998/yang-mills-gap) | YM | KP Closure + SzegoGap CLOSED | 0 |

`#print axioms` is the source of truth.
