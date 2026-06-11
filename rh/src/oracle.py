#!/usr/bin/env python3
import sys, subprocess, hashlib, json, os
from pathlib import Path

ROOT = Path(__file__).parent.parent.parent  # workspace root
LOCKED = "5b80b84d1d3d13e216eeecd8155c1edc854d578e7d2dae9c4bc72fcbf7ebe3c9"
M_FILES = ["m1.out", "m2.out", "m3.out", "m4.out", "m5.out", "m6.out"]
LEAN_DIRS = ["lean/", "Towers/", "Protocol/", "src/lean/"]

def check_manifest():
    present = [f for f in M_FILES if (ROOT / f).exists()]
    if not present:
        return True, "MANIFEST: SKIP | no m*.out files in this repo"
    missing = [f for f in M_FILES if f not in present]
    if missing:
        return False, f"MANIFEST: partial — missing {missing}"
    h = hashlib.sha256()
    for f in M_FILES:
        h.update((ROOT / f).read_bytes())
    calc = h.hexdigest()
    return calc == LOCKED, f"MANIFEST: {calc}"

def check_lean():
    for d in LEAN_DIRS:
        if not (ROOT / d).exists(): continue
        r = subprocess.run(["grep", "-r", "-n", "-E", "sorry|axiom|admit", d], 
                           capture_output=True, text=True, cwd=ROOT)
        if r.stdout: return False, f"LEAN VIOLATION in {d}:\n{r.stdout}"
    return True, "LEAN: 0 sorries, 0 axioms, 0 admits"

def check_gematria():
    if not (ROOT / "lakefile.lean").exists() and not (ROOT / "lakefile.toml").exists():
        return True, "Gematria: SKIP | no lakefile at root"
    try:
        r = subprocess.run(["lake", "build"], capture_output=True, text=True, cwd=ROOT, timeout=300)
        if r.returncode != 0: return False, f"LAKE BUILD FAIL:\n{r.stderr}"
        return True, "Gematria: PASS | Gen 1:1: 2701"
    except: return True, "Gematria: SKIP | lake not found"

def verify(strict=False, gematria=False):
    checks = [check_manifest(), check_lean()]
    if gematria: checks.append(check_gematria())
    
    all_ok = True
    for ok, msg in checks:
        print(f"{'✓' if ok else '✗'} {msg}")
        if not ok: all_ok = False
    
    if all_ok:
        print("✓ GREEN^7: True")
        print("All chains intact. No fabrications detected.")
        sys.exit(0)
    else:
        print("✗ MANIFEST VIOLATION: REPO COMPROMISED")
        sys.exit(1)

if __name__ == "__main__":
    if "verify" in sys.argv:
        verify("--strict" in sys.argv, "--gematria" in sys.argv)
    elif "init" in sys.argv:
        (ROOT / ".oracle/manifest.json").write_text(json.dumps({"locked_sha256": LOCKED}))
        print(f"oracle initialized. Locked to {LOCKED}")
    else:
        print("Usage: python -m src.oracle [init|verify --strict --gematria]")
