import data.real.basic -- we tell LEAN to take all basic definitions from the real numbers ℝ
noncomputable theory -- Don't worry about this. We tell lean that we will do abstract stuff.
open_locale classical -- We tell LEAN that we will use what is called "classical logic" (!)

/-!
### Overview

The list:

SYMBOL  BY TYPING...  MEANS               WHAT LOGICIANS CALL IT
=================================================================
→       \to, \r       if ... then         implication
∀       \forall, \all for all             universal quantifier
∃       \ex, \exists  there exists        existential quantifier
¬       \n, \not      not                 negation
∧       \and          and                 conjunction
↔       \iff, \lr     if and only if      bi-implication
∨       \or           or                  disjunction
false                 contradiction       falsity
true                  this is trivial!    truth

A goal in Lean is of the form

  1 goal
  x y : ℕ,
  h₁ : prime x,
  h₂ : ¬even x,
  h₃ : y > x
  ⊢ y ≥ 4

The stuff before the `⊢` is called the *context*, or *local context*. The facts
there are called *hypotheses* or *local hypotheses*.

The stuff after the `⊢` is also called the *goal*, or the *target*.

A common theme:

- Some tactics tell us how to *prove* a goal involving the connective.
  (Logician's terminology: "introduce" the connective.)

- Some tactics tell us how to *use* a hypothesis involving the connective.
  (Logician's terminology: "eliminate" the connective.)

Summary:

→       if ... then       `intro`, `intros`     `apply`, `have h₃ := h₁ h₂`
∀       for all           `intro`, `intros`     `apply`, `specialize`,
                                                  `have h₂ := h₁ t`
∃       there exists      `use`                 `cases`
¬       not               `intro`, `intros`     `apply`, `contradiction`
∧       and               `split`               `cases`, `h.1` / `h.2`,
                                                  `h.left` / `h.right`
↔       if and only if    `split`               `cases`, `h.1` / `h.2`,
                                                  `h.mp` / `h.mpr`, `rw`
∨       or                `left` / `right`      `cases`
false   contradiction                           `contradiction`, `ex_falso`
true    this is trivial!  `trivial`

Also, for proof by contradiction:

  Use the `by_contradiction` tactic.

-/

section
-- Use mul_comm and mul_assoc and the rw tactic here.
example (a b c : ℝ) : (a * b) * c = b * (a * c) :=
begin
  sorry
end

-- In the following two, you may also need to use "rw ←"

example (a b c : ℝ) : (c * b) * a = b * (a * c) :=
begin
  sorry
end

example (a b c : ℝ) : a * (b * c) = b * (a * c) :=
begin
  sorry
end

-- In the examples below, we have hypotheses in the local context that you can use as well

example (a b c d e f : ℝ) (h : a * b = c * d) (h' : e = f) :
  a * (b * e) = c * (d * f) :=
begin
  sorry
end

example (a b c d e f : ℝ) (h : b * c = e * f) :
  a * b * c * d = a * e * f * d :=
begin
  sorry
end

-- Note that there is also the theorem sub_self that you can use.

example (a b c d : ℝ) (hyp : c = b * a - d) (hyp' : d = a * b) : c = 0 :=
begin
  sorry
end

-- Here is another one. Now we will use mul_add, add_mul, add_assoc and two_mul.
example (a b c d : ℝ) : (a + b) * (a + b) = a * a + 2 * (a * b) + b * b :=
begin
  sorry  
end

-- Sometimes it is better to follow a chain of equalities in your proof. You can do it using calc:
example (a b : ℝ) : (a + b) * (a + b) = a * a + 2 * (a * b) + b * b :=
calc
  (a + b) * (a + b)
      = a * a + b * a + (a * b + b * b) :
          by rw [mul_add, add_mul, add_mul]
  ... = a * a + (b * a + a * b) + b * b :
          by rw [←add_assoc, add_assoc (a * a)]
  ... = a * a + 2 * (a * b) + b * b     :
          by rw [mul_comm b a, ←two_mul]

-- Try it!
example (a b c d : ℝ) : (a + b) * (c + d) = a * c + a * d + b * c + b * d := sorry


-- In this one, use pow_two, mul_sub, add_mul, add_sub, sub_sub, add_zero
example (a b : ℝ) : (a + b) * (a - b) = a^2 - b^2 :=
begin
  sorry
end

end --section

--section geometry
-- We now start with geometry, the topic of this BIYSC project.

constants Point Line : Type*
constant belongs : Point → Line → Prop
local notation A `∈` L := belongs A L
local notation A `∉` L := ¬ belongs A L

-- I1: there is a unique line passing through two distinct points.
axiom I1 (A B : Point) (h : A ≠ B) : ∃! (ℓ : Line) , A ∈ ℓ ∧ B ∈ ℓ

-- I2: any line contains at least two points.
axiom I2 (ℓ : Line) : ∃ A B : Point, A ≠ B ∧ A ∈ ℓ ∧ B ∈ ℓ

-- I3: there exists 3 non-collinear points.
axiom I3 : ∃ A B C : Point, (A ≠ B ∧ A ≠ C ∧ B ≠ C ∧ (∀ ℓ : Line, (A ∈ ℓ ∧ B ∈ ℓ) → (¬ (C ∈ ℓ) )))

-- We can make our own definitions
def collinear (A B C : Point) : Prop := ∃ (ℓ : Line), (A ∈ ℓ ∧ B ∈ ℓ ∧ C ∈ ℓ)

-- So let's prove that axiom I3 really says that there are 3 non-collinear points
-- We will need lots of new tactics:
-- * have
-- * use
-- * obtain / rcases
-- * unfold
-- * push_neg
-- * specialize
-- * intros
-- * exact
example : ∃ A B C : Point, ¬ collinear A B C :=
begin
  sorry
end

-- The following two lemmas are particular cases of axiom I1
section basic_lemmas

lemma I11 (A B : Point) (h: A ≠ B) : ∃ (ℓ : Line), A ∈ ℓ ∧ B ∈ ℓ :=
begin
  sorry
end

lemma I12 (A B : Point) (r s : Line) (h: A ≠ B) (hAr: A ∈ r) (hBr : B ∈ r) (hAs : A ∈ s) (hBs : B ∈ s) :
r = s :=
begin
  sorry
end

-- Use I3 to prove the following lemma
lemma exists_point_not_on_line (ℓ : Line): ∃ A : Point, A ∉ ℓ :=
begin
  sorry
end

end basic_lemmas