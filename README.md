[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21926558.svg)](https://doi.org/10.5281/zenodo.21926558) [![CI](https://github.com/DavidFox998/hodge-abelian-boundaries/actions/workflows/ci.yml/badge.svg)](https://github.com/DavidFox998/hodge-abelian-boundaries/actions/workflows/ci.yml)

# hodge-abelian-boundaries — measured Hodge classes, plus two J₀(26) factors

Lean record of measured Hodge (2,2)-class obstructions on CM abelian varieties, with a standalone g=1 layer taken from the beal-conjecture Level 26 scaffold.

This repository does not prove the Hodge conjecture.

## Counts on this branch

Counted from `*.lean` files outside `.lake` and `.git`, before the new file: **391** `def`s, **366** `theorem`s, **39** `structure`s, **9** `abbrev`s, **6** `axiom`s, **28** Lean files.

The 200 measured class definitions are in `lean/Consolidated_Abelian_Definitions.lean`:

- g=3: `class1_g3` … `class67_g3` (67)
- g=4: `class1_g4` … `class67_g4` (67)
- g=5: `class1_g5` … `class66_g5` (66)

67 + 67 + 66 = 200. The other 191 `def`s are the rest of that 391. The new file adds four `def`s (`factor26a1_standalone`, `factor26b1_standalone`, and the two prefix-length checks), so the tree then has 395 `def`s.

The six existing axioms are unchanged: `Cert_Z_J0143` in `lean/C07_Abelian.lean`, and `Cert_p6_bridge`, `Cert_p7_bridge`, `Cert_p8_bridge`, `Cert_p7_in_S`, `Cert_p8_not_in_S` in `lean/C08_HodgeClasses.lean`. The new J₀(26) file adds no `axiom` and no `sorry`. No proof in the tree uses the `sorry` tactic. The word appears in comments.

## New varieties — g=1 from X₀(26) / J₀(26)

Two elliptic factors, dimension 1+1 = 2. Data copied from `certs/j0_26_decomposition.json` (beal-conjecture `e657d15c`, 2026-09-04, v1.3.0). The BSD quotients are the numerals in beal-conjecture `J0_26_BSD_26a1_26b1.lean`. They are not fields of that JSON.

- `26a(1,26)`, Cremona `26a1`, Weierstrass `[1, 0, 1, -5, -8]`, Δ = `-17576`, q-expansion `a₀`…`a₂₀` = `[0, 1, -1, 1, 1, -3, -1, -1, -1, -2, 3, 6, 1, 1, 1, -3, 1, -3, 2, 2, -3]`, L/Ω = `1/3`
- `26b(1,26)`, Cremona `26b1`, Weierstrass `[1, -1, 1, -3, 3]`, Δ = `-1664`, q-expansion `a₀`…`a₂₀` = `[0, 1, 1, -3, 1, -1, -3, 1, 1, 6, -1, -2, -3, -1, 1, 3, 1, -3, 6, 6, -1]`, L/Ω = `1/7`

The buildable module is `Hodge/Abelian/G1_J0_26/J0_26_Two_Varieties_Standalone.lean`. It does not import beal-conjecture. `standalone/J0_26_Decomp_Beal_Original.lean` is an archival copy of the original Lean file and is not a build target. The generator is `sagemath/j0_26_decomp_foundation.sage`.

In beal-conjecture, `frey_modular_13` (`FreyModularity_13.lean`) and `ribet_level_lowering_26` (`RibetLevelLowering_26.lean`) are axioms that sit on this geometry. They are not copied in as theorems here.

## Layout

- `lean/Consolidated_Abelian_Definitions.lean` — the 200 class definitions for g=3, 4, 5
- `Hodge/Abelian/G3_J0_143/`, `G4_J0_143/`, `G5_J0_143/` — indexes for those 67, 67, and 66 classes
- `Hodge/Abelian/G1_J0_26/` — the two new J₀(26) factors
- `certs/j0_26_decomposition.json` — the v1.3.0 certificate
- `standalone/` — archival Lean and Sage copies, no private imports

## Opera Numerorum — public repos

Routes A–D are the public workspace [riemann-hypothesis-four-routes](https://github.com/DavidFox998/riemann-hypothesis-four-routes).

[arakelov-positivity-rh-core](https://github.com/DavidFox998/arakelov-positivity-rh-core) — ROOT V2 — Arakelov height ω²=48/13>0 ; Zoe-M*, M4 10^4000 boundary — provides height input all RH voices reuse

[rh-p5-bridge-14](https://github.com/DavidFox998/rh-p5-bridge-14) — Keystone — q5=226, q6=165849, cf_bound=82829 — reduces infinite S_a0 to finite S14 ; closes BSD_143_PROVED → RiemannHypothesis — condensed single checkout 6cefaf3 PR78 verify ensemble green da3b943c662f vs lock 6ec00281c55d lake build Towers 0

[riemann-hypothesis-four-routes](https://github.com/DavidFox998/riemann-hypothesis-four-routes) — Four Routes — PUBLICATION WORKSPACE Routes A-D — RH Core, P5 bridge, four independent formal routes preserved at exact revisions one toolchain one RH predicate — Route A Act I Abbes-Ullmo ω²=48/13>0 Siegel zero → negative height, Route B Act II Kim-Sarnak λ1≥975/4096 Selberg=Bost-Connes GRH X0(143)→RH 35pp BC6, Route C Act III Littlewood Ω exp(c√(log t / log log t)) beats (log t)² zero repulsion, Route D Act IV Dirichlet jitter ‖p·a_q‖<1/p 35 brothers collision-free swarming orbit stability Re=1/2 — all CLOSED via S4 — 7ce83ae

[bost-connes](https://github.com/DavidFox998/bost-connes) — Arithmetic hub — C(S4)=11.422...>2√13, Gates M1-M3→M4-M8, 21 bricks 0 sorry — #173 GREEN

[birch-swinnerton-dyer-143a1](https://github.com/DavidFox998/birch-swinnerton-dyer-143a1) — BSD 143a1 — rank 1, Heegner point (4,6), L(143a1,1)≠0, |Sha|=1 — worked example M1-M5 arithmetic in action

[lindelof-hypothesis-143](https://github.com/DavidFox998/lindelof-hypothesis-143) — Lindelöf for X0(143) — GRH → μ=0 → |ζ(½+it)|=O(t^ε) unconditional via S4

[eutheos-property](https://github.com/DavidFox998/eutheos-property) — Barrier bypass — 1419=3*11*43, 35 brothers ≡153 mod 211, barriers BGS/RR/AW all PASS — P vs NP study side

[poincare-spectral](https://github.com/DavidFox998/poincare-spectral) — Spectral gap — S³/I*, q=1/8, tail_26s10⁻²⁰, spectral_gap>0 — decidable instance of undecidable gap problem

[p-vs-np](https://github.com/DavidFox998/p-vs-np) — P vs NP mechanics — 225 bricks, ConductorHash, conditional SAT∉P→P≠NP — DOI 10.5281/zenodo.21303093

[hodge-abelian-boundaries](https://github.com/DavidFox998/hodge-abelian-boundaries) — ← this repo — 200 measured classes for g=3, 4, 5, plus the two J₀(26) factors `26a1` and `26b1`

[yang-mills-gap](https://github.com/DavidFox998/yang-mills-gap) — Yang-Mills mass gap — SU(2) on R⁴, p<1/7, Δ>0, Wilson area law — same gap structure as C(S4)-2√13

[navier-stokes](https://github.com/DavidFox998/navier-stokes) — Navier-Stokes — Path A ESS backward uniqueness + Path B 120-cell H¹ balance — NS_M6_PROVED, no blowup

[zerobeacon](https://github.com/DavidFox998/zerobeacon) — MCP server — 1000 collision-proof tools; beacon 1d2c7a5b, m4.out = Complete: True

[beal-conjecture](https://github.com/DavidFox998/beal-conjecture) — Beal Level 26 — beal-v38 EQUIV:3 a2a23292 PR25 792b3f8 chartOfModelTrue_injective_from_Ei_constraint B=1 nonzero Y³≠0 Y³ outside cusp centreNormalPoly (X³-1)0 outside I² centreAlphaBound 2 0=1 X+V² outside cusp ann(1+Y·S³)≠ann(X²) [propext,choice,Quot.sound] 7 thm 355 + beal-v39-even 1fc6071→6f921f45 — www.beal-conjecture.com — DOI 10.5281/zenodo.23120540 superseded by 02728795 — pattern for opera 19→1

[opera-sieve](https://github.com/DavidFox998/opera-sieve) — Canonical sieve for S(alpha_0=299+π/10): computational + Lean verification

[birch-swinnerton-dyer-143](https://github.com/DavidFox998/birch-swinnerton-dyer-143) — BSD 143 — unconditional BSD for 143a1 — Rank=ord_L=1

## Build

Lean `v4.12.0`, Mathlib `v4.12.0`, from `lean-toolchain` and `lakefile.lean`.

```
lake exe cache get
lake build
lake build HodgeAbelianStandalone
```

`lake build` is the default library `Hodge` (`lean/C01` … `lean/C08`). `HodgeAbelianStandalone` is the J₀(26) module `Hodge.Abelian.G1_J0_26.J0_26_Two_Varieties_Standalone`.

## Author

David J. Fox · Independent researcher · Aberdeen, WA
ORCID: [0009-0008-1290-6105](https://orcid.org/0009-0008-1290-6105)
