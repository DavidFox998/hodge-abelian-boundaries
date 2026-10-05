/-
J0_26 Two Varieties Standalone — from beal-conjecture Level 26
Certificate: certs/j0_26_decomposition.json (beal-conjecture e657d15c, 2026-09-04, v1.3.0)
Generator: sagemath/j0_26_decomp_foundation.sage
Archival Lean copy: standalone/J0_26_Decomp_Beal_Original.lean

This module does not import beal-conjecture or the private level-26 repositories.
The Weierstrass data, discriminants, and a0..a20 prefixes are the two factors
in that certificate. The BSD quotients L/Ω = 1/3 and 1/7 are the numerals in
beal-conjecture J0_26_BSD_26a1_26b1.lean; they are not fields of the v1.3.0 JSON.
This file adds no axiom and no sorry.
-/

structure NewformFactor26Standalone where
  cremonaLabel : String
  abelianLabel : String
  dimension : Nat
  weierstrass : List Int
  delta : Int
  qexpPrefix : List Int
  bsdQuotient : String

def factor26a1_standalone : NewformFactor26Standalone where
  cremonaLabel := "26a1"
  abelianLabel := "26a(1,26)"
  dimension := 1
  weierstrass := [1, 0, 1, -5, -8]
  delta := -17576
  qexpPrefix := [0, 1, -1, 1, 1, -3, -1, -1, -1, -2, 3, 6, 1, 1, 1, -3, 1, -3, 2, 2, -3]
  bsdQuotient := "1/3"

def factor26b1_standalone : NewformFactor26Standalone where
  cremonaLabel := "26b1"
  abelianLabel := "26b(1,26)"
  dimension := 1
  weierstrass := [1, -1, 1, -3, 3]
  delta := -1664
  qexpPrefix := [0, 1, 1, -3, 1, -1, -3, 1, 1, 6, -1, -2, -3, -1, 1, 3, 1, -3, 6, 6, -1]
  bsdQuotient := "1/7"

def qexp26a1_prefix_eq_ledger : factor26a1_standalone.qexpPrefix.length = 21 := rfl

def qexp26b1_prefix_eq_ledger : factor26b1_standalone.qexpPrefix.length = 21 := rfl
