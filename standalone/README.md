# Standalone additions — J₀(26) from beal-conjecture

Archival copies of the two elliptic factors of J₀(26). Nothing here imports the private `beal-level-26-foundations` or `level-26-foundations` repositories.

| File | Role |
| --- | --- |
| `certs/j0_26_decomposition.json` | Certificate from beal-conjecture `sagemath/certs/`, commit `e657d15c` (2026-09-04, v1.3.0). SHA-256 `35ea70c995f9aed3ae8e2f44cf231d0b7a3ae606e11ad5646635c47fa522a750`. |
| `standalone/J0_26_Decomp_Beal_Original.lean` | Archival copy of `factor26a1` / `factor26b1`. It imports Beal Level 26 modules and Mathlib, so it is not a target of this package. |
| `standalone/j0_26_decomp_foundation.sage` | Sage generator. The same file is at `sagemath/j0_26_decomp_foundation.sage`. |
| `Hodge/Abelian/G1_J0_26/J0_26_Two_Varieties_Standalone.lean` | Buildable copy: `factor26a1_standalone`, `factor26b1_standalone`, and the two length checks `qexpPrefix.length = 21`. No `axiom`, no `sorry`. |

Build the new module with:

```
lake build HodgeAbelianStandalone
```

The module name is `Hodge.Abelian.G1_J0_26.J0_26_Two_Varieties_Standalone`.
