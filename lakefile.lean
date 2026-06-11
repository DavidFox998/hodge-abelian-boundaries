import Lake
open Lake DSL

package hodge_abelian_boundaries

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.12.0"

@[default_target]
lean_lib HodgeAbelian where
  srcDir := "lean"
  roots := #[`C01_Basic, `C02_AlgebraicCycles, `C03_HodgeStructure,
             `C04_Comparison, `C05_Primitive, `C06_Polarization,
             `C07_Abelian, `C08_HodgeClasses, `ZoeComparisonTest]
