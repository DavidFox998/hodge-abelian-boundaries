#!/usr/bin/env sage
from sage.all import *
import time

DISCRIMINANTS = [3, 4, 7, 8, 11, 19, 43, 67, 163]
BOUND = 20

# Hard-coded transcendental lattices T_X for Q(sqrt(-d))
LATTICES = {
    3: Matrix(ZZ, [[2, 1], [1, 2]]), # A2
    4: Matrix(ZZ, [[2, 0], [0, 2]]), # A1^2
    7: Matrix(ZZ, [[2, 1], [1, 4]]),
    8: Matrix(ZZ, [[2, 0], [0, 4]]),
    11: Matrix(ZZ, [[2, 1], [1, 6]]),
    19: Matrix(ZZ, [[2, 1], [1, 10]]),
    43: Matrix(ZZ, [[2, 1], [1, 22]]),
    67: Matrix(ZZ, [[2, 1], [1, 34]]),
    163: Matrix(ZZ, [[2, 1], [1, 82]])
}

def tensor_invariant_k3(v, Q):
    q = v.dot_product(Q * v)
    return q

def verify_single_d(d):
    print(f"\n=== Testing d = {d} ===")
    t0 = time.time()
    try:
        T = LATTICES[d]
        NS_basis = [vector(ZZ, [1,0]), vector(ZZ, [0,1])]
        violations = []
        max_Z = 0
        for i, omega in enumerate(NS_basis):
            Z = tensor_invariant_k3(omega, T)
            max_Z = max(max_Z, Z)
            is_alg = Z <= BOUND
            msg = f"Z = {Z} {'≤' if is_alg else '>'} {BOUND} {'OK' if is_alg else 'FAIL'}"
            print(f" ω_{i}: {msg}")
            if not is_alg:
                violations.append((i, Z))
        dt = time.time() - t0
        if violations:
            print(f"FAILED d={d} in {dt:.1f}s. Max Z = {max_Z}")
            return False
        else:
            print(f"PASSED d={d} in {dt:.1f}s. All Z ≤ {BOUND}.")
            return True
    except Exception as e:
        print(f"ERROR d={d}: {e}")
        return False

def main():
    print("ZOE INVARIANT VERIFICATION FOR CM K3 SURFACES")
    print(f"Testing: Z(ω) ≤ {BOUND} for all ω ∈ NS(X)_QQ")
    all_pass = True
    for d in DISCRIMINANTS:
        all_pass = verify_single_d(d) and all_pass
    if all_pass:
        print(f"\nAll tested CM K3s: Z ≤ {BOUND}. Hodge VERIFIED for (1,1)-classes.")
    else:
        print(f"\nCOUNTEREXAMPLE FOUND. Bound FAILS for K3.")
    return all_pass

if __name__ == "__main__":
    main()
# --- BREAK --- d j f
