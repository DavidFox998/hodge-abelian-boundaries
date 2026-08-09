import Lake
open Lake DSL

package hodge_abelian_boundaries where
  version := v!"0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.12.0"

@[default_target]
lean_lib HodgeAbelian where
  srcDir := "lean"
-- NO roots = build ALL files in lean/ : C01..C08, Defs, HodgeMathlib, ZoeComparisonTest, etc.
-- This builds your 200 + twerp's extra info, with correct dependency order
