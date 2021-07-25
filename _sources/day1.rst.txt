.. _day1:

Filter definition and algebraic structure
************************

We will start defining filters and, then the elementary filter propositions will be proved by the usual way and by Lean.
This chapter aims to define an algebraic structure with filters using two operations.

Filter definition
==================
Firstly, we will introduce the filter definition of a giving set.

**Definition 1.1** (Filter). Let ``X`` be a set, a filter is a family of subsets of the power ser ``F ⊆ 𝓟(X)`` satisfying 
the next properties
  (i) The universal set is in the filter ``X ∈ F``.
  (ii) If ``E ∈ F``, then ``∀A ∈ 𝓟(X)`` such that ``E ⊆ A``, we have ``A ∈ F``.
  (iii) If ``E,A ∈ F``, then ``E ∩ A ∈ F``.
  

The reader might have noticed we haven't included the empty axiom, this axiom states that the empty set cannot be in any filter, commonly used in filter definitions and also required for topology filter convergence.
Assuming this axiom would make it impossible to define the neutral element in one of the operations we will use later.

Having the conceptual definition of filters, we can define this structure in Lean. The following code lines were published, 
in the mathlib repository, by Johannes Hölzl in Agoust of 2018.

.. code:: lean

  structure filter (X : Type) :=
  (sets                   : set (set X))
  (univ_sets              : set.univ ∈ sets)
  (sets_of_superset {x y} : x ∈ sets → x ⊆ y → y ∈ sets)
  (inter_sets {x y}       : x ∈ sets → y ∈ sets → x ∩ y ∈ sets)
