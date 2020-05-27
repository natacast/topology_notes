import data.real.basic
import data.real.irrational
import tactic



lemma lem₁ (m n : ℕ) : 2 * m^2 = n^2 → 2 ∣ n :=
begin
  intros eq₁,
  have : 2 ∣ n^2, by { use m^2, exact eq.symm eq₁},
  exact nat.prime.dvd_of_dvd_pow nat.prime_two ‹2 ∣ n^2 ›,
end




-- There are two sorry's in the proof and they both involve basic algebraic manipulations
-- Neither `ring` nor `simp` is simplifying them and I am not sure how to fix that.

theorem sqrt2_irrational' : 
¬( ∃ p q : ℕ,
      q ∣ p ∧
      q ≠ 0 ∧
      p.gcd q = 1 ∧
      2 = p^2 / q^2) :=
begin
by_contradiction,

  cases a with p, cases a_h with q, cases a_h_h with hqp, cases a_h_h_right with q_ne_zero, cases a_h_h_right_right with gcd_1 rational_2,

  have eq₁: 2 * q^2 = p^2,
    by sorry,

  have eq₂: 2 ∣ p,
    by exact lem₁ q p eq₁,

  let eq₂' := eq₂,

  unfold has_dvd.dvd at eq₂,

  cases eq₂ with p₁ eq₂,

  rw eq₂ at eq₁,

  have eq₃: q^2 = 2 * p₁^2,
    by { sorry },

  have eq₄: 2 * p₁^2 = q^2,
    by { exact eq.symm eq₃},

  have eq₅: 2 ∣ q,
    by exact lem₁ p₁ q eq₄,

  have eq₆: 2 ∣ 1,
    begin
    suffices : 2 ∣ p.gcd q,
    rw gcd_1 at this,
    assumption,
    exact nat.dvd_gcd eq₂' eq₅,
    end,

  rw nat.dvd_one at eq₆,

  injections,

end






-- Switching between reals and naturals (or integers) is extremely painful
-- might need to skip this

/-
theorem sqrt2_irrational : irrational (real.sqrt 2) :=
begin
  unfold irrational,
  by_contradiction,
  have sqrt2_rational': ∃ m n : ℤ, int.gcd m n = 1 ∧ real.sqrt 2 = m / n, by sorry,
  have sqrt2_rational: ∃ m n : ℕ, nat.gcd m n = 1 ∧ real.sqrt 2 = m / n, by sorry,
  cases sqrt2_rational with m,
  cases sqrt2_rational_h with n,
  cases sqrt2_rational_h_h with coprime sqrt2_rational,
  have : 2 * (n:real)^2 = (m:real)^2,
  begin
    calc
    2 * (n:real)^2 = (real.sqrt 2)^2 * n^2 :
    begin
      symmetry,
      suffices : 0 ≤ (2:real),
        rw real.sqr_sqrt ‹0 ≤ (2:real)›,
      unfold has_le.le,
      unfold real.le,
      left,
      unfold has_lt.lt,
      sorry,
    end
    ...     = (m / n)^2 * n^2 : by rw sqrt2_rational
    ...     = m^2 : by sorry,
  end,
  have : 2 * n^2 = m^2, by sorry, --cast_inj
  have : 2 ∣ m, by sorry,
  have : 2 ∣ n, by sorry,
  have not_coprime : 2 ∣ nat.gcd m n,
  begin
    exact nat.dvd_gcd ‹2 ∣ m› ‹2 ∣ n›,
  end,
  rw coprime at not_coprime,
  exact nat.prime.not_dvd_one (nat.prime_two) not_coprime,
end
-/
