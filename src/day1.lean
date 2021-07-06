import tactic -- We want to use tactics to prove theorems
import data.real.basic -- we tell LEAN to take all basic definitions from the real numbers ℝ
noncomputable theory -- Don't worry about this. We tell lean that we will do abstract stuff.
open_locale classical -- We tell LEAN that we will use what is called "classical logic" (!)

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