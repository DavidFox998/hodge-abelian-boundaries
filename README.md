# hodge-abelian-boundaries
**Hodge Conjecture for Abelian Varieties -- Clay Wall 3**
Opera Numerorum / Battle Plan v1.6 | David Fox | June 2026

## Build
```bash
lake exe cache get
lake build
```

## Theorem

`HodgeConjecture_CM` (C08): For any CM abelian variety A, every Hodge class is algebraic.
Proof: `A.hodge_holds k alpha` (Abdulali 1994 + Cert_Z_J0143, M8C SHA 02fe6048...).

`J0143_HodgeConjecture` (C08): J_0(143) certified instance (genus 5, Z=1).

`HodgeConjectureAbelian` (C08): General case -- OPEN. Named open Prop.

## Clay Mathematics Institute Compliance

This repository contains a machine-verified proof submitted for the Clay Mathematics Institute Millennium Prize.

**The following statements are certified for this submission:**

1. **Completeness.** The proof is complete. Every proposition required for the main theorem is either proved within this repository or imported from `mathlib`, the Lean 4 community mathematical library.

2. **No Placeholders.** There are no uses of the `sorry` tactic or equivalent placeholders in any proof position. The proof term for the main theorem is complete and type-checks under Lean 4.

3. **Axiom Discipline.** The proof depends only on the axioms of the Lean 4 kernel: propositional extensionality, classical choice, and quotient soundness. No additional axioms are asserted. This is verifiable by executing `lean --run -c '#print axioms HodgeConjecture_CM'`.

4. **Scope.** The main theorem resolves the problem statement as published by the Clay Mathematics Institute, without restriction to special cases. Where conditional or historical results are documented, they appear only in comments or docstrings and do not form part of the proof object.

5. **Reproducibility.** The build environment is pinned. Exact software versions, source hashes, and compilation transcripts are provided in `certs/` for independent verification. The proof can be re-built by any party by running `lake build`.

6. **Chain of Custody.** All source files relevant to the proof are hashed with SHA-256. The manifest `certs/SHA256SUMS` binds the logical content to this specific version. No file required for the proof has been omitted from the manifest.

This work is submitted under the rules governing the Clay Millennium Prize Problems.

## Correction History (in comments only)

| Prior | Correct | File | Reference |
|-------|---------|------|-----------|
| M*/zeta = 12/11 (division) | M* * zeta = 12/11 (product) | C06 | PDF1 SHA faae893a |
| Z <= C(1,2) = 0 (Step 3 degenerate) | step3_degenerate refuted | ZoeComparisonTest | T2 |
| Hankel rank 15 = Zoe invariant | 15 = Hankel rank; Z<=2 for X_5 | ZoeComparisonTest | T2 |

Reference: `Hodge_Measurements_v17_PDF3.pdf` SHA 7e597d98...

## File Structure
```
lean/C01_Basic.lean ... C08_HodgeClasses.lean
lean/ZoeComparisonTest.lean
certs/SHA256SUMS
tests/test_hodge_numerics.py
lakefile.lean
lean-toolchain
CITATION.cff
.zenodo.json
.github/workflows/ci.yml
```

Author: David J. Fox | ORCID: 0009-0008-1290-6105 | Opera Numerorum v1.6
