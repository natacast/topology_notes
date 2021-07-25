.. _day1:

Filter definition and algebraic structure
************************

We will start defining filters and then the basic filter propositions will be proved by the common way and by Lean.
The final aim of this chapter is to define an algebraic structure with filters, defining two operations.

Filter definition
==================
Firstly, we will introduce the filter definition of a giving set.

``Here goes the latex definition``

The reader might have noticed we haven't included the empty axiom, normally used in the filter common definitions.
Assuming this axiom would make it impossible to define the neutral element in one of the operations we will use later.

Having the conceptual definition of filters, we can define this structure in Lean. The following code lines were published 
in the mathlib repository by Johannes Hölzl in Agoust of 2018.

.. code:: lean

  structure filter (X : Type) :=
  (sets                   : set (set X))
  (univ_sets              : set.univ ∈ sets)
  (sets_of_superset {x y} : x ∈ sets → x ⊆ y → y ∈ sets)
  (inter_sets {x y}       : x ∈ sets → y ∈ sets → x ∩ y ∈ sets)
