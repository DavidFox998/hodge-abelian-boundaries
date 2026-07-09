import Lake
open Lake DSL

package hodge_abelian_boundaries

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.12.0"

@[default_target]
lean_lib HodgeAbelian where
  srcDir := "lean"
  roots := #[
    `Consolidated_Abelian_Definitions,
    `HodgeMathlib,
    `HodgeBridge,
    `Defs,
    `Twelve,
    `SMap,
    `ZoeComparisonTest,
    `M9_WeilTransfer,
    `Compute,
    `AutoLemmas,
    `Operator,
    `OperatorV2,
    `UniformGap_Placeholder,
    `Perron_Placeholder,
    `SUPERBRIC_MORNINGSTAR_1419
  ]
