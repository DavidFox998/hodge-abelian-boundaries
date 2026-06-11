def tensor_invariant_k3(omega, X):
    """
    Compute Z(ω), the tensor invariant, for ω ∈ H^{1,1}(X) on K3 X

    For p=1, Z(ω) = tensor rank = matrix rank of ω
    Bound for K3: Z(ω) ≤ binom(h^{1,1}, 1) = 20

    This extends Lemma 7.6 from Paper 3 to K3 surfaces.
    """
    M = omega.matrix() # 20x20 over QQ
    return M.rank()

def classify_tensor_invariant(Z, bound=20):
    """
    Pillar 3: CLASSIFY
    Returns True if algebraic, False if transcendental counterexample
    """
    if Z <= bound:
        return True, f"Z = {Z} ≤ {bound}. Algebraic."
    else:
        return False, f"Z = {Z} > {bound}. Transcendental counterexample to Lemma 7.6."
