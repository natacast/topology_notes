import tactic
import data.int.basic


example {p : ℤ → Prop} 
  (p_succ : ∀ n, p n → p (n + 1)) (p_pred : ∀ n, p n → p (n - 1)) :
(∀ n, p n) ↔ p 0 :=
begin
  have key1 : ∀ n, p n ↔ p (n+1),
  { intro, split; intro h,
    { apply p_succ, assumption },
    have := p_pred (n+1), 
    ring at this, apply this, assumption },
  split; intro h, { apply h },
  intro n, cases n, -- rintro ⟨n⟩ also works
  { induction n with d hd, {simpa},
    rw nat.succ_eq_add_one,
    simp only [int.coe_nat_succ, int.of_nat_eq_coe],
    rwa ← key1 },
  induction n with d hd, { rw key1, simpa },
  rw nat.succ_eq_add_one, 
  rw key1, simpa,
end

open_locale big_operators
open finset

-- by landing in ℤ, we avoid the perils of nat subtraction
def f : ℕ → ℕ
| 0 := 0
| (n + 1) := n + 1 + f n

example : f 1 = 1 := 
begin
  unfold f,
end

example (n : ℕ) : 2 * f n = n * (n + 1) :=
begin
  induction n with d hd,  
  -- base case
  { unfold f, simp },
  rw nat.succ_eq_add_one,
  unfold f, ring, 
  rw hd, ring,
end

variables {R : Type*} [comm_ring R]
example (n : ℕ) (a : R) : 
(1 - a) * ∑ k in range n, a^k = 1 - a ^n :=
begin
  rw mul_sum, apply sum_range_induction,
  { simp },
  intro, ring,
end

-- doing your induction "by hand"
example (n : ℕ) (a : R) : 
(1 - a) * ∑ k in range n, a^k = 1 - a ^n :=
begin
  induction n with d hd,
  { simp },
  rw [sum_range_succ, mul_add, hd, nat.succ_eq_add_one],
  ring_exp,
end