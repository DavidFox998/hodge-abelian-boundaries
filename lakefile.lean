import Lake
open Lake DSL

package hodge_abelian_boundaries

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.12.0"

@[default_target]
lean_lib HodgeAbelian where
  srcDir := "lean"
  roots := #[`Consolidated_Abelian_Definitions, `HodgeGenuine, `HodgeCFPrimes]
