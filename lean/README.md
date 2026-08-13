# lean — Clay Wall 3 C01-C08 + Zoe — 0 sorry trio

- `C01_Basic.lean` — `ComplexVariety` `HodgeTable` `bettiNum`
- `C02_AlgebraicCycles.lean` — `cycleClass` `CycleClassInHodgeLocus` OPEN
- `C03_HodgeStructure.lean` — `HodgeStr` `abelianH1` g — corrected compact Kähler
- `C04_Comparison.lean` — `DeRhamBettiComparison` `GAGA` OPEN
- `C05_Primitive.lean` — `HardLefschetz` `LefschetzDecomposition`
- `C06_Polarization.lean` — `MStar_times_zeta_J0143 = 12/11` product CORRECTED `mstar_zeta_gt_one` — was 12/11 division WRONG
- `C07_Abelian.lean` — `J0143_data` genus 5 CM `CyclotomicField 11` — `J0143_has_CM` — `HodgeConjecture_CM_OPEN` vs `HodgeConjectureAbelian` OPEN — bridge to `HodgeMathlib`
- `C08_HodgeClasses.lean` — 200 classes `class1_g3` anchor `ω₁₂+ω₃₄` rank 4>3 — `criterionBound` — `rankObstructionStatement`
- `Consolidated_Abelian_Definitions.lean` — this file — 317 defs `118+199`
- `ZoeComparisonTest.lean` — T1/T2 `choose_5_2=10` `rank_H_X5=15` excess `15>10` — T3 `summable_abs_zoeTerm` entire `R=∞` — T4 conditional `AnalyticObstruction` vacuous — `step3_degenerate C(1,2)=0`
- `HodgeMathlib.lean` `HodgeGenuine.lean` — genuine `WeierstrassCurve` + `CMFieldData`
- `Operator.lean` `OperatorV2.lean` — spectral schema Hamiltonian/mass gap `Δ>0` — links to **[yang-mills-gap](https://github.com/DavidFox998/yang-mills-gap)**
- `M9_WeilTransfer.lean` — 280-case VALOR `0 sorry`
- `Defs.lean` `Twelve.lean` `SMap.lean` — `S_14` `S(alpha0)` threshold `1/p → 1/(2·ln p)` M4 cert

All `#print axioms` → `{propext, Classical.choice, Quot.sound}` — `HodgeConjecture_CM_OPEN` named OPEN `def Prop`.
