# hodge-abelian-boundaries

200 obstructed (2,2)-classes on X_g = Jac(y^2 = x^(2g+1) - x), g in {3,4,5}.
Three-paper correction record. Computational boundary for the Hodge conjecture.

Opera Numerorum / Battle Plan v1.6 | David J. Fox | ORCID: 0009-0008-1290-6105

## The 200 classes

| g | Variety | Criterion C(g,2) | Classes | Status |
|---|---------|-----------------|---------|--------|
| 3 | X_3 = Jac(y^2=x^7-x)  | C(3,2)=3  | 67 | CERTIFIED rank>=4 |
| 4 | X_4 = Jac(y^2=x^9-x)  | C(4,2)=6  | 67 | CERTIFIED rank>=7 |
| 5 | X_5 = Jac(y^2=x^11-x) | C(5,2)=10 | 66 | M8C-certified Z=15>10 |

Dataset SHA: 2b56180c490603a5044e871a16316d83d7a2d5ece14a1fb0e4cc70e28d0a4449

Contrast: J_0(143) (CM abelian variety) has Z=1 -- Hodge class IS algebraic.
M* x zeta_throat = 12/11 (Lemma 7.6 realized). The 200 classes document the
computational boundary, not counterexamples to the Hodge conjecture.

## Three-paper corrections (v1.7-Replicit)

1. Paper 1 (Linear Recurrence / Lemma 7.6):
   - Lemma 7.6: inverted product -> M* x zeta = 12/11  REALIZED
   - gamma_1: not realized -> pi/10  REALIZED
   - Delta phi: pi/6 -> pi/5  REALIZED
   - ebit count: 200 x 13 = 2600 -> 200 x 14 = 2800  REALIZED

2. Paper 2 (Rank Obstructions):
   - Step 3: C(dim NS, p) = C(1,2) = 0 for X_5  DEGENERATE
   - Conflates wedge-of-NS dimension with tensor rank
   - Machine-checked: ZoeComparisonTest.lean step3_degenerate

3. Paper 3 (Tensor Rank / Zoe Comparison):
   - Prior claim: T(w,s) has radius of convergence 0 (pole at s=1)
   - Corrected: T(w,s) is ENTIRE (R = infinity)
   - Machine-checked: ZoeComparisonTest.lean T3 radius_infinite

## Certificates

| File | Contents | SHA |
|------|----------|-----|
| certificates/Hodge_CM_Replicit_v17_PDF1.pdf | Paper 1 Lemma 7.6 | faae893a... |
| certificates/Hodge_CM_Replicit_v17_PDF2.pdf | Paper 1 phase invariant | 233ba2df... |
| certificates/Hodge_Measurements_v17_PDF3.pdf | 200-class report (this) | 7e597d98e744ed73... |

## Lean (SORRY: 0)

| File | Contents | SHA |
|------|----------|-----|
| lean/C08_HodgeClasses.lean | 200-class formal treatment | 58d50f0c90e043b6... |
| lean/ZoeComparisonTest.lean | T3+T4+step3 machine-checks | e31d411bde75c821... |

## Chain position

opera-sieve (Wall 0) -> RH-Core (Wall 1) -> NS-Tower (Wall 4.5) -> AllCerts (Wall 5)
This repo: companion to NS-Tower; Hodge work supporting the Clay submission.

## Zenodo

AllCerts ZIP: https://doi.org/10.5281/zenodo.20585288
