.. index:: mathematical structures

.. _mathematical_structures:

*************************
 Mathematical Structures
*************************

The individual chapters in this part of the tutorial are relatively independent of one another.  You should be familiar with the chapter :ref:`sage_objects` before reading material here.  The section :ref:`list_comprehensions` is also useful.  Eventually, when you are ready for some real experimentation, you will want to read much of the chapter :ref:`programming_tools`.   Many sections in this part are incomplete, and we welcome contributions and additions!



.. _integers_modular_arithmetic:

Integers and Modular Arithmetic
===============================


.. _integers_modulo_n:

Integers Modulo :math:`n`
-------------------------

    You should be familiar with :ref:`universes_and_coercion` and :ref:`variables`

.. index:: modular arithmetic, rings, rings; integers modulo n

In this section we cover how to construct :math:`\mathbb{Z}_{n}`, the ring of integers modulo
:math:`n`,  and do some basic computations.

.. index:: Integers

To construct :math:`\mathbb{Z}_{n}` you use the :class:`.Integers` command. ::

  sage: Integers(7)
  Ring of integers modulo 7
  sage: Integers(100)
  Ring of integers modulo 100

We could do computations modulo an integer by repeatedly using the
``%`` operator in all of our expressions, but by constructing the ring
explicitly we have access to a more natural method for doing
arithmetic. ::

  sage: R=Integers(13)
  sage: a=R(6)
  sage: b=R(5)
  sage: a + b
  11
  sage: a*b
  4

.. index:: rings; order, order,  order; additive, order; multiplicative, additive_order, multiplicative_order, rings; units, is_unit

And by explicitly coercing our numbers into the ring :math:`\mathbb{Z}_{n}` we can compute some of the mathematical properties of the elements. Like their order, both multiplicative and additive, and whether or not the element is a unit. ::

  sage: a.additive_order()
  13
  sage: a.multiplicative_order()
  12
  sage: a.is_unit()
  True

.. index:: inverse

The additive inverse of :math:`a` is computed using ``-a`` and, if :math:`a` is a unit, the multiplicative inverse is computed using ``a^(-1)`` or ``1/a``. ::

  sage: (-a)
  7
  sage: (a^(-1))
  11

These inverses can be checked easily. ::

  sage: a + (-a)
  0
  sage: a*(a^(-1))
  1

Recall that division in :math:`\mathbb{Z}_{n}` is really multiplication by an inverse. ::

  sage: R=Integers(24)
  sage: R(4)/R(5)
  20
  sage: R(4)*R(5)^-1
  20
  sage: R(4/5)
  20

Not all elements have an inverse, of course. If we try an invalid
division, SageMath will complain ::

  sage: R(5/4)
  ...
  ZeroDivisionError: Inverse does not exist.

We have to be a little bit careful when we are doing this since we are asking SageMath to coerce a rational number into the :math:`\mathbb{Z}_{24}` This may cause some unexpected consequences since some reduction is done on rational numbers before the coercion. For an example, consider the following: ::

  sage: R(20).is_unit()
  False
  sage: R(16/20)
  20

In  :math:`\mathbb{Z}_{24}`,  :math:`20` is not a unit, yet at first glance it would seem we divided by it. However, note the order of operations. First sage reduces :math:`16/20` to  :math:`4/5`, and then coerces :math:`4/5` into :math:`\mathbb{Z}_{24}`. Since :math:`5` is a unit in :math:`\mathbb{Z}_{24}`, everything works out ok.

.. index:: rings; size, order, is_ring, is_integral_domain, is_field

We can also compute some properties of the ring itself. ::

  sage: R
  Ring of integers modulo 24
  sage: R.order()
  24
  sage: R.is_ring()
  True
  sage: R.is_integral_domain()
  False
  sage: R.is_field()
  False

.. index:: list, rings; list

Since this  ring is finite then we can have SageMath list all of it's elements. ::

  sage: R = Integers(13)
  sage: R.list()
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

.. index:: unit group, rings; unit group, unit_gens

``R`` in this example is a field, since :math:`13` is a prime number.  If our ring is not a field then the *units*  in :math:`\mathbb{Z}_{n}`
form a group under multiplication. SageMath can compute a list of generators of the *group of units* using it's :meth:`unit_gens` method. ::

  sage: R = Integers(12)
  sage: R.uni
  R.unit_gens            R.unit_group_order
  R.unit_group_exponent  R.unit_ideal
  sage: R.unit_gens()
  [7, 5]

.. index:: unit_group_order

We can also compute the order of this subgroup. ::

  sage: R.unit_group_order()
  4

Unfortunately, SageMath doesn't seem to have a function which directly returns the units in :math:`\mathbb{Z}_{n}` as a group.  We can list the elements in a couple of different ways using the information above. ::

  sage: (a,b) = R.unit_gens()
  sage: a
  7
  sage: b
  5
  sage: [ (a^i)*(b^j) for i in range(2) for j in range(2) ]
  [1, 5, 7, 11]

.. index:: is_unit

We can also compute the list of units  by using a list comprehension. ::

  sage: [ x for x in R if x.is_unit()]
  [1, 5, 7, 11]


**Exercises:**

  #. Construct the ring of integers modulo :math:`16` and answer the following:

     a) Compute the multiplicative orders of :math:`2,4,5,6,13` and :math:`15`?
     b) Which of the elements listed above is a unit?
     c) What are the generators for the group of units?
     d) Compute a list of all of the elements in the group of units.

  #. Do all of the steps above again, but with the ring of integers modulo :math:`17`.

  #. Use an exhaustive search method to write a function which determines if a is a unit modulo n.

  #. For :math:`n = 13, 15` and :math:`21` determine which of :math:`3,4` and :math:`5` are units in :math:`\mathbb{Z}_{n}`. When you find a unit, determine its inverse and compare this to the output of :math:`xgcd(a,n)`. Try to explain this relationship.

  #. Use SageMath to determine whether the following Rings are fields. For each  example, describe the unit group using generators and relations.

     a) :math:`\mathbb{Z}_{1091}`
     b) :math:`\mathbb{Z}_{1047}`
     c) :math:`\mathbb{Z}_{1037}`
     d) :math:`\mathbb{Z}_{1087}`



.. _linear_congruences:

.. index:: linear congruences

Solving Congruences
--------------------------------

    You should be familiar with :ref:`integers_modulo_n` and :ref:`list_comprehensions`

A linear congruence is an equation of the form :math:`ax=b` in :math:`\mathbb{Z}_{n}`. One way to see if there is a solution to such a problem is an exhaustive search. For example, to determine if there exists a solution to :math:`9x = 6` we can do the following: ::

  sage: R=Integers(21)
  sage: a=R(9)
  sage: 6 in [ a*x for x in R ]
  True

Notice that the above tells us only that there exists at least one solution to the equation :math:`9x= 6` in :math:`\mathbb{Z}_{21}`. We can construct the list of these solutions by using the following list comprehension. ::

  sage: [ x for x in R if R(9)*x == R(6)]
  [3, 10, 17]

We can  determine when a solution does not exist in a similar fashion. ::

  sage: [ x for x in R if R(9)*x == R(2) ]
  []

.. index:: solve_mod

We can also use the :func:`solve_mod` function to compute the same results. ::

  sage: solve_mod( 9*x == 6, 21)
  [(3,), (10,), (17,)]
  sage: solve_mod( 9*x == 2, 21)
  []

:func:`solve_mod` can handle linear congruences of more than one variable. ::

  sage: solve_mod( 9*x + 7*y == 2, 21)
  [(15, 14), (15, 8), (15, 2), (15, 17), (15, 11), (15, 5), (15, 20), (1, 14), (1, 8), (1, 2), (1, 17), (1, 11), (1, 5), (1, 20), (8, 14), (8, 8), (8, 2), (8, 17), (8, 11), (8, 5), (8, 20)]

The solutions are in the form :math:`\left(x,y\right)`, where the
variables are listed in the order in which they appear in the equations.

:func:`solve_mod` can  solve systems of linear congruences. ::

  sage: solve_mod( [9*x + 2*y == 2, 3*x + 2*y == 11   ], 21)
  [(9, 13), (16, 13), (2, 13)]

As with  the :func:`solve` command, computations can be slow when working with systems that have a lot of variables and/or
equations. For these systems the linear algebra capabilities are
recommended.

We can also compute the solutions for non-linear congruences
using :func:`solve_mod`. ::

  sage: solve_mod(x^2 + y^2 == 1, 7)
  [(0, 1), (0, 6), (1, 0), (2, 2), (2, 5), (5, 2), (5, 5), (6, 0)]
  sage: solve_mod([x^2 + y^2 == 1, x^2 - y == 2], 7)
  [(2, 2), (5, 2)]

.. index:: Chinese Remainder Theorem, crt

Finally, SageMath can compute the simultaneous solution of linear
congruences with different moduli under certain circumstances. This
is done using the `Chinese Remainder Theorem <https://en.wikipedia.org/wiki/Chinese_remainder_theorem>`_, and is implemented in
the :func:`.crt` command. For example, the following computes the
smallest nonnegative integer, :math:`x` that is congruent to :math:`3 \bmod 8`, :math:`4 \bmod 9`,
and :math:`5 \bmod 25`.   ::

  sage: crt([3,4,5],[8,9,25])
  355

We can check the validity of this solution using the :func:`.mod` command. ::

  sage: mod(355,8)
  3
  sage: mod(355,9)
  4
  sage: mod(355,25)
  5

The set of all integer solutions is those
integers congruent to :math:`355`  modulo :math:`8*9*25=1800`.

**Exercises:**

  #. Find all solutions to the following congruences over :math:`\mathbb{Z}_{42}`.

     a) :math:`41x = 2`
     b) :math:`5x = 13`
     c) :math:`6x = 0`
     d) :math:`6x = 12`
     e) :math:`6x = 18`
     f) :math:`37x = 21`

  #. Above you computed the solution sets for the congruences  :math:`6x =0`, :math:`6x = 12` and :math:`6x = 18`. What are the    similarities?  What are the differences? Can you use these results  to say something in general about the structure of the set    :math:`{\left\{ 6x \mid x \in \mathbb{Z}_{42} \right\} }` ?

  #. Use the :func:`solve_mod` command find all of the solutions to the following congruences modulo :math:`36`.

     a) :math:`3x = 21`
     b) :math:`7x = 13`
     c) :math:`23x = 32`
     d) :math:`8x = 14`



.. _euclidean_algorithm:

Mini-Topic: Euclidean Algorithm
-------------------------------

    You should be familiar with :ref:`division_and_factoring`, :ref:`variables`, :ref:`external_files_and_sessions`, and :ref:`while_loops`

..  index:: euclidean algorithm, integers, gcd

Recall that for :math:`a,b \in \mathbb{Z}` with :math:`b \neq 0`, there always exists unique :math:`q,r \in \mathbb{Z}` such that :math:`a=bq+r` with :math:`0 \leq r< b`. With that in mind, we will use SageMath to calculate the *gcd* of two integers using the *Euclidean Algorithm*. The following code is an implementation of the Euclidean Algorithm in SageMath.

.. code-block:: python

	# Begin euclid.sage
	r=a%b
	print (a,b,r)
	while r != 0:
	        a=b; b=r
	        r=a%b
	        print (a,b,r)
	# End euclid.sage

If you create a file ``euclid.sage`` containing the text above, then the output after loading the file is: ::

  sage: a=15; b=4
  sage: load euclid.sage
  (15, 4, 3) (4, 3, 1) (3, 1, 0)
  sage: a=15; b=5
  sage: load euclid.sage
  (15, 5, 0)

In the first case, we see that the ``gcd`` was :math:`1`, while in the second the ``gcd`` was :math:`5`.

**Exercises:**

    #. Revise the loop in the ``euclid.sage`` so that only the gcd and the total number of divisions (i.e. the number of steps through the algorithm) are printed. Compare the speed of this version of the algorithm with the built-in SageMath function :func:`.gcd` by using both functions on large integers.

    #. Write your own *Extended Euclidean Algorithm* by revising the loop in ``euclid.sage``.


.. _groups:

Groups
======

.. index:: groups


There are three major types of groups implemented in sage,
:func:`PermutationGroup`, :func:`MatrixGroup` and :func:`AbelianGroup`.
We will work with permutation groups first and cover most of the methods that
are applied to them.  Many of these methods are applicable to
arbitrary groups, so the other sections will  be somewhat briefer and will
focus on methods particular to those structures.

.. seealso::
        `Group Theory and SageMath: A Primer
        <http://buzzard.ups.edu/sage/sage-group-theory-primer.pdf>`_
        by Rob Beezer


.. _symmetric_groups:

Symmetric  Groups
------------------

.. index:: SymmetricGroup

The Symmetric Group :math:`S_n` is the group of all permutations on :math:`n` elements.  First we will construct the symmetric group on :math:`\{ 1, 2, 3, 4 ,5 \}` which is done by using the :class:`.SymmetricGroup` command.  ::

        sage: S5 = SymmetricGroup(5)
        S5 Symmetric group of order 5! as a permutation group

Once the group has been constructed we can check the number of elements, which is :math:`5!`, and  list them all. ::

       sage: S5.cardinality()
        120
       sage: S5.list()
    	[(), (4,5), (3,4), (3,4,5), (3,5,4), (3,5), (2,3), (2,3)(4,5), (2,3,4), (2,3,4,5), (2,3,5,4), (2,3,5), (2,4,3), (2,4,5,3), (2,4), (2,4,5), (2,4)(3,5), (2,4,3,5), (2,5,4,3), (2,5,3), (2,5,4), (2,5), (2,5,3,4), (2,5)(3,4), (1,2), (1,2)(4,5), (1,2)(3,4), (1,2)(3,4,5), (1,2)(3,5,4), (1,2)(3,5), (1,2,3), (1,2,3)(4,5), (1,2,3,4), (1,2,3,4,5), (1,2,3,5,4), (1,2,3,5), (1,2,4,3), (1,2,4,5,3), (1,2,4), (1,2,4,5), (1,2,4)(3,5), (1,2,4,3,5), (1,2,5,4,3), (1,2,5,3), (1,2,5,4), (1,2,5), (1,2,5,3,4), (1,2,5)(3,4), (1,3,2), (1,3,2)(4,5), (1,3,4,2), (1,3,4,5,2), (1,3,5,4,2), (1,3,5,2), (1,3), (1,3)(4,5), (1,3,4), (1,3,4,5), (1,3,5,4), (1,3,5), (1,3)(2,4), (1,3)(2,4,5), (1,3,2,4), (1,3,2,4,5), (1,3,5,2,4), (1,3,5)(2,4), (1,3)(2,5,4), (1,3)(2,5), (1,3,2,5,4), (1,3,2,5), (1,3,4)(2,5), (1,3,4,2,5), (1,4,3,2), (1,4,5,3,2), (1,4,2), (1,4,5,2), (1,4,2)(3,5), (1,4,3,5,2), (1,4,3), (1,4,5,3), (1,4), (1,4,5), (1,4)(3,5), (1,4,3,5), (1,4,2,3), (1,4,5,2,3), (1,4)(2,3), (1,4,5)(2,3), (1,4)(2,3,5), (1,4,2,3,5), (1,4,2,5,3), (1,4,3)(2,5), (1,4)(2,5,3), (1,4,3,2,5), (1,4)(2,5), (1,4,2,5), (1,5,4,3,2), (1,5,3,2), (1,5,4,2), (1,5,2), (1,5,3,4,2), (1,5,2)(3,4), (1,5,4,3), (1,5,3), (1,5,4), (1,5), (1,5,3,4), (1,5)(3,4), (1,5,4,2,3), (1,5,2,3), (1,5,4)(2,3), (1,5)(2,3), (1,5,2,3,4), (1,5)(2,3,4), (1,5,3)(2,4), (1,5,2,4,3), (1,5,3,2,4), (1,5)(2,4,3), (1,5,2,4), (1,5)(2,4)]

As you can see from the list, in SageMath a permutation is written in *cycle notation*.  Note that the empty parenthesis `()` is used to  represent the identity permutation.  We create the identity permutation and  a randomly chosen element as follows. ::

        sage: id = S5.identity()
        ()
	sage: S5.random_element()
	(1,2)(3,4)
 	sage: r=  S5.random_element(), r
	(1,3,4)(2,5)

As you can see, subsequent calls for a random element give a  new element each time.  We can also express the element :math:`r` as a
function by listing the images of :math:`1,2,3,4,5` in order. ::

      sage: r.list()
      [3,5,4,1,2]

We can construct a specific element in :math:`S_5` by coercing a permutation, written in *cycle notation*, into :math:`S5`. We must
enclose the  product of cycles in quotations for SageMath to parse the input correctly. ::

             sage:  r = S5('(1,3)(2,4)'); r
	     (1,3)(2,4)
             sage:  s = S5('(1,4,3,2)'); s
             (1,4,3,2)

We may also construct an element :math:`t` using the list of images that it has as a function. ::

	     sage:  t = S5([1,5,4,3,2]); t
	     (2,5)(3,4)

The product of cycles is taken from *left-to-right* and is, of
course, not commutative. ::

        sage: s*t
	(1,4,2,3)
	sage: t*s
	(1,2,4,3)
	sage: id*s

.. index:: groups; order, order

Let's compute the order of an element by using the object's :meth:`order` method and check this directly.  ::

        sage: r.order()
	2
	sage: r*r
	()
	sage: s.order()
	4
	sage: s*s
	(1,3)(2,4)
	sage: s*s*s*s
	()

The *exponent* of a group is the least common multiple of the orders of the elements. ::

        sage: S5.exponent()
          60


.. index:: groups; alternating, AlternatingGroup, sign

The :meth:`sign` method  is used to compute the sign of a permutation,
indicating whether it can be written as the product of an even or an odd number
of permutations. ::

        sage: S5('(2,3,4)').sign()
	1
	sage: S5('(4,5)').sign()
	-1

.. index:: groups; subgroup, subgroups,  is_subgroup


Each symmetric group :math:`S_n` is a subgroup of :math:`S_{n+1}`. ::

        sage: S4 = SymmetricGroup(4)
        sage: S4.is_subgroup(S5)
        True

You can construct the subgroup generated by a list of elements by
using the :meth:`subgroup` method. ::

        sage: H = S5.subgroup([r,s])
	sage: H
	Subgroup of SymmetricGroup(5) generated by [(1,3)(2,4), (1,4,3,2)]
	sage: H.list()
	[(), (1,2,3,4), (1,3)(2,4), (1,4,3,2)]

.. index:: is_abelian, is_cyclic, gens, gens_small, groups; generators

We can test to see if the subgroup that we have just created has
certain properties by using the appropriate methods.
typing :meth:`H.is` <tab> will give a list of several properties to test. ::

        sage: H.is_abelian()
	True
	sage: H.is_cyclic()
	True

The elements originally used to  generate a subgroup are obtained with the :meth:`gens` method.
SageMath can't guarantee a minimal generating set, but :meth:`gens_small`
makes an attempt. ::

	sage: H.gens()
	[(1,3)(2,4), (1,4,3,2)]
	sage: H.gens_small()
	[(1,4,3,2)]

.. index:: cayley_table, groups; Cayley table

A useful tool for examining the structure of a group is the
multiplication table, often called the *Cayley Table*.
Invoke the group's :meth:`cayley_table()` method
(also called :meth:`multiplication_table()`). The default uses
letters to represent the group elements (in the order they appear
using :meth:`list`).  ::

    sage: S3 = SymmetricGroup(3)
    sage: S3.cayley_table()
    *  a b c d e f
    +-----------
    a| a b c d e f
    b| b a d c f e
    c| c e a f b d
    d| d f b e a c
    e| e c f a d b
    f| f d e b c a
    sage: S3.list()
    [(), (2,3), (1,2), (1,2,3), (1,3,2), (1,3)]

We can also use the elements themselves, or
give them names.  Here we assign name based on the symmetries of a
triangle: :meth:`u_i` for reflections through the axis containing
vertex :meth:`i` and :meth:`r^1, r^2` for the rotations. ::

 sage: S3.cayley_table(names='elements')
 *       |      ()   (2,3)   (1,2) (1,2,3) (1,3,2)   (1,3)
 -------------------------------------------------
 ()      |      ()   (2,3)   (1,2) (1,2,3) (1,3,2)   (1,3)
 (2,3)   |   (2,3)      () (1,2,3)   (1,2)   (1,3) (1,3,2)
 (1,2)   |   (1,2) (1,3,2)      ()   (1,3)   (2,3) (1,2,3)
 (1,2,3) | (1,2,3)   (1,3)   (2,3) (1,3,2)      ()   (1,2)
 (1,3,2) | (1,3,2)   (1,2)   (1,3)      () (1,2,3)   (2,3)
 (1,3)   |   (1,3) (1,2,3) (1,3,2)   (2,3)   (1,2)      ()


 sage: S3.cayley_table(names=['id','u1','u3','r1','r2','u2'])
 *  id u1 u3 r1 r2 u2
 +------------------
 id| id u1 u3 r1 r2 u2
 u1| u1 id r1 u3 u2 r2
 u3| u3 r2 id u2 u1 r1
 r1| r1 u2 u1 r2 id u3
 r2| r2 u3 u2 id r1 u1
 u2| u2 r1 r2 u1 u3 id

.. _permutation_groups:

General Permutation Groups
++++++++++++++++++++++++++

.. index:: PermutationGroup, groups; permutation

A permutation group is a subgroup of some symmetric group.
We can construct a permutation group directly, without constructing
the whole symmetric group, by giving a list of permutations to the :class:`.PermutationGroup` command.  ::

  sage: r = '(1,3)(2,4)(5)'
  sage: s = '(1,3,2)'
  sage: K = PermutationGroup([r,s])
  sage: K
  Permutation Group with generators [(1,3,2), (1,3)(2,4)]
  sage: K.order()
  12


Several important permutation groups can also be constructed directly.
Here are the simplest. ::

     sage: K= KleinFourGroup(); K
     The Klein 4 group of order 4, as a permutation group
     sage: K.list()
     [(), (3,4), (1,2), (1,2)(3,4)]
     sage: Q= QuaternionGroup(); Q.list()
     [(), (1,2,3,4)(5,6,7,8), (1,3)(2,4)(5,7)(6,8),
     (1,4,3,2)(5,8,7,6), (1,5,3,7)(2,8,4,6), (1,6,3,8)(2,5,4,7),
     (1,7,3,5)(2,6,4,8), (1,8,3,6)(2,7,4,5)]
     sage: [x.order() for x in Q]
     [1, 4, 2, 4, 4, 4, 4, 4]

.. index:: CyclicPermutationGroup, groups;  cyclic; DihedralGroup, groups; dihedral, AlternatingGroup, DiCyclicGroup

There are  several families  of permutation groups. The
:class:`CyclicPermutationGroup` in :math:`S_n` is generated by the cycle :math:`(1,2,\dots,n)`. The :class:`DihedralGroup`
is :math:`S_n` is the symmetries of a regular :math:`n` -gon with the
vertices enumerated clockwise from 1 to :math:`n`.  It is generated by
the rotation :math:`(1,2,\dots,n)` and a reflection.  Use the
:meth:`gens` to see which reflection is used.
The collection of all even permutations---permutations with positive
sign---is a subgroup of :math:`S_5`  obtained by the command :class:`AlternatingGroup`. ::

      sage: C = CyclicPermutationGroup(4); C
      Cyclic group of order 4 as a permutation group
      sage: C.list()
      [(), (1,2,3,4), (1,3)(2,4), (1,4,3,2)]
      sage: D = DihedralGroup(4); D
      Dihedral group of order 8 as a permutation group
      sage: D.list()
      [(), (2,4), (1,2)(3,4), (1,2,3,4), (1,3), (1,3)(2,4), (1,4,3,2),
      (1,4)(2,3)]
      sage: D.gens()
      [(1,2,3,4), (1,4)(2,3)]
      sage: A = AlternatingGroup(4); A
      Alternating group of order 4!/2 as a permutation group
      sage: A.cardinality()
      12

Another builtin group is  the :class:`DiCyclicGroup`  (see
`the Group Properties article <http://groupprops.subwiki.org/wiki/Dicyclic_group>`_).
Let's  check that the :math:`A_4` is not  isomorphic to the dicyclic
group with the same number of elements.  ::

      sage: B = DiCyclicGroup(3); B
      Diyclic group of order 12 as a permutation group
      sage: B.list()
      [(), (5,6,7), (5,7,6), (1,2)(3,4), (1,2)(3,4)(5,6,7), (1,2)(3,4)(5,7,6), (1,3,2,4)(6,7), (1,3,2,4)(5,6), (1,3,2,4)(5,7), (1,4,2,3)(6,7), (1,4,2,3)(5,6), (1,4,2,3)(5,7)]
      sage: A.is_isomorphic(B)
      False

With any permutation group we may compute its cardinality, list its elements, compute the order of elements, etc.
By using python's *list comprehensions* (see :ref:`lists`) we can
create a list of elements with certain properties. In this case we can
construct the list of all elements or order 2. ::



       sage: S5 = SymmetricGroup(5)
       sage: T = [s for s in S5  if s.order() == 2 ];  T
	[(4,5), (3,4), (3,5), (2,3), (2,3)(4,5), (2,4), (2,4)(3,5), (2,5), (2,5)(3,4), (1,2), (1,2)(4,5), (1,2)(3,4), (1,2)(3,5), (1,3), (1,3)(4,5), (1,3)(2,4), (1,3)(2,5), (1,4), (1,4)(3,5), (1,4)(2,3), (1,4)(2,5), (1,5), (1,5)(3,4), (1,5)(2,3), (1,5)(2,4)]

.. index:: groups; cyclic, groups; Klein 4,  CyclicPermutationGroup


Next we will construct  a permutation group  :math:`H` and list
it's members. This group :math:`H` has different elements from :class:`DihedralGroup(5)`,
but  is isomorphic to it.  ::

        sage: H= PermutationGroup(['(1,5),(3,4)', '(1,2,5,4,3)']); H
	Subgroup of SymmetricGroup(5) generated by [(1,2,5,4,3), (1,5)(3,4)]
	sage: H.list()
	[(), (2,3)(4,5), (1,2)(3,5), (1,2,5,4,3), (1,3,4,5,2), (1,3)(2,4), (1,4,2,3,5), (1,4)(2,5), (1,5)(3,4), (1,5,3,2,4)]
	sage: H.order()
	10
        sage: D = DihedralGroup(5)
	sage: D
	Dihedral group of order 10 as a permutation group
	sage: D.list()
     	[(), (2,5)(3,4), (1,2)(3,5), (1,2,3,4,5), (1,3)(4,5), (1,3,5,2,4), (1,4)(2,3), (1,4,2,5,3), (1,5,4,3,2), (1,5)(2,4)]
	sage: H == D
        False
	sage: H.is_isomorphic(D)
	True

.. index:: subgroup, center

As with the symmetric group, we can pass a list of
group elements to the method :meth:`subgroup` to create a subgroup of
any permutation group.

The list of all subgroups of a permutation group is obtained by the
:meth:`subgroups` method.  It returns a list whose 0th element is the
trivial subgroup.  ::

        sage: D = DihedralGroup(4)
        sage: L = D.subgroups(); L
 	[Permutation Group with generators [()], Permutation Group with generators [(1,3)(2,4)], Permutation Group with generators [(2,4)], Permutation Group with generators [(1,3)], Permutation Group with generators [(1,2)(3,4)], Permutation Group with generators [(1,4)(2,3)], Permutation Group with generators [(2,4), (1,3)(2,4)], Permutation Group with generators [(1,2,3,4), (1,3)(2,4)], Permutation Group with generators [(1,2)(3,4), (1,3)(2,4)], Permutation Group with generators [(2,4), (1,2,3,4), (1,3)(2,4)]]

The join of two subgroups :math:`C` and :math:`K`, is the group
generated by the union of the two subgroups. We get the union of :math:`C` and :math:`K` by "adding" the
respective lists.
In the example below, we see that the cyclic permutation group
generated by :math:`(1,2,3,4,5)` and the Klein four group generate the
whole symmetric group :math:`S_5`. Notice that the Klein four group is
a subgroup of :math:`S_4`, which itself is a subgroup of :math:`S_5`. ::

    sage: K = KleinFourGroup(); K.list()
    [(), (3,4), (1,2), (1,2)(3,4)]
    sage: C = CyclicPermutationGroup(5)
    sage: CjK = PermutationGroup(C.list()+K.list() )
    Permutation Group with generators [(), (3,4), (1,2), (1,2)(3,4), (1,2,3,4,5), (1,3,5,2,4), (1,4,2,5,3), (1,5,4,3,2)]
    sage: CjK.gens_small(); CjK.cardinality()
    [(1,2)(3,5,4), (1,4,5,3)]
    120
    sage: CjK == SymmetricGroup(5)
    True


The centralizer of an element :math:`a` (the
subgroup of elements that commute with :math:`a`) and the center of a
group are constructed in the way you'd expect.   ::

	sage: D.center()
	Subgroup of (Dihedral group of order 8 as a permutation group) generated by [(1,3)(2,4)]
	sage: D.centralizer(D('(1,3)(2,4)'))
	Subgroup of (Dihedral group of order 8 as a permutation group) generated by [(1,2,3,4), (1,4)(2,3)]

.. index:: normal; coset; conjugation; quotient; homomorphism

Quotients of Permutation Groups
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

In this section we explore normal subgroups and the quotient of a
group by a normal subgroup.  First we consider cosets and conjugation.

The alternating group :math:`A_4` has a subgroup isomorphic to the
Klein four group that is normal. ::

    sage: A4 = AlternatingGroup(4)
    sage: g1 = A4('(1,4)(3,2)') ; g2 = A4('(2,4)(1,3)')
    sage: H = A4.subgroup([g1,g2]);
    sage: H.is_normal(A4); H.is_isomorphic(KleinFourGroup())
    True
    True

Let's compare the right and left cosets of :math:`H` in :math:`A_4`. ::

    sage: Hr = A4.cosets(H, side = 'right')
    sage: Hl = A4.cosets(H, side = 'left')
    sage: Hr; Hl
    [[(), (1,2)(3,4), (1,3)(2,4), (1,4)(2,3)], [(2,3,4), (1,3,2), (1,4,3), (1,2,4)], [(2,4,3), (1,4,2), (1,2,3), (1,3,4)]]
    [[(), (1,2)(3,4), (1,3)(2,4), (1,4)(2,3)], [(2,3,4), (1,2,4), (1,3,2), (1,4,3)], [(2,4,3), (1,2,3), (1,3,4), (1,4,2)]]
    sage: Hr == Hl
    False

We can see they are equal, but sage is comparing each coset as lists, and
notes that the elements of the last two  cosets are not listed in the same order.
To rectify this, use :meth:`sorted` to remind sage to order each coset.  We are fortunate with this example
that the cosets themselves are listed in the same order.  Otherwise we would have to apply :meth:`sorted()` to the two lists of cosets.  ::

    sage: Hr_sorted = [sorted(S) for S in Hr]
    sage: Hl_sorted = [sorted(S) for S in Hl]
    sage: Hr_sorted == Hl_sorted
    True

The conjugate by :math:`a`  of an element :math:`g` is the element :math:`a^{-1}ga`.
The set of all conjugates of :math:`g` as  :math:`a` varies is the conjugacy class of :math:`g`.
Below, we create a 3-cycle and compute its conjugacy class  in :math:`S_4` and then in :math:`A_4`.  This shows that two elements may be conjugate in :math:`S_4` but not in :math:`A_4`. ::

    sage: S4 = SymmetricGroup(4)
    sage: A4 = AlternatingGroup(4)
    sage: g = S4('(1,3,4)')
    sage: Set([a^(-1)*g*a for a in A4])
    {(1,3,4), (1,4,2), (1,2,3), (2,4,3)}
    sage: Set([a^(-1)*g*a for a in S4])
    {(1,2,3), (1,3,4), (2,3,4), (2,4,3), (1,4,3), (1,2,4), (1,3,2), (1,4,2)}

The method :meth:`conjugacy_class_representatives` chooses one element from each conjugacy class.
Notice that there are two classes for 3-cycles in :math:`A_4`, but only one in :math:`S_4`. ::

   sage: S4.conjugacy_classes_representatives()
   [(), (1,2), (1,2)(3,4), (1,2,3), (1,2,3,4)]
   sage: A4.conjugacy_classes_representatives()
   [(), (1,2)(3,4), (1,2,3), (1,2,4)]

The conjugate by :math:`a` of a subgroup :math:`H` is the group :math:`a^{-1}Ha`
(recall that multiplication is left-to right).  The group encompassing
:math:`a` and :math:`H` need not be specified; sage just considers
them inside the symmetric  group containing all the integers that
appear. ::

     sage: H = CyclicPermutationGroup(4)
     sage: K = H.conjugate(PermutationGroupElement('(3,5)'));  K
     Permutation Group with generators [(1,2,5,4)]

The normalizer of :math:`H` in :math:`S_4` is the subgroup of elements
of :math:`a \in S_4` such that :math:`a^{-1}Ha = H`. ::

     sage: S4.normalizer(H)
     Permutation Group with generators [(2,4), (1,2,3,4), (1,3)(2,4)]
     sage: H1 = H.conjugate(PermutationGroupElement('(2,4)'));  H1
     Permutation Group with generators [(1,4,3,2)]
     sage: H1 ==H
     True

SageMath can compute all normal subgroups of a group :math:`G`.  Let's
verify that :math:`S_4` has 2 non-trivial normal subgroups, the
alternating group, and a group isomorphic to the Klein four group (but
not equal to sage's standard Klein four group).  ::

   sage: S4 = SymmetricGroup(4)
   sage: S4norms = S4.normal_subgroups(); S4norms
   [Permutation Group with generators [()], Permutation Group with generators [(1,3)(2,4), (1,4)(2,3)], Permutation Group with generators [(2,4,3), (1,3)(2,4), (1,4)(2,3)], Permutation Group with generators [(1,2), (1,2,3,4)]]
   sage: K = S4norms[1];  K==KleiFourGroup()
   False
   sage: K.is_isomorphic(KleinFourGroup())
   True
   sage: A = S4norms[2]; A == AlternatingGroup(4)
   True

We may now compute the quotient of :math:`G` by the normal subgroups :math:`K` and :math:`A` in the previous example.  As expected :math:`G/A`  is isomorphic to :math:`S_2`. Since :math:`G` has 24 elements and :math:`K` has 4 elements, the quotient has 6 elements.  We can check that it is isomorphic to :math:`S_3`.  ::

   sage: G.quotient(A)
   Permutation Group with generators [(1,2)]
   sage: H = G.quotient(K); H
   Permutation Group with generators [(1,2)(3,6)(4,5), (1,3,5)(2,4,6)]
   sage: H.is_isomorphic(SymmetricGroup(3))
   True

SageMath can also compute the normalizer of a subgroup :math:`H` of :math:`G`, which is the largest subgroup of :math:`G` containing :math:`H` in which :math:`H` is normal.
Here we compute the normalizer of the  cyclic permutation group :math:`H` created above inside of  :math:`S_4`.  We get the dihedral group :math:`D_4`.
If we had used a different 4-cycle the resulting group may have been isomorphic to :math:`D_4` but not equal to it. ::

   sage: G.normalizer(H).cardinality()
   8
   sage: HK.normalizer(H)== DihedralGroup(4)
   True

For some groups the list  of all subgroups may be large.  To better understand the subgroups of :math:`G` we may compute one group from each conjugacy class.  The following computations show that there are 30 subgroups of :math:`S_4` but only 11 up to conjugacy.  Every other subgroup is not only isomorphic to one of the 11, given by :meth:`conjugacy_classes_subgroups`, but is also isomorphic via conjugation by some element of :math:`G`.  ::

   sage: G
   Symmetric group of order 4! as a permutation group
   sage: G.subgroups()
   [Permutation Group with generators [()], Permutation Group with generators [(1,2)(3,4)], Permutation Group with generators [(1,3)(2,4)], Permutation Group with generators [(1,4)(2,3)], Permutation Group with generators [(3,4)], Permutation Group with generators [(2,3)], Permutation Group with generators [(2,4)], Permutation Group with generators [(1,2)], Permutation Group with generators [(1,3)], Permutation Group with generators [(1,4)], Permutation Group with generators [(2,4,3)], Permutation Group with generators [(1,2,3)], Permutation Group with generators [(1,4,2)], Permutation Group with generators [(1,3,4)], Permutation Group with generators [(1,4)(2,3), (1,3)(2,4)], Permutation Group with generators [(1,2)(3,4), (3,4)], Permutation Group with generators [(1,4)(2,3), (2,3)], Permutation Group with generators [(1,3)(2,4), (2,4)], Permutation Group with generators [(1,2)(3,4), (1,3,2,4)], Permutation Group with generators [(1,3)(2,4), (1,4,3,2)], Permutation Group with generators [(1,4)(2,3), (1,2,4,3)], Permutation Group with generators [(3,4), (2,4,3)], Permutation Group with generators [(3,4), (1,3,4)], Permutation Group with generators [(1,2), (1,2,3)], Permutation Group with generators [(1,2), (1,4,2)], Permutation Group with generators [(1,3)(2,4), (1,4)(2,3), (1,2)], Permutation Group with generators [(1,2)(3,4), (1,3)(2,4), (1,4)], Permutation Group with generators [(1,4)(2,3), (1,2)(3,4), (1,3)], Permutation Group with generators [(1,3)(2,4), (1,4)(2,3), (2,4,3)], Permutation Group with generators [(1,3)(2,4), (1,4)(2,3), (2,4,3), (1,2)]]
   sage: len(G.subgroups())
   30
   sage: G.conjugacy_classes_subgroups()
   [Permutation Group with generators [()], Permutation Group with generators [(1,3)(2,4)], Permutation Group with generators [(3,4)], Permutation Group with generators [(2,4,3)], Permutation Group with generators [(1,4)(2,3), (1,3)(2,4)], Permutation Group with generators [(1,2)(3,4), (3,4)], Permutation Group with generators [(1,2)(3,4), (1,3,2,4)], Permutation Group with generators [(3,4), (2,4,3)], Permutation Group with generators [(1,3)(2,4), (1,4)(2,3), (1,2)], Permutation Group with generators [(1,3)(2,4), (1,4)(2,3), (2,4,3)], Permutation Group with generators [(1,3)(2,4), (1,4)(2,3), (2,4,3), (1,2)]]
   sage: len(G.conjugacy_classes_subgroups())
   11

**Exercises:**

   #. Find two subgroups of :math:`A_4` that are conjugate in :math:`S_4` but are not conjugate in :math:`A_4`.



.. _Group_homomorphisms:

.. index:: groups; homomorphisms

.. index:: PermutationGroupMorphism

Permutation Group Homomorphisms
++++++++++++++++++++++++++++++++

To construct a homomorphism between two permutation groups we use the :func:`.PermutationGroupMorphism` command. For an example let us use the two isomorphic groups that we constructed earlier.  ::

        sage: G = SymmetricGroup(5)
	sage: r = G('(1,2,5,4,3)')
	sage: s = G('(1,5),(3,4)')
	sage: H = G.subgroup([r,s])
	sage: H
	Subgroup of SymmetricGroup(5) generated by [(1,2,5,4,3), (1,5)(3,4)]
	sage: D = DihedralGroup(5)
	sage: D
	Dihedral group of order 10 as a permutation group

A homomorphism between these is constructed by listing an association between the *generators* of one group to the generators of the other. To see these we will use the :meth:`.gens()` method provided by our groups ::

	sage: H.gens()
	[(1,2,5,4,3), (1,5)(3,4)]
	sage: D.gens()
	[(1,2,3,4,5), (1,5)(2,4)]

We construct the homomorphism :math:`\phi: H \rightarrow D` that sends :math:`(1,2,5,4,3) \rightarrow (1,2,3,4,5)` and :math:`(1,5)(3,4) \rightarrow (1,5)(2,4)` as follows: ::

	sage: phi = PermutationGroupMorphism(H,D,H.gens(), D.gens())
	sage: phi
	Homomorphism : Permutation Group with generators [(1,2,5,4,3), (1,5)(3,4)] --> Dihedral group of order 10 as a permutation group

We can apply this homomorphism as we would any function, by calling it. ::

	sage: phi( '(2,3)(4,5)')
	(1,3)(4,5)
	sage: phi( '(1,5,3,2,4)')
	(1,3,5,2,4)
	sage: phi('(1,5)')
	---------------------------------------------------------------------------
	AttributeError                            Traceback (most recent call last)
	...
	AttributeError: 'str' object has no attribute '_gap_init_'

Note that we get an  :exc:`AttributeError` because the permutation
:math:`(1,5)` is not in the domain of :meth:`phi`.


.. index:: kernel, groups; kernel of homomorphism

The homomorphism also comes equipped with a few useful methods, the most useful is the :meth:`.kernel` method, which yields the kernel of the homomorphism. Since this homomorphism is an injection, the kernel is just the trivial group. ::

	sage: phi.kernel()
	Permutation Group with generators [()]


.. index::  direct product, Cartesian product

The *direct product* of two PermutationGroups produces another
PermutationGroup, but in a larger symmetric group. The output is a
list of length five consisting of the direct product  followed by four
homomorphisms.  The first two homomorphism are the natural ones from
each factor into the product.  The second two homomorphisms are the
natural projections from the product on to each factor. ::

  sage: C4 = CyclicPermutationGroup(4)
  sage: C3 = CyclicPermutationGroup(3)
  sage: C4xC3 = C4.direct_product(C3);  C4xC3
  (Permutation Group with generators [(5,6,7), (1,2,3,4)], Permutation group morphism:
  From: Cyclic group of order 4 as a permutation group
  To:   Permutation Group with generators [(5,6,7), (1,2,3,4)]
  Defn: Embedding( Group( [ (1,2,3,4), (5,6,7) ] ), 1 ), Permutation group morphism:
  From: Cyclic group of order 3 as a permutation group
  To:   Permutation Group with generators [(5,6,7), (1,2,3,4)]
  Defn: Embedding( Group( [ (1,2,3,4), (5,6,7) ] ), 2 ), Permutation group morphism:
  From: Permutation Group with generators [(5,6,7), (1,2,3,4)]
  To:   Cyclic group of order 4 as a permutation group
  Defn: Projection( Group( [ (1,2,3,4), (5,6,7) ] ), 1 ), Permutation group morphism:
  From: Permutation Group with generators [(5,6,7), (1,2,3,4)]
  To:   Cyclic group of order 3 as a permutation group
  Defn: Projection( Group( [ (1,2,3,4), (5,6,7) ] ), 2 ))

If we just want the direct product group, we must select the 0th element of the direct product. ::

  sage: C4xC3[0]
  Permutation Group with generators [(1,2,3,4), (5,6,7)]

**Exercises:**

   #. There is a homomorphism from the dicyclic group of index :math:`n` to the dihedral group of index :math:`n` .  Construct it and find the kernel.


.. _matrix_groups:

Matrix Groups
------------------------

Please contribute!

.. _abelian_groups:

Abelian Groups
--------------------

Please contribute!

.. _linear_algebra:

.. index:: linear algebra

Linear Algebra
==============

.. _vectors_and_matrices:


Vectors and Matrices
--------------------

.. index:: vector

To create a vector, use the :func:`vector` command with a list of
entries. Scalar multiples and the dot product are straightforward to
compute. As with lists, vectors are indexed starting from :math:`0`. ::

	sage: v= vector([1,2,3,4])
	sage: v[0]
	1
	sage: v[4]
	ERROR: An unexpected error occurred while tokenizing input

Arithmetic on vectors is what one would expect.  SageMath will produce an error message if you add two vectors of different lengths. ::

        sage: 7*v
	(7, 14, 21, 28)
	sage: v + vector([2,1,4,5])
	(3, 3, 7, 9)
	sage: v*v
	sage: v + vector([2,1,4])
	---------------------------------------------------------------------------
	TypeError                                 Traceback (most recent call last)

	/Users/mosullivan/Work/SageMath/Tutorial/sdsu-sage-tutorial/<ipython console> in <module>()

	/Applications/sage/local/lib/python2.6/site-packages/sage/structure/element.so in sage.structure.element.ModuleElement.__add__ (sage/structure/element.c:7627)()

	/Applications/sage/local/lib/python2.6/site-packages/sage/structure/coerce.so in sage.structure.coerce.CoercionModel_cache_maps.bin_op (sage/structure/coerce.c:6995)()

	TypeError: unsupported operand parent(s) for '+': 'Ambient free module of rank 4 over the principal ideal domain Integer Ring' and 'Ambient free module of rank 3 over the principal ideal domain Integer Ring'

.. index:: matrix

We use the :func:`.matrix` command to construct a matrix with a list of the *rows* of the matrix as the argument. ::

	sage: matrix([[1,2],[3,4]])
	[1 2]
	[3 4]

We can also construct a matrix by specifying all of the coordinates in a single matrix while specifying the dimensions of the matrix. The following command creates a matrix with :math:`4` rows and :math:`2` columns.  ::

  sage: matrix(4,2, [1,2,3,4,5,6,7,8])
  [1 2]
  [3 4]
  [5 6]
  [7 8]

If the matrix that we want to construct is square we can omit the number of columns from the argument. ::

  sage: matrix(2,[1,2,3,4])
  [1 2]
  [3 4]

By default, SageMath constructs the matrix over the smallest universe which contains the coordinates. ::

  sage: parent(matrix(2,[1,2,3,4]))
  Full MatrixSpace of 2 by 2 dense matrices over Integer Ring
  sage: parent(matrix(2,[1,2/1,3,4]))
  Full MatrixSpace of 2 by 2 dense matrices over Rational Field
  sage: parent(matrix(2,[x,x^2,x-1,x^3])
  Full MatrixSpace of 2 by 2 dense matrices over Symbolic Ring

We can specify the universe for the coordinates of a matrix or vector by giving it as an optional argument. ::

	sage: matrix(QQ,2,[1.1,1.2,1.3,1.4])
	[11/10   6/5]
	[13/10   7/5]

.. index:: identity_matrix

There are shortcuts in SageMath to construct some of the more commonly used matrices. To construct the identity matrix we use the :func:`identity_matrix` function. ::

	sage: identity_matrix(3)
	[1 0 0]
	[0 1 0]
	[0 0 1]

.. index:: zero_matrix

To construct the zero matrix we may use :func:`zero_matrix` or the
regular matrix function with no list  input. ::

	sage: zero_matrix(2,2)
	[0 0]
	[0 0]
	sage: matrix(2)
	[0 0]
	[0 0]
	sage: matrix(2,3)
	[0 0 0]
	[0 0 0]

Note that if we use :func:`zero_matrix` we must input two integers.


**Exercises:**

  #. Use SageMath to construct the vector :math:`v = \left(4, 10, 17, 28, 2 \right)`
  #. Construct the following matrix over the rational numbers in SageMath.

     .. math::
	\left(\begin{array}{ccc}
	5 & 3 & 2 \\
	4 & 7 & 10 \\
	2 & 11 & 1 \end{array}\right)

  #. Construct a 10x10 identity matrix.
  #. Construct a 20x10 zero matrix.


.. index:: matrix arithmetic, arithmetic; matrix

.. _matrix_arithmetic:

Matrix Arithmetic
-----------------

    You should be familiar with :ref:`vectors_and_matrices`.

We may use ``+``, ``-``, ``*`` and ``^`` for matrix addition,
subtraction, multiplication and exponents. ::

	sage: A=matrix(2,[1,1,0,1])
	sage: B=matrix(2,[1,0,1,1])
	sage: A+B
	[2 1]
	[1 2]
	sage: A*B
	[2 1]
	[1 1]
	sage: B*A
	[1 1]
	[1 2]
	sage: A-B
	[ 0  1]
	[-1  0]
	sage: A^3
	[1 3]
	[0 1]

We can compute the *inverse* of a matrix by raising it to the :math:`-1` -th power. ::

	sage: A^-1
	[ 1 -1]
	[ 0  1]

If the matrix is not invertible SageMath will complain about a :class:`ZeroDivisionError`. ::

  sage: A = matrix([[4,2],[8,4]])
  sage: A^-1
  ---------------------------------------------------------------------------
  ZeroDivisionError                         Traceback (most recent call last)
  ... (Long error message)
  ZeroDivisionError: input matrix must be nonsingular

.. index:: transpose, vector

When multiplying vectors and matrices; vectors can be considered both as rows or as columns, so you can multiply a 3-vector by a 3×n matrix on the right, or by a n×3 matrix on the left. ::

        sage: x = vector([12,3,3])
	sage: x
	(12, 3, 3)
	sage: A
	[1 2 3]
	[4 5 6]
	sage: A*x
	(27, 81)
	sage: B = transpose(A)
	sage: B
	[1 4]
	[2 5]
	[3 6]
	sage: x*B
	(27, 81)

.. index:: det, matrix; determinant

We use the :meth:`det` method to calculate the *determinant* of a square matrix. ::

  sage: A= matrix([[-1/2,0,-1],[0,-2,2],[1,0,-1/2]]); A
  [-1/2    0   -1]
  [   0   -2    2]
  [   1    0 -1/2]
  sage: A.det()
  -5/2

.. index:: matrix; invertability, is_invertible

To check if a matrix is invertible we use the :meth:`is_invertible` method. ::

  sage: A=matrix(2,[1,1,0,1])
  sage: A.is_invertible()
  True
  sage: A.det()
  1

The invertablility of a matrix depends on the ring or field it is defined over. For example: ::

  sage: B=matrix(2,[1,2,3,4])
  sage: B.is_invertible()
  False

In this example, SageMath assumes that the matrix ``B`` is defined over the integers and not the rationals, where it does not have an inverse. But if we define ``B`` as a matrix over the rationals, we obtain different results. ::

  sage: B = matrix(QQ, 2,[1,2,3,4])
  sage: B
  [1 2]
  [3 4]
  sage: B.is_invertible()
  True

If we ask SageMath to compute the inverse of a matrix over the integers it will automatically coerce ``B`` into a matrix over the rationals if necessary. ::

  sage: B = matrix(2,[1,2,3,4])
  sage: parent(B)
  Full MatrixSpace of 2 by 2 dense matrices over Integer Ring
  sage: B^-1
  [  -2    1]
  [ 3/2 -1/2]
  sage: parent(B^-1)
  Full MatrixSpace of 2 by 2 dense matrices over Rational Field

**Exercises:**

  #. Consider the matrices:

     .. math::
	A = \left(\begin{array}{cc}
	1 & 3 \\
	7 & 8 \end{array} \right) \quad \textrm{and} \quad
	B = \left(\begin{array}{cc}
	4 & 8 \\
	9 & 15 \end{array} \right)

      Compute the following:

       a) :math:`A + B`
       b) :math:`AB`
       c) :math:`B^{-1}`
       d) :math:`B^{-1} A B`

  #. Which of the following matrices is invertable over :math:`\mathbb{Z}`? What about :math:`\mathbb{Q}`?

     .. math::
	A = \left(\begin{array}{cc}
	2 & 8 \\
	4 & 16 \end{array} \right) \qquad
	B = \left(\begin{array}{cc}
	2 & 7 \\
	13 & 24 \end{array} \right) \qquad
	C = \left(\begin{array}{cc}
	1 & 4 \\
	2 & 7 \end{array} \right) \qquad
	D = \left(\begin{array}{cc}
	4 & 6 \\
	8 & -2 \end{array} \right)


.. _matrix_manipulation:

.. index:: matrix; manipulation

Matrix Manipulation
-------------------

    You should be familiar with :ref:`vectors_and_matrices` and :ref:`matrix_arithmetic`.

In this section we will cover some of the commands that we can use to *manipulate* matrices. Let's begin by defining a matrix over the rational numbers. ::

  sage: M = matrix(QQ, [[1,2,3],[4,5,6],[7,8,9]]); M
  [1 2 3]
  [4 5 6]
  [7 8 9]

.. index:: rows, columns, matrix; rows, matrix, columns

To get a list of row and column vectors, we use the :meth:`rows` and :meth:`columns` methods. ::

   sage: M.rows()
   [(1, 2, 3), (4, 5, 6), (7, 8, 9)]
   sage: M.columns()
   [(1, 4, 7), (2, 5, 8), (3, 6, 9)]

.. index:: row, column, matrix; row, matrix; column

The following examples show how to get a particular row or column
vector. Remember tl that SageMath follows Python's convention that all of the indicies begin with zero. ::

   sage: M.row(0)
   (1, 2, 3)
   sage: M.row(2)
   (7, 8, 9)
   sage: M.column(1)
   (2, 5, 8)
   sage: M.column(2)
   (3, 6, 9)

.. index:: matrix; diagonal, diagonal

You can even get a list of the diagonal entries, by calling the :meth:`diagonal` method. ::

   sage: M.diagonal()
   [1, 5, 9]

.. index:: matrix_from_columns, matrix_from_rows, matrix_from_rows_and_columns

SageMath also allows us to contruct new matrices from the row and/or column vectors. ::

   sage: M.matrix_from_columns([0,2])
   [1 3]
   [4 6]
   [7 9]
   sage: M.matrix_from_rows([0,2])
   [1 2 3]
   [7 8 9]
   sage: M.matrix_from_rows_and_columns([0,2],[0,2])
   [1 3]
   [7 9]

It should be noted that the :meth:`matrix_from_rows_and_columns` returns the *intersection* of the rows and columns specified. In the above example we are selecting the matrix that consists of the four 'corners' of our :math:`3\times3` matrix.

.. index:: rescale_row, rescale_col

Next we will discuss some of the elementary row operations. To multiply a row or column by a number we use the :meth:`rescale_row` or :meth:`rescale_column` methods. Note that these commands change the matrix itself. ::

   sage: M.rescale_row(1,-1/4); M
   [   1    2    3]
   [  -1 -5/4 -3/2]
   [   7    8    9]
   sage: M.rescale_col(2,-1/3); M
   [   1    2   -1]
   [  -1 -5/4  1/2]
   [   7    8   -3]
   sage: M.rescale_row(1,-4); M
   [ 1  2 -1]
   [ 4  5 -2]
   [ 7  8 -3]

.. index:: add_multiple_of_row

We can add a multiple of a row or column to another row or column by
using the :meth:`add_multiple_of_row` method. The first command takes
:math:`-4` times the row :math:`0`  and adds it to row :math:`1`.  ::

   sage: M.add_multiple_of_row(1,0,-4); M
   [ 1  2 -1]
   [ 0 -3  2]
   [ 7  8 -3]
   sage: M.add_multiple_of_row(2,0,-7); M
   [ 1  2 -1]
   [ 0 -3  2]
   [ 0 -6  4]

.. index:: add_multiple_of_column

The same can be done with the column vectors, which are also zero indexed. ::

   sage: M.add_multiple_of_column(1,0,-2);M
   [ 1  0 -1]
   [ 0 -3  2]
   [ 0 -6  4]
   sage: M.add_multiple_of_column(2,0,1);M
   [ 1  0  0]
   [ 0 -3  2]
   [ 0 -6  4]

.. index:: swap_rows, swap_columns

If we don't like the ordering of our rows or colums we can swap them in place.  ::

   sage: M.swap_rows(1,0); M
   [ 0 -3  2]
   [ 1  0  0]
   [ 0 -6  4]
   sage: M.swap_columns(0,2); M
   [ 2 -3  0]
   [ 0  0  1]
   [ 4 -6  0]

.. index:: set_row, set_column

If we want to change a row or column of `M` then we use the :meth:`set_column` or :meth:`set_row` methods. ::

   sage: M.set_column(0,[1,2,3]);M
   [ 1 -3  0]
   [ 2  0  1]
   [ 3 -6  0]
   sage: M.set_row(0,[1,2,5]);M
   [ 1  2  5]
   [ 2  0  1]
   [ 3 -6  0]

.. index:: set_block

And finally if we want to change a whole "block" of a matrix, we use the :meth:`set_block` method with the coordinates of where we want the upper left corner of the block to begin. ::

   sage: B = matrix(QQ,[ [1,0 ],[0,1]]); B
   [1 0]
   [0 1]
   sage: M.set_block(1,1,B); M
   [1 2 5]
   [2 1 0]
   [3 0 1]

.. index:: echelon_form, echelonize

Of course, if all we want is the *echelon form* of the matrix we can use either the :meth:`echelon_form` or :meth:`echelonize` methods. The difference between the two is the former returns a copy of the matrix in echelon form without changing the original matrix and the latter alters the matrix itself. ::

   sage: M.echelon_form()
   [1 0 0]
   [0 1 0]
   [0 0 1]

   sage: M.echelonize(); M
   [ 1  0  0]
   [ 0  1  0]
   [ 0  0  1]


Next we  use the *augmented* matrix and the echelon form to solve a :math:`3\times 4` system of the form :math:`Mx = b`. First we define the matrix `M` and the vector `b` ::

   sage: M = matrix(QQ,   [[2,4,6,2,4],[1,2,3,1,1],[2,4,8,0,0],[3,6,7,5,9]]); M
   [2 4 6 2 4]
   [1 2 3 1 1]
   [2 4 8 0 0]
   [3 6 7 5 9]
   sage: b = vector(QQ, [56, 23, 34, 101])

.. index:: augment

Then we construct the augmented matrix :math:`\left( M\ \vert b  \right)`, store it in the variable `M_aug` and compute it's echelon form. ::

   sage: M_aug = M.augment(b); M_aug
   [  2   4   6   2   4  56]
   [  1   2   3   1   1  23]
   [  2   4   8   0   0  34]
   [  3   6   7   5   9 101]
   sage: M_aug.echelon_form()
   [ 1  2  0  4  0 21]
   [ 0  0  1 -1  0 -1]
   [ 0  0  0  0  1  5]
   [ 0  0  0  0  0  0]

This tells us that we have a one dimensional solution space that  consists of vectors of the form :math:`{v = c \left(-2,1,0,0,0 \right) + \left(21,0,1,0,5\right)}`. ::

    sage: M*vector([21,0,-1,0,5])
    (56, 23, 34, 101)
    sage  M*vector([-2,1,0,0,0])
    (0, 0, 0, 0)

.. index:: solve_right

If all we need is a *single* solution to this system, we can use the :meth:`solve_right` method. ::

   sage: M.solve_right(b)
   (21, 0, -1, 0, 5)

.. _vectors_and_matrices_arithmetic:

**Exercises:**

  #. Consider the matrix.

     .. math::
	A = \left(\begin{array}{ccc}
	4 & 17 & 23  \\
	1/32 & 2 & 17 \\
	16 & -23 & 27 \end{array} \right)

     Use only the elementary row operations discussed to put :math:`A` into *echelon* form.

  #. Using the commands discussed in this section, transform the matrix on the left into the matrix on the right.

  a)
     .. math::
	\left(\begin{array}{rrrrr}
	-7 & -1 & 1 & 4 & 0 \\
	-8 & -2 & 4 & 2 & 6 \\
	1 & 1 & -3 & 3 & 0 \\
	0 & 8 & 13 & -2 & 0 \\
	1 & 4 & 0 & -1 & 4
	\end{array}\right) \quad \quad
	\left(\begin{array}{rrrrr}
	-7 & -8 & 1 & 0 & 1 \\
	-1 & -2 & 1 & 8 & 4 \\
	1 & 4 & -3 & 13 & 0 \\
	4 & 2 & 3 & -2 & -1 \\
	0 & 6 & 0 & 0 & 4
	\end{array}\right)

  b)
    .. math::

       \left(\begin{array}{rrrr}
       -1 & -2 & 1 & -13 \\
       -3 & -1 & 1 & 1 \\
       1 & 1 & -1 & 1 \\
       -2 & -1 & -9 & 1
       \end{array}\right) \quad \quad
       \left(\begin{array}{rrrr}
       1 & 0 & 0 & 100 \\
       0 & 1 & 0 & 12 \\
       0 & 0 & 1 & 111 \\
       0 & 0 & 0 & 202
       \end{array}\right)
  c)
    .. math::

       \left(\begin{array}{rrr}
       0 & -1 & 1 \\
       -2 & 1 & -1 \\
       1 & 0 & 1
       \end{array}\right) \quad \quad
       \left(\begin{array}{rrrr}
       0 & -1 & 1 & -4 \\
       -2 & 1 & -1 & -1 \\
       1 & 0 & 1 & 1
       \end{array}\right)

.. _vector_and_matrix_spaces:

.. index:: Vector and Matrix Spaces

Vector and Matrix Spaces
------------------------

.. index:: MatrixSpace

It is sometimes useful to create the space of all matrices of
particular dimension, for which we use the :func:`MatrixSpace`
function. We must specify the field (or indeed any ring) where the
entries live. ::

	sage: MatrixSpace(QQ,2,3)
	Full MatrixSpace of 2 by 3 dense matrices over Rational Field


If we input a ring :math:`R` and an integer :math:`n` we get the
matrix ring of :math:`n\times n`
matrices over :math:`R`. Coercion can be used to construct the zero matrix, the
indentity matrix, or a matrix with specified entries as shown. ::

	sage: Mat = MatrixSpace(ZZ,2); Mat
	Full MatrixSpace of 2 by 2 dense matrices over Integer Ring
	sage: Mat(1)
	[1 0]
	[0 1]
	sage: Mat(0)
	[0 0]
	[0 0]
	sage: Mat([1,2,3,4])
	[1 2]
	[3 4]

.. index:: rank, right_kernel, left_kernel, row_space

We may compute various spaces associated to a matrix. ::

        sage: Mat = MatrixSpace(QQ, 3,4)
	sage: A = Mat([[1,2,3,4], [1,3,4,4],[2,5,7,8]])
	sage: A
	[1 2 3 4]
	[1 3 4 4]
	[2 5 7 8]
	sage: A.rank()
	2
	sage: A.right_kernel()
	Vector space of degree 4 and dimension 2 over Rational Field
	Basis matrix:
	[   1    0    0 -1/4]
	[   0    1   -1  1/4]
	sage: A.left_kernel()
	Vector space of degree 3 and dimension 1 over Rational Field
	Basis matrix:
	[ 1  1 -1]
	sage: A.row_space()
	Vector space of degree 4 and dimension 2 over Rational Field
	Basis matrix:
	[1 0 1 4]
	[0 1 1 0]

**Exercises:**

#. For the following 5x3 matrix:

   .. math::

      \left(\begin{array}{rrr}
      1 & -1 & -1 \\
      0 & 1 & -3 \\
      1 & 1 & 1 \\
      0 & -6 & -20 \\
      0 & 0 & 0
      \end{array}\right)

   Use SageMath to compute the bases for the following spaces:

     a) The right and left kernel.
     b) The row space.
     c) The column space.


.. _vectors_and_matrices__jordan_form:

.. index:: Jordan Canonical Form

Mini-Topic: The Jordan Canonical Form
-------------------------------------

For every linear transformation :math:`\mathrm{T}:\mathbb{R}^n \longrightarrow \mathbb{R}^{n}` there is a basis of :math:`\mathbb{R}^n` such that the matrix :math:`\left[m\right]_{\mathcal{B}}` is in an *almost* diagonal form. This unique matrix is called the *Jordan Canonical Form* of :math:`\mathrm{T}`. For more information on this please refer to this article_ on Wikipedia. To demonstrate some common tools that we use in SageMath we will compute this basis for the linear transformation

.. math::
   \mathrm{T}\left(x,y,z,t \right) = \left(2x+y, 2y+1, 3z, y-z+3t \right).

We will begin by defining :math:`\mathrm{T}` in SageMath. ::

      sage: T(x,y,z,t) = (2*x+y, 2*y+1, 3*z, y - z + 3*t)

.. index:: transpose

Now, let's use the standard ordered basis of :math:`\mathbb{R}^3` to find the matrix form of :math:`\mathrm{T}`. ::

  sage: T(1,0,0,0), T(0,1,0,0), T(0,0,1,0), T(0,0,0,1)
  ((2, 1, 0, 0), (1, 3, 0, 1), (0, 1, 3, -1), (0, 1, 0, 3))

Note that since SageMath uses rows to construct a matrix we must use the  :func:`transpose` function to get the matrix we expect. ::

  sage: M = transpose(matrix([[2,1,0,0],[0,2,1,0],  [0,0,3,0],[0,1,-1,3]]));  M
  [ 2  1  0  0]
  [ 0  2  1  0]
  [ 0  0  3  0]
  [ 0  1 -1  3]

.. index:: characteristic_polynomial, factor

Once we have the matrix we will compute its *characteristic polynomial* and then factor it to find its eigenvalues. ::

  sage: f = M.characteristic_polynomial(); f
  x^4 - 10*x^3 + 37*x^2 - 60*x + 36
  sage: f.factor()
  (x - 3)^2 * (x - 2)^2

.. index:: eigenvalues

Or, alternatively, we can compute the eigenvalues directly by doing the following

  sage: eval_M = M.eigenvalues(); eval_M
  [3, 3, 2, 2]
  
.. index:: eigenvectors_right

Above  we have two eigenvalues :math:`\lambda_1 = 3` and :math:`\lambda_2 = 2` and both are of algebraic multiplicity :math:`2`. Now we need to look at the associated  *eigenvectors*. To do so we will use the :meth:`eigenvectors_right` method. ::

  sage: evec_M = M.eigenvectors_right(); evec_M
  [(3, [
  (1, 1, 1, 0),
  (0, 0, 0, 1)
  ], 2), (2, [
  (1, 0, 0, 0)
  ], 2)]
  sage: ev_M[1][1][0]
  (1, 0, 0, 0)

.. index:: identity_matrix, augment

What is returned is a :func:`list` of ordered tripples. Each triple is
consists  of an eigenvalue followed by a list with a basis for the
associated  eigenspace followed by the dimension of the associated eigenspace. Note that the eigenvalue :math:`2` has algebraic multiplicity of :math:`2` but geometric multiplicity only :math:`1`. This means that we will have to compute a *generalized eigenvector* for this eigenvalue. We will do this by solving the system :math:`\left(M - 2\mathrm{I}\right) v = x`, where :math:`x` is the eigenvector :math:`\left(1,0,0,0\right)`. I will use the :meth:`echelon_form` of the augmented matrix to solve the system.  ::

      sage: (M - 2*identity_matrix(4)).augment(ev_M[1][1][0])
      [ 0  1  0  0  1]
      [ 0  0  1  0  0]
      [ 0  0  1  0  0]
      [ 0  1 -1  1  0]
      sage: _.echelon_form()
      [ 0  1  0  0  1]
      [ 0  0  1  0  0]
      [ 0  0  0  1 -1]
      [ 0  0  0  0  0]
      sage: gv = vector([1,1,0,-1]); gv
      (1, 1, 0, -1)

.. index:: transpose

With the generalized eigenvector `gv`, we now have the right number of linearly independent vectors to form a basis for our *Jordan Form* matrix. We will next form the *change of basis matrix* that consists of these vectors as columns.  ::

      sage: S = transpose( matrix( [[1,1,1,0],[0,0,0,1],[1,0,0,0],gv])); S
      [ 1  0  1  1]
      [ 1  0  0  1]
      [ 1  0  0  0]
      [ 0  1  0 -1]

.. index:: inverse

Now we will compute the matrix representation of :math:`\mathrm{T}` with respect to this basis. ::

      sage: S.inverse()*M*S
      [3 0 0 0]
      [0 3 0 0]
      [0 0 2 1]
      [0 0 0 2]

..  index:: jordan_form

And there it is, the *Jordan Canonical Form* of the linear transformation :math:`\mathrm{T}`. Of course we could have just used SageMath's built in :meth:`jordan_form` method to compute this directly. ::

   sage: M.jordan_form()
   [3|0|0 0]
   [-+-+---]
   [0|3|0 0]
   [-+-+---]
   [0|0|2 1]
   [0|0|0 2]

But that wouldn't be any fun!

.. _article: http://en.wikipedia.org/wiki/Jordan_normal_form

**Exercises:**

  #. Compute a jordan basis for the following matrix using the steps outlined in this section.

     .. math::

	\left(\begin{array}{rrrr}
	1 & 2 & 0 & 2 \\
	0 & 2 & 0 & 0 \\
	-1 & 2 & -\frac{1}{2} & -2 \\
	0 & 2 & 0 & 2
	\end{array}\right)


.. _rings:

.. index:: Rings

Rings
=====

.. index:: Polynomial Rings

.. _polynomial_rings:

Polynomial Rings
----------------

.. index:: PolynomialRing

Constructing polynomial rings in SageMath is fairly straightforward. We
just specify the name of the "indeterminate" variable as well as the
coefficient ring. ::

	sage: R.<x>=PolynomialRing(ZZ)
	sage: R
	Univariate Polynomial Ring in x over Integer Ring

.. index:: parent

Once the polynomial ring has been defined we can construct a polynomial without any special coercions. ::

  sage: p = 2*x^2 + (1/2)*x + (3/5)
  sage: parent(p)
  Univariate Polynomial Ring in x over Rational Field

.. index:: PolynomialRing

Though :math:`x` is the most common choice for a variable, we could have chosen
any letter for the indeterminate.  ::

	sage: R.<Y>=PolynomialRing(QQ)
	sage: R
	Univariate Polynomial Ring in Y over Rational Field

.. index:: parent

Polynomials with rational coefficients in Y are now valid objects in SageMath. ::

  sage: q = Y^4 + (1/2)*Y^3 + (1/3)*Y + (1/4)
  sage: q
  Y^4 + 1/2*Y^3 + 1/3*Y + 1/4
  sage: parent(q)
  Univariate Polynomial Ring in Y over Rational Field

.. index:: Integers, PolynomialRing

We can define polynomial rings over any ring or field.  ::

	sage: Z7=Integers(7)
	sage: R.<x>=PolynomialRing(Z7); R
	Univariate Polynomial Ring in x over Ring of integers modulo 7

.. index:: parent

When entering a polynomial into SageMath the coefficients are automatically coerced into the ring or field specified.  ::

  sage: p = 18*x^2 + 7*x + 16; p
  4*x^2 + 2
  sage: parent(p)
  Univariate Polynomial Ring in x over Ring of integers modulo 7

Of course this coercion has to be well defined.  ::

  sage: q  = x^4 + (1/2)*x^3 + (1/3)*x^2 + (1/4)*x + (1/5)
  ---------------------------------------------------------------------------
  TypeError                                 Traceback (most recent call last)  ...
  TypeError: unsupported operand parent(s) for '*': 'Rational Field' and 'Univariate Polynomial Ring in x over Ring of integers modulo 7'

.. index:: PolynomialRing, parent

When prudent, SageMath will extend the universe of definition to fit the polynomial entered. For example, if we ask for a rational coefficient in a polynomial ring over :math:`\mathbb{Z}`, SageMath will naturally coerce this polynomial into a ring over :math:`\mathbb{Q}` ::

	sage: S.<y>=PolynomialRing(ZZ)
	sage: 1/2*y
	1/2*y
	sage: parent(1/2*y)
	Univariate Polynomial Ring in y over Rational Field

It should be noted that the ring ``S`` hasn't been changed at all. Nor is ``(1/2)*y` in the universe ``S``. This can be easily verified.  ::

  sage: S
  Univariate Polynomial Ring in y over Integer Ring
  sage: (1/2)*y in S
  False

.. index:: Polynomial Arithmetic

Once constructed, the basic arithmetic with polynomials is straightforward. ::

  sage: R.<x>=PolynomialRing(QQ)
  sage: f=x+1
  sage: g=x^2+x-1
  sage: h=1/2*x+3/4
  sage: f+g
  x^2 + 2*x
  sage: g-h
  x^2 + 1/2*x - 7/4
  sage: f*g
  x^3 + 2*x^2 - 1
  sage: h^3
  1/8*x^3 + 9/16*x^2 + 27/32*x + 27/64

We can also divide elements of the polynomial ring, but this changes  the parent. ::

    sage: f/g
    (x + 1)/(x^2 + x - 1)
    sage: parent(f/g)
    Fraction Field of Univariate Polynomial Ring in x over Rational Field

.. index:: PolynomialRing, degree

A fundamental attribute of a polynomial is its degree. We use the :meth:`degree` method to calculate this. ::

  sage: R.<x>=PolynomialRing(QQ)
  sage: (x^3+3).degree()
  3
  sage: R(0).degree()
  -1

Notice that by convention SageMath sets the degree of 0 to be -1.


The polynomial ring over a field has a division algorithm. As with the integers, we may use the ``//`` operator to determine the *quotient* and the ``%`` operator to determine the *remainder* of a division. ::

  sage: R.<x>=PolynomialRing(Integers(7))
  sage: f=x^6+x^2+1
  sage: g=x^3+x+1
  sage: f // g
  x^3 + 6*x + 6
  sage: f % g
  2*x^2 + 2*x + 2

.. index:: divmod

Additionally, if the coefficients of the polynomial are in :math:`\mathbb{Z}` or :math:`\mathbb{Q}`, we may use the :func:`.divmod` command to compute both at the same time.  ::

  sage: S.<y>=PolynomialRing(QQ)
  sage: a=(y+1)*(y^2+1)
  sage: b=(y+1)*(y+5)
  sage: a // b
  y - 5
  sage: a % b
  26*y + 26
  sage: divmod(a,b)
  (y - 5, 26*y + 26)

.. index:: gcd, Polynomial Rings; gcd

For a field  :math:`F`, the polynomial ring :math:`F[x]` has a division algorithm, so we have a unique greatest common divisor (gcd) of polynomials. This can be computed using the :func:`gcd` command.  ::

  sage: R.<x> = PolynomialRing(QQ)
  sage: p = x^4 + 2*x^3 + 2*x^2 + 2*x + 1
  sage: q = x^4 - 1
  sage: gcd(p,q)
  x^3 + x^2 + x + 1

.. index:: xgcd, Polynomial Rings; xgcd

The greatest common divisor of two integers can be represented as a linear combination of the two integers, and the extended Euclidean algorithm is used to determine one such linear combination. Similarly, the greatest common divisor of  polynomials :math:`a(x)` and :math:`b(x)` may be written in the form :math:`a(x)f(x) + b(x)g(x)` for some polynomials :math:`f(x)` and :math:`g(x)`.  We may use the :func:`xgcd` function to compute the  multipliers  :math:`f(x)` and :math:`g(x)`. ::

  sage: R.<x>=PolynomialRing(ZZ)
  sage: a=x^4-1
  sage: b=(x+1)*x
  sage: xgcd(a,b)
  (x + 1, -1, x^2 - x + 1)
  sage: d,u,v=xgcd(a,b)
  sage: a*u+b*v
  x + 1

.. index:: is_irreducible

To check whether a polynomial is irreducible, we use it's :meth:`is_irreducible` method. ::

  sage: R.<x>=PolynomialRing(Integers(5))
  sage: (x^3+x+1).is_irreducible()
  True
  sage: (x^3+1).is_irreducible()
  False

This method is only suitable for polynomial rings that are defined over a field, as polynomials defined more generally may not  posses a unique factorization.

.. index:: factor

To compute the *factorization* of a polynomial, where defined, we use the :func:`.factor` command.  ::

  sage: R.<x>=PolynomialRing(Integers(5))
  sage: factor(x^3+x+1)
  x^3 + x + 1
  sage: factor(x^3+1)
  (x + 1) * (x^2 + 4*x + 1)

In the example above, we see a confirmation that :math:`x^3+x+1` is
irreducible in :math:`\mathbb{Z}_{5}[x]` whereas :math:`x^3+1` may be
factored, hence is reducible.

We can also consider polynomials in :math:`R[x]` as functions from :math:`R` to :math:`R` by *evaluation*, that is by substituting the indeterminate variable with a member of the coefficient ring. Evaluation of polynomials in SageMath works as expected, by *calling* the polynomial like a function. ::

  sage: R.<x>=PolynomialRing(Integers(3))
  sage: f=2*x+1
  sage: f(0)
  1
  sage: f(1)
  0
  sage: f(2)
  2

.. index:: roots

Calculating the *roots*, or *zeros*, of a polynomial can be done by using the :meth:`roots` method. ::

  sage: ((x-1)^2*(x-2)*x^3).roots()
  [(2, 1), (1, 2), (0, 3)]

SageMath returns a list of pairs :math:`(r,m)` where ``r`` is the root and ``m`` is it's multiplicity. Of course, a polynomial need not have any roots and in this case the *empty list* is returned.  ::

  sage: (x^2+1).roots()
  []


.. index:: Multivariate Polynomial Rings

Multivariate Polynomial Rings
++++++++++++++++++++++++++++++

.. index:: Monomial Orderings

Defining a polynomial ring with more that one variable can be done easily by supplying an extra argument to :func:`.PolynomialRing` which specifies the number of variables desired. ::

  sage: R.<x,y,z> = PolynomialRing(QQ, 3)
  sage: p = -1/2*x - y*z - y + 8*z^2; p
  -y*z + 8*z^2 - 1/2*x - y

Unlike with univariate polynomials, there is not a single way that we can order the terms of a polynomial. So to specify things like the *degree* and the *leading term* of a polynomial we must first fix a rule for deciding when one term is larger than another.  If no argument is specified, SageMath defaults to the *graded reverse lexicographic* ordering, sometimes referred to as *grevlex*, to make these decisions. To read more about *Monomial Orderings*, see this page_ on Wikipedia.

.. _page: http: http://en.wikipedia.org/wiki/Monomial_order


.. index:: monomials, Multivariate Polynomial Rings; monomials

To access a list of the monomials with nonzero coefficients in
:math:`p`, you use the :meth:`.monomials` method. ::

  sage: p.monomials()
  [y*z, z^2, x, y]

These monomials are listed in descending order using the term ordering specified when the ring was constructed.

.. index:: coefficients

To access a list of *coefficients* we use the :meth:`.coefficients` method. ::

  sage: p.coefficients()
  [-1, 8, -1/2, -1]

.. index:: terms

The list of coefficients is provided in the same order as the monomial listing computed earlier. This means that we can create a list of *terms* of our polynomial by  :func:`.zip`-ing up the two lists. ::

  sage: [ a*b for a,b in zip(p.coefficients(),p.monomials())]
  [-y*z, 8*z^2, -1/2*x, -y]

.. index:: lc, lm, lt

Often you want to compute information pertaining to the *largest*, or *leading*, term. We can compute the *lead coefficient*, *leading monomial*, and the *lead term* as follows: ::

  sage: p.lc()
  -1
  sage:
  sage: p.lm()
  y*z
  sage: p.lt()
  -y*z

.. index:: total_degree

We can also compute the polynomial's *total degree* using the :meth:`.total_degree` method. ::

  sage: p.total_degree()
  2

.. index:: exponents

The exponents of each variable in each term, once again specified in descending order, is computed using the :meth:`.exponents` method. ::

  sage: p.exponents()
  [(0, 1, 1), (0, 0, 2), (1, 0, 0), (0, 1, 0)]

and the exponent of the lead term is computed by chaining together two of the methods just presented. ::

  sage: p.lm().exponents()
  [(0, 1, 1)]

.. index:: lexicographic monomial ordering

To change the term ordering we must reconstruct both the ring itself and all of the polynomials with which we were working. The following code constructs a multivariate polynomial ring in :math:`x,y,` and :math:`z` using the *lexicographic* monomial ordering. ::

  sage: R.<x,y,z> = PolynomialRing(QQ,3,order='lex')
  sage: p = -1/2*x - y*z - y + 8*z^2; p
  -1/2*x - y*z - y + 8*z^2

Once the term order  changes, all of the methods discussed earlier, even how SageMath displays the polynomial, take this into account. ::

  sage: p.lm()
  x
  sage: p.lc()
  -1/2
  sage: p.lt()
  -1/2*x
  sage: p.monomials()
  [x, y*z, y, z^2]

Note that the order in which the indeterminates are listed affects the
monomial ordering. In the example above we have the  lexicographic
ordering, with :math:`x>y>z`.   We may redefine the ring to use the lexicographic order :math:`z>y>x`. ::

  sage: R.<z,y,x> = PolynomialRing(QQ,3,order='lex')
  sage:  p = -1/2*x - y*z - y + 8*z^2
  sage: p
  8*z^2 - z*y - y - 1/2*x
  sage: p.lm()
  z^2
  sage: p.lc()
  8
  sage: p.lt()
  8*z^2

Note again how all of the methods automatically take the new ordering into account.

.. index:: Reduction modulo an ideal, mod

Finally we can *reduce* a polynomial modulo a list of polynomials using the :meth:`.mod` method. ::

  sage: r = -x^2 + 1/58*x*y - y + 1/2*z^2
  sage: r.mod([p,q])
  -238657765/29696*y^2 + 83193/14848*y*z^2 + 68345/14848*y - 1/1024*z^4 + 255/512*z^2 - 1/1024



**Exercises:**

  #. Use SageMath to find out which of the following polynomials with rational coefficients are irreducible.

     a) :math:`3 y^{4} - \frac{1}{2} y^{2} - \frac{1}{2} y - \frac{1}{2}`
     b) :math:`2 y^{4} - y^{2} - y`
     c) :math:`\frac{1}{5} y^{5} - \frac{1}{3} y^{4} + y^{3} - \frac{17}{2} y^{2} - 21 y`
     d) :math:`y^{3} + \frac{1}{4} y^{2} - 6 y + \frac{1}{8}`
     e) :math:`3 y^{7} + y^{6} + \frac{9}{2} y^{4} - y^{3} + y^{2} - \frac{1}{2} y`


  #. Factor all of the polynomials over :math:`\mathbb{Z}[x]`.

     a) :math:`-x^{10} + 4x^{9} - x^{8} + x^{7} - x^{6} + 2x^{3} + x^{2} - 1`
     b) :math:`x^{5} + 2x^{4} + x^{3} + 3x^{2} - 3`
     c) :math:`x^{4} + x^{3} - x^{2} - x`
     d) :math:`2x^{8} - 5x^{7} - 3x^{6} + 15x^{5} - 3x^{4} - 15x^{3} + 7x^{2} + 5x - 3`
     e) :math:`6x^{6} - x^{5} - 8x^{4} - x^{3} + 3x^{2} + x`


  #. Compute all of the *roots* and of the following polynomials defined over :math:`\mathbb{Z}_7`. Compare this list to their factorizations.

     a) :math:`2 x^{7} + 3 x^{6} + 6 x^{5} + 4 x^{4} + x^{3} + 5 x^{2} + 2 x + 5`
     b) :math:`3 x^{3} + x^{2} + 2 x + 1`
     c) :math:`3 x^{8} + 5 x^{7} + 5 x^{5} + x^{3} + 2 x^{2} + 6 x`
     d) :math:`x^{5} + 2 x^{4} + x^{3} + 2 x^{2} + 2 x + 1`
     e) :math:`2 x^{10} + 2 x^{8} + 5 x^{6} + x^{5} + 3 x^{4} + 5 x^{3} + 2 x^{2} + 6 x + 5`


.. _ideals_and_quotients:

Ideals and Quotients
--------------------

In this section we will construct and do common computations with ideals and quotient rings.

.. index:: Ideals

.. _ideals:

Ideals
++++++

Once a ring is constructed and a list of generating elements have been selected, the ideal generated by this list is constructed by using the ``*`` operator. ::

  sage: R.<x> = PolynomialRing(QQ)
  sage: I = [2*x^2 + 8*x - 10, 10*x - 10]*R; I
  Principal ideal (x - 1) of Univariate Polynomial Ring in x over Rational Field
  sage: J = [ x^2 + 1, x^3 + x ]*R; J
  Principal ideal (x^2 + 1) of Univariate Polynomial Ring in x over Rational Field
  sage: K = [ x^2 + 1, x - 2]*R; K
  Principal ideal (1) of Univariate Polynomial Ring in x over Rational Field

.. index:: gens, Ideals; gens

SageMath automatically reduces the set of generators. This can be seen by using the :meth:`.gens` method which returns the list of the ideal's generating elements. ::

  sage: I.gens()
  (x - 1,)
  sage: J.gens()
  (x^2 + 1,)
  sage: K.gens()
  (1,)

.. index:: Ideals; membership

Ideal membership can be determined by using the ``in`` conditional. ::

  sage: R(x-1) in I
  True
  sage: R(x) in I
  False
  sage: R(2) in J
  False
  sage: R(2) in K
  True

.. index:: is_prime, is_idempotent, is_principal

You can determine some properties of the ideal by using the corresponding ``is_`` methods. For example, to determine weather the
ideals are *prime*, *principal*, or *idempotent* we enter the following: ::

	sage: J.is_prime()
	True
	sage: K.is_prime()
	False
	sage: I.is_idempotent()
	False
	sage: K.is_principal()
	True



Ideals in Multivarate Polynomial Rings
++++++++++++++++++++++++++++++++++++++

To construct an ideal within a multivariate polynomial ring, we must
first construct the Polynomial ring with a term ordering and a collection of polynomials that will generate the ideal. ::

  sage: R.<x,y,z> = PolynomialRing(QQ,3,order='lex')
  sage: p = -1/2*x - y*z - y + 8*z^2
  sage: q = -32*x + 2869*y - z^2 - 1

.. index:: Ideals; construction

The ideal is constructed in the same manner as before. ::

  sage: I = [p,q]*R
  sage: I
  Ideal (-1/2*x - y*z - y + 8*z^2, -32*x + 2869*y - z^2 - 1) of Multivariate Polynomial Ring in x, y, z over Rational Field

.. index:: groebner_basis

When the ring is a multivariate polynomial, we can compute a special list of generators for ``I``, called a *groebner_basis*. ::

  sage: I.groebner_basis()
  [x - 2869/32*y + 1/32*z^2 + 1/32, y*z + 2933/64*y - 513/64*z^2 - 1/64]

There are different algorithms for computing a Groebner basis. We can change the algorithm by supplying an optional argument to the :meth:`groebner_basis` command. The following commands compute a Groebner basis using the Buchberger algorithm while showing the intermediate results. Very useful for teaching!   ::

  sage: set_verbose(3)
  sage: I.groebner_basis('toy:buchberger')
  (-32*x + 2869*y - z^2 - 1, -1/2*x - y*z - y + 8*z^2) => -2*y*z - 2933/32*y + 513/32*z^2 + 1/32
  G: set([-2*y*z - 2933/32*y + 513/32*z^2 + 1/32, -1/2*x - y*z - y + 8*z^2, -32*x + 2869*y - z^2 - 1])
  (-1/2*x - y*z - y + 8*z^2, -32*x + 2869*y - z^2 - 1) => 0
  G: set([-2*y*z - 2933/32*y + 513/32*z^2 + 1/32, -1/2*x - y*z - y + 8*z^2, -32*x + 2869*y - z^2 - 1])
  (-1/2*x - y*z - y + 8*z^2, -2*y*z - 2933/32*y + 513/32*z^2 + 1/32) => 0
  G: set([-2*y*z - 2933/32*y + 513/32*z^2 + 1/32, -1/2*x - y*z - y + 8*z^2, -32*x + 2869*y - z^2 - 1])
  (-32*x + 2869*y - z^2 - 1, -2*y*z - 2933/32*y + 513/32*z^2 + 1/32) => 0
  G: set([-2*y*z - 2933/32*y + 513/32*z^2 + 1/32, -1/2*x - y*z - y + 8*z^2, -32*x + 2869*y - z^2 - 1])
  3 reductions to zero.
  [x + 2*y*z + 2*y - 16*z^2, x - 2869/32*y + 1/32*z^2 + 1/32, y*z + 2933/64*y - 513/64*z^2 - 1/64]


.. index:: elimination_ideal

We can compute the various *elimination ideals* by using the :meth:`elimination_ideal` method. ::

  sage: I.elimination_ideal([x])
  Ideal (64*y*z + 2933*y - 513*z^2 - 1) of Multivariate Polynomial Ring in x, y, z over Rational Field
  sage: I.elimination_ideal([x,y])
  Ideal (0) of Multivariate Polynomial Ring in x, y, z over Rational Field
  sage: I.elimination_ideal([x,z])
  Ideal (0) of Multivariate Polynomial Ring in x, y, z over Rational Field
  sage: I.elimination_ideal([x])
  Ideal (64*y*z + 2933*y - 513*z^2 - 1) of Multivariate Polynomial Ring in x, y, z over Rational Field
  sage: I.elimination_ideal([y])
  Ideal (64*x*z + 2933*x + 2*z^3 - 45902*z^2 + 2*z + 2) of Multivariate Polynomial Ring in x, y, z over Rational Field
  sage: I.elimination_ideal([z])
  Ideal (263169*x^2 + 128*x*y^2 - 47095452*x*y + 16416*x - 11476*y^3 + 2106993608*y^2 - 1468864*y + 256) of Multivariate Polynomial Ring in x, y, z over Rational Field
  sage: I.elimination_ideal([x,y])
  Ideal (0) of Multivariate Polynomial Ring in x, y, z over Rational Field


.. index:: Quotient Rings

.. _quotient_rings:

Quotient Rings
--------------

.. index:: quotient

To construct the *quotient ring* of a ring with an ideal we use the
:meth:`quotient` method. ::

	sage: R = ZZ
	sage: I = R*[5]
	sage: I
	Principal ideal (5) of Integer Ring
	sage: Q = R.quotient(I)
	sage: Q
	Ring of integers modulo 5

To  preform arithmetic in the quotient ring, we must first *coerce* elements into this universe. For more on why we do this see :ref:`universes_and_coercion`.  ::

	sage: Q(10)
	0
	sage: Q(12)
	2
	sage: Q(10) + Q(12)
	2
	sage: Q(10 + 12)
	2

.. index:: quotient, Indeterminants, ideal, parent

When working with quotients of polynomial rings it is a good idea to give
the indeterminate a new name. ::

	sage: R.<x> = PolynomialRing(ZZ)
	sage: parent(x)
	Univariate Polynomial Ring in x over Integer Ring
	sage: I = R.ideal(x^2 + 1)
	sage: Q.<a> = R.quotient(I)
	sage: parent(a)
	Univariate Quotient Polynomial Ring in a over Integer Ring with modulus x^2 + 1
	sage: a^2
	-1
	sage: x^2
	x^2

Then we can do arithmetic in this quotient ring without having to
explicitly coerce all of our elements. ::

	sage: 15*a^2 + 20*a + 1
	20*a - 14
	sage: (15 + a)*(14 - a)
	-a + 211



.. index:: Properties of Rings

.. _rings_properties_and_tests:

Properties of Rings
------------------------------


.. index:: is_field, is_integral_domain

You can check some of the properties of the rings which have been constructed. For example, to check whether a ring is an *integral domain* or a *field* we use the :meth:`.is_integral_domain` or :meth:`.is_field` methods.   ::

	sage: QQ.is_field()
	True
	sage: ZZ.is_integral_domain()
	True
	sage: ZZ.is_field()
	False
	sage: R=Integers(15)
	sage: R.is_integral_domain()
	False
	sage: S=Integers(17)
	sage: S.is_field()
	True

These properties are often determined instantaneously since they are built into the definitions of the rings and not calculated on the fly.

.. index:: Tab-completion

For a complete listing of properties that are built into a ring, you can use SageMath's built in *tab-completion*. For example, to see all of the properties which can be determined for the rational numbers we type ``QQ.is`` then the tab key. What we get is a list of all of the properties that we can compute. ::

  sage: QQ.is[TAB]
  QQ.is_absolute           QQ.is_finite             QQ.is_ring
  QQ.is_atomic_repr        QQ.is_integral_domain    QQ.is_subring
  QQ.is_commutative        QQ.is_integrally_closed  QQ.is_zero
  QQ.is_exact              QQ.is_noetherian
  QQ.is_field              QQ.is_prime_field

.. index:: characteristic, Rings; characteristic

The *characteristic* of the ring can be computed using the ring's :meth:`.characteristic` method. ::

	 sage: QQ.characteristic()
	 0
	 sage: R=Integers(43)
	 sage: R.characteristic()
	 43
	 sage: F.<a> = FiniteField(9)
	 sage: F.characteristic()
	 3
	 sage: ZZ.characteristic()
	 0

.. index:: Multivariate Polynomial Division Algorithm

.. _mv_division_algorithm:

Mini-Topic: Multivariate Polynomial Division Algorithm
-------------------------------------------------------

In this section we will use SageMath to construct a *division* algorithm for multivariate polynomials. Specifically, for a given polynomial :math:`f` (the dividend) and a sequence of polynomials :math:`f_1, f_2, \ldots, f_k` (the divisors) we want to compute a sequence of quotients :math:`a_1, a_2,\ldots, a_k` and a remainder polynomial :math:`r` so that

.. math::
       f = \sum_{i=1}^{i=k} a_i \cdot f_i + r

where no terms of :math:`r` are divisible by any of the leading terms of :math:`f_i`.

.. index:: GF

The first thing that we will do is to construct the base field for the polynomial ring and determine how many variables we want for the polynomial ring. In this case, lets define a two variable polynomial ring over the finite field :math:`\mathbb{F}_{2}`. ::

    sage: K = GF(2)
    sage: n = 2

Next we will construct the polynomial ring. ::

     sage: P.<x,y> = PolynomialRing(F,2,order="lex")

Since we are working with more than one variable we must tell SageMath how to order the terms, in this case we selected a *lexicographic* ordering. The default term ordering is *degree reverse lexicographic*, where the *total degree* is used first to determine the order of the monomials, then a *reverse lexicographic* order is used to break ties. Other options for monomial orderings are `deglex` (degree lexicographic) or you can define a *block* ordering by using the :func:`TermOrder` command. You can read more on monomial orderings on-line on Wikipedia_ and on MathWorld_,  or the book [Cox2007]_ .

.. [Cox2007] Cox, David and Little, John and O'Shea, Donald, *Ideals, varieties, and algorithms.* Springer 2007
.. _Wikipedia: http://http://en.wikipedia.org/wiki/Monomial_order
.. _MathWorld: http://mathworld.wolfram.com/MonomialOrder.html

Now we will begin our division algorithm. The first thing we will do is define a function which determines whether two monomial *divide* each other. ::

    def does_divide(m1,m2):
    	for c in (vector(ZZ, m1.degrees()) - vector(ZZ,m2.degrees())):
            if c < 0:
               return False
    return True

Then we will define a sequence of polynomials which we will use to reduce our *dividend*. ::

     sage: F  = [x^2 + x,  y^2 + y]

Next we will define the polynomial which will be reduced. ::

     sage: f = x^3* y^2


Now we will define the list of quotients and the remainder and initialize them to :math:`0`. ::

  sage: A =  [P(0) for  i in range(0,len(F)) ]
  sage: r  = P(0)

Now because we alter f through the algorithm we will create a copy of it so that we can keep the value of :math:`f` for later to verify the algorithm. ::

  sage: p = f


Now we are ready to define the main loop of our algorithm. ::

  while p != P(0):
      i = 0
      div_occurred = False
      while (i < len(F) and div_occurred == False):
	  print A,p,r
	  if does_divide(p.lm(), F[i]):
	      q = P(p.lm()/F[i].lm())
	      A[i] = A[i] + q
	      p = p - q*F[i]
	      div_occurred = True
	  else:
	      i = i + 1
      if div_occurred == False:
	  r = r + p.lm()
	  p = p - p.lm()

  print A, p, r



.. _fields:

Fields
=============

.. _number_fields:

.. index:: number fields

Number Fields
----------------

We  create a number field by specifying an irreducible polynomial and a name for the root of that polynomial.  We may use the indeterminate :math:`x`, which is already defined in sage.  We can also create a polynomial ring over the rationals and use the indeterminate for that polynomial ring. ::

   sage: P.<t> = PolynomialRing(QQ)
   sage: K.<a> = NumberField(t^3-2)
   sage: K
   Number Field in a with defining polynomial t^3 - 2
   sage: K.polynomial()
   t^3 - 2

A "random element" may be constructed producing an element with degree at most 2 (one less than the degree of the defining polynomial).
The options :meth:`num_bound` or :meth:`dem_bound` may be used to bound the numerator or denominator. ::

   sage: K.random_element()
   -5/14*a^2 + a - 3
   sage: K.random_element()
   -2*a
   sage: K.random_element(num_bound= 2)
   -a^2 + 1

Every irrational element will have a minimal polynomial of degree 3. ::

  sage: a.minpoly()
   x^3 - 2
   sage: (a^2-3*a).minpoly()
   x^3 + 18*x + 50


We can test isomorphism of fields. ::

   sage: K.<a>= NumberField(t^3-2)
   sage: L.<b> = NumberField(t^3-6*t-6)
   sage: K.is_isomorphic(L)
   True

The number of real embeddings and the number of pairs of complex embeddings are given by  the signature of the field.  The embeddings into the real field, :meth:`RR` , or complex field :meth:`CC`  may also be constructed. ::

    sage: K.signature()
    (1, 1)
    sage: K.real_embeddings()
    [
    Ring morphism:
      From: Number Field in a with defining polynomial t^3 - 2
      To:   Real Field with 53 bits of precision
      Defn: a |--> 1.25992104989487
    ]
    sage: K.complex_embeddings()
    [
    Ring morphism:
      From: Number Field in a with defining polynomial t^3 - 2
      To:   Complex Field with 53 bits of precision
      Defn: a |--> -0.629960524947437 - 1.09112363597172*I,
    Ring morphism:
      From: Number Field in a with defining polynomial t^3 - 2
      To:   Complex Field with 53 bits of precision
      Defn: a |--> -0.629960524947437 + 1.09112363597172*I,
    Ring morphism:
      From: Number Field in a with defining polynomial t^3 - 2
      To:   Complex Field with 53 bits of precision
      Defn: a |--> 1.25992104989487
    ]
    sage: phi1, phi2, phi3 = K.complex_embeddings()
    sage: phi1(a)
    -0.629960524947437 - 1.09112363597172*I
    sage: phi2(a)
    -0.629960524947437 + 1.09112363597172*I
    sage: phi3(a^2+3*a+5)
    10.3671642016528

The :meth:`Galois group` method computes the  Galois group of the Galois closure, not of the field itself.  When the Galois group is not cyclic, as in the second example, you need to name one of the generators.  The generators may also be accessed as shown below. ::

    sage: G = L.galois_group()
    sage: G.gens()
    [(1,2,3)]
    sage: H.<g>= K.galois_group()
    sage: H.gens()
    [(1,2)(3,4)(5,6), (1,4,6)(2,5,3)]
    sage: H.0
    (1,2)(3,4)(5,6)
    sage: H.1
    (1,4,6)(2,5,3)


The Galois closure of K. ::

    sage: L.<b> = K.galois_closure()
    sage: L
    Number Field in b with defining polynomial t^6 + 40*t^3 + 1372

Field Extensions
+++++++++++++++++

Now let's construct field extensions, which may be done in a few different ways.   The methods   :meth:`absolute_` refer to the prime field :math:`\mathbb{Q}`, while the methods :meth:`relative_`   refer to a field extension as constructed, which may be relative to some intermediate field. ::

    sage: P.<t> = PolynomialRing(QQ)
    sage: K.<a> = NumberField(t^3-2)
    sage: L.<b> = NumberField(t^3-a)
    sage: L.relative_degree(); L.relative_polynomial()
    3
    t^3 - a
    sage: L.base_field()
    Number Field in a with defining polynomial t^3 - 2
    sage: L.absolute_degree(); L.absolute_polynomial()
    9
    x^9 - 2
    sage: L.gens()
    (b, a)

We may also create the compositum of several fields defined by a list of polynomials over the rationals.  We must specify a root for each polynomial.
SageMath creates a sequence of 3 fields in the following example, starting at the far right in the list. ::

     sage: M.<a,b,c> = NumberField([t^3-2, t^2-3, t^3-5])
     sage: M
     Number Field in a with defining polynomial t^3 - 2 over its base field
     sage: M.relative_degree()
     3
     sage: M.absolute_degree()
     18
     sage: d = M.absolute_generator(); d
     a - b + c
     sage: d.minpoly()
     x^3 + (3*b - 3*c)*x^2 + (-6*c*b + 3*c^2 + 9)*x + (3*c^2 + 3)*b - 9*c - 7
     sage: d.absolute_minpoly()
     x^18 - 27*x^16 - 42*x^15 + 324*x^14 + 378*x^13 - 2073*x^12 + 1134*x^11 - 6588*x^10 - 23870*x^9 + 88695*x^8 + 79002*x^7 - 147369*x^6 - 1454922*x^5 + 431190*x^4 + 164892*x^3 + 2486700*x^2 - 1271592*x + 579268

The next example computes the Galois closure of :meth:`K`  and asks for the roots of unity.   The generator for :meth:`L` is something that sage computes, so it may have a complicated minimum polynomial, as we see.  We know that :meth:`L`  contains cube roots of unity, so let's verify it.  ::

    sage: K.<a> = NumberField(t^3-2)
    sage: L.<b> = K.galois_closure()
    sage: b.minpoly()
    x^6 + 40*x^3 + 1372
    sage: units= L.roots_of_unity(); units
    [1/36*b^3 + 19/18, 1/36*b^3 + 1/18, -1, -1/36*b^3 - 19/18, -1/36*b^3 - 1/18, 1]
    sage: len(units)
    6
    sage: [u^3 for u in units]
    [-1, 1, -1, 1, -1, 1]

Special Number Fields
++++++++++++++++++++++++++++++++

There are two classes of number fields with special properties that you can construct directly.  For a *quadratic field extension* simply specify a square free integer. ::

    sage: F.<a> = QuadraticField(17)
    sage: a^2
    17
    sage: (7*a-3).minpoly()
    x^2 + 6*x - 824

A *cyclotomic field* is created by indentifying its primitive root of unity.

CyclotomicField()

QuadraticField()



.. _finite_fields:

Finite Fields
-------------

.. index:: GF

In a prior section we constructed rings of integers modulo :math:`n`. We know that when :math:`n` is a prime number the *ring* :math:`\mathbb{Z}_{n}` is actually a *field*. SageMath will allow us to construct this same object as either a ring or a field. ::

  sage: R = Integers(7)
  sage: F7 = GF(7)
  sage: R, F7
  (Ring of integers modulo 7, Finite Field of size 7)

To take advantage of the extra stucture it is best to use the command :func:`GF` (or equivalently, :func:`FiniteField`) to construct this object.  As with modular rings we have to coerece integers into the field in order to do arithemetic in the field. ::

  sage: F7(4 + 3)
  0
  sage: F7(2*3)
  6
  sage: F7(3*7)
  0
  sage: F7(3/2)
  5

We can use SageMath to construct any *finite field*.  Recall that a finite field is always of order :math:`n = p^k` where :math:`p` is a prime number. To construct the field of order :math:`25 = 5^2` we input the following command. ::

  sage: F25.<a> = GF(25)

.. index:: polynomial, Field Extensions; generating polynomial

Recall that the finite field of order :math:`5^2` can be thought of a an *extension* of :math:`\mathbb{Z}_{5}` using a root of a polynomial of degree :math:`2`. The ``a`` that you specified is a root of this polynomial. There are different polynomials that can be used to construct this extension and SageMath chooses one for you. You can see the polynomial chosen by using the, aptly named, :meth:`polynomial` method. ::

  sage: p = F25.polynomial();
  sage: p
  a^2 + 4*a + 2

We can verify that ``a`` satisfies this polynomial. ::

  sage: a^2 + 4*a + 2
  0

It should be noted that ``a`` already lives in the field and no special coercion is necessary to do arithmetic using ``a``. ::

  sage: parent(a)
  Finite Field in a of size 5^2
  sage: a^2
  a + 3
  sage: a*(a^2 + 1)
  3

But if we are using only integers we must coerce the arithmetic into the field. ::

  sage: 3+4
  7
  sage: parent(3+4)
  Integer Ring
  sage: F25(3 + 4)
  2
  sage: parent(F25(3+4))
  Finite Field in a of size 5^2

.. index:: Field Extensions; modulus

Sometimes we would like to specify the polynomial used to construct out extension. to do so we just need to add the *modulus* option to our field constructor. ::

  sage: F25.<a> = GF(25, modulus=x^2 + x + 1)
  sage: a^2 + a + 1
  0
  sage: a^2
  4*a + 4

Remember that the modulus must be a polynomial which is *irreducible* over :math:`\mathbb{F}_{5}[x]`. Many times we would like for the modulus to not just be irreducible, but to be primitive_. Next we will construct all of the primitive polynomials of degree :math:`2`. The following example uses :ref:`polynomial_rings` and :ref:`list_comprehensions`. First thing that we will do is construct a list of all monic polynomials over :math:`\mathrm{GF}(5)` ::

  sage: F5 = GF(5)
  sage: P.<x> = PolynomialRing(F, 'x')
  sage: AP = [ a0 + a1*x + a2*x^2 for (a0,a1) in F^3]
  sage: AP
  [x^2, x^2 + 1, x^2 + 2, x^2 + 3, x^2 + 4, x^2 + x, x^2 + x + 1, x^2 + x + 2, x^2 + x + 3, x^2 + x + 4, x^2 + 2*x, x^2 + 2*x + 1, x^2 + 2*x + 2, x^2 + 2*x + 3, x^2 + 2*x + 4, x^2 + 3*x, x^2 + 3*x + 1, x^2 + 3*x + 2, x^2 + 3*x + 3, x^2 + 3*x + 4, x^2 + 4*x, x^2 + 4*x + 1, x^2 + 4*x + 2, x^2 + 4*x + 3, x^2 + 4*x + 4]

.. index:: is_primitive

Next we will *filter* out the primitive polynomials out of this list. ::

  sage: PR = [ p for p in AP if p.is_primitive() ]
  sage: PR
  [x^2 + x + 2, x^2 + 2*x + 3, x^2 + 3*x + 3, x^2 + 4*x + 2]

.. index:: is_irreducible

If we wanted all of the *irreducible* polynomials we would only change the last command slightly. ::

  sage: IR = [ p for p in AP if p.is_irreducible() ]
  sage: IR
  [x^2 + 2, x^2 + 3, x^2 + x + 1, x^2 + x + 2, x^2 + 2*x + 3, x^2 + 2*x + 4, x^2 + 3*x + 3, x^2 + 3*x + 4, x^2 + 4*x + 1, x^2 + 4*x + 2]

It should be noted that the above code will only work if the polynomials are over *finite* rings or fields.


**Exercises:**

#. Compute the list of all *primitive polynomials* of degree 3 over :math:`GF(5)`.
#. Compute the number of *primitive elements*  in :math:`GF(125)`.
#. Explain the relationship between the  number of primitive polynomials and the number of primitive elemens in the previous exercises.


.. _primitive: http://en.wikipedia.org/wiki/Primitive_polynomial_(field_theory)



.. _function_fields:

Function Fields
-----------------


.. index:: Coding Theory

.. _coding_theory:

Coding Theory
=============

.. index:: Linear Codes

.. _linear_codes:

Linear Codes
------------

A *linear code* is just a finite-dimensional vector space commonly defined over a finite field. To construct a linear code in SageMath we first define a finite field and a matrix over this field whose range will define this vector space. ::

  sage: F = GF(2)
  sage: G = matrix(F, [(0,1,0,1,0),(0,1,1,1,0),(0,0,1,0,1),(0,1,0,0,1)]); G
  [0 1 0 1 0]
  [0 1 1 1 0]
  [0 0 1 0 1]
  [0 1 0 0 1]

.. index:: LinearCode

The code itself is constructed by the :func:`LinearCode` command. ::

  sage: C = LinearCode(G); C
  Linear code of length 5, dimension 4 over Finite Field of size 2

.. index:: length, dimension, Linear Codes; length, Linear Codes; dimension

While the *length* and *dimension* of the code are displayed in the object's *description*, you can also obtain these properties at anytime using the code's :meth:`.length` and :meth:`.dimension` methods. ::

  sage: C.length()
  5
  sage: C.dimension()
  4

.. index:: hamming_weight, Coding Theory; hamming weight, Coding Theory; hamming distance

Given two code words, we can compute their *Hamming Weight* and *Distance* both by using the :func:`hamming_weight` function. ::

  sage: w1 = vector(F, (0,1,0,1,0)); w1
  (0, 1, 0, 1, 0)
  sage: hamming_weight(w1)
  2
  sage: w2 = vector(F, (0,1,1,0,1)); w2
  (0, 1, 1, 0, 1)
  sage: hamming_weight(w2)
  3
  sage: hamming_weight(w1 - w2)
  3

.. index:: minimum_distance, Coding Theory; minimum distance

The *minimum distance* of ``C`` can be computed by using the :meth:`.minimum_distance` method. ::

  sage: C.minimum_distance()
  1

.. index:: weight_distribution

SageMath can also compute the *distribution* of weights for the code. ::

  sage: C.weight_distribution()
  [1, 4, 6, 4, 1, 0]

Where the value listed at index ``i`` of the list, starting with zero and ending with the length of the code, is the number of codewords with that weight.

.. index:: weight_enumerator

Related to the weight distribution is the *weight enumerator* polynomial, which you compute using the code's :meth:`.weight_enumerator` method. ::

  sage: C.weight_enumerator()
  x^5 + 4*x^4*y + 6*x^3*y^2 + 4*x^2*y^3 + x*y^4

.. index:: gen_mat, check_mat, Coding Theory; generating matrix, Coding Theory; check matrix

The *generating* and *check* matrices are computed using the :meth:`gen_mat` and :meth:`check_mat` methods. ::

  sage: C.gen_mat()
  [0 1 0 1 0]
  [0 1 1 1 0]
  [0 0 1 0 1]
  [0 1 0 0 1]
  sage: C.check_mat()
  [1 0 0 0 0]

.. index:: gen_mat_systematic

The *systematic* form of the generating matrix is computed using :meth:`gen_mat_systematic`. ::

  sage: C.gen_mat_systematic()
  [0 1 0 0 0]
  [0 0 1 0 0]
  [0 0 0 1 0]
  [0 0 0 0 1]

.. index:: extended_code

SageMath can both *extend* and *puncture* our code. The *extended code* is computed as follows:  ::

  sage: Cx = C.extended_code(); Cx
  Linear code of length 6, dimension 4 over Finite Field of size 2
  sage: Cx.gen_mat()
  [0 1 0 1 0 0]
  [0 1 1 1 0 1]
  [0 0 1 0 1 0]
  [0 1 0 0 1 0]
  sage: Cx.check_mat()
  [1 0 0 0 0 0]
  [0 1 1 1 1 1]

.. index:: punctured

The *punctured* code is computed by supplying the code's :meth:`.punctured` method a list of coordinates in which to delete. The following commands construct the code that results when the 1st and 3rd coordinate from every code word in ``C`` are deleted. Note that unlike vectors, lists and matrices the 1st column is indexed by 1 and not 0 when puncturing a code. ::

  sage: Cp = C.punctured([1,3]); Cp
  Linear code of length 3, dimension 2 over Finite Field of size 2
  sage: Cp.gen_mat()
  [0 1 0]
  [0 0 1]
  sage: Cp.check_mat()
  [1 0 0]

.. index:: dual_code

SageMath can also compute the *dual* of ``C``. ::

  sage: Cd = C.dual_code(); Cd
  Linear code of length 5, dimension 1 over Finite Field of size 2
  sage: Cd.gen_mat()
  [1 0 0 0 0]
  sage: Cd.check_mat()
  [0 1 0 0 0]
  [0 0 1 0 0]
  [0 0 0 1 0]
  [0 0 0 0 1]

.. index:: decode

And finally SageMath can *decode* a received vector. The following simulates a communications channel; We begin with a code word, introduce an error and then correct this error by *decoding* the received message. ::

  sage: wrd = vector(F,(0,0,0,0,1))
  sage: err = vector(F,(0,0,1,0,0))
  sage: msg = wrd + err; msg
  (0, 0, 1, 0, 1)
  sage: C.decode(msg)
  (0, 0, 0, 0, 1)
  sage: C.decode(msg) == wrd
  True

It should be noted that since the above code has a minimum distance of only 1 that decoding will not always produce the code word that you may have expected.

These are only some of the commands that SageMath offers for computing and working with linear codes. There is much more information on the following web sites:

.. seealso::

   #. http://www.sagemath.org/doc/constructions/linear_codes.html
   #. http://www.sagemath.org/doc/reference/sage/coding/linear_code.html

.. index:: Cyclic Codes

.. _cyclic_codes:

Cyclic Codes
------------

To construct a cyclic code of length :math:`3` over :math:`\mathbb{F}_2` we first need a *generating polynomial*, which can be any *irreducible* factor of :math:`x^{3} - 1`. A list of irreducible factors is computed using the :func:`.factor` command.  ::

  sage: P.<x> = PolynomialRing(GF(2),'x')
  sage: factor(x^3 -1 )
  (x + 1) * (x^2 + x + 1)

.. index:: CyclicCode

The output above tells you that there are 2 choices for non-trivial generating polynomials. The following commands will construct the code generated by :math:`g(x) = x + 1`.  ::

  sage: g = x + 1
  sage: C = CyclicCode(3,g)
  sage: C.list()
  [(0, 0, 0), (1, 0, 1), (0, 1, 1), (1, 1, 0)]

Cyclic codes are a special type of linear code. So the commands that you worked with in the prior section all work in the same way. For example, the generating matrix is computed, in the usual and systematic forms, as follows:  ::

  sage: G = C.gen_mat(); G
  [1 1 0]
  [0 1 1]
  sage: Gs = C.gen_mat_systematic(); Gs
  [1 0 1]
  [0 1 1]

Just to verify that this is the generating matrix, and to practice working with matrices and vectors,  we will see if the image of :math:`G` spans the code. ::

  sage: vector(GF(2),[0,0])*G
  (0,0,0)
  sage: vector(GF(2),[1,0])*G
  (1, 1, 0)
  sage: vector(GF(2),[1,1])*G
  (1, 0, 1)
  sage: vector(GF(2),[0,1])*G
  (0, 1, 1)

SageMath can also compute a *parity check* matrix of :math:`C` using the code's :meth:`.check_mat` method. ::

      sage: H = C.check_mat()
      [1 1 1]

Verifying that ``H`` is a *check matrix* for :math:`C` is straightforward. ::

  sage: H*vector(GF(2),[0,1,1])
  (0)
  sage: H*vector(GF(2),[1,0,1])
  (0)
  sage: H*vector(GF(2),[1,0,0])
  (1)

You can also compute the *dual code* and it's generating and parity check matrices. ::

  sage: Cp = C.dual_code()
  sage: Cp.gen_mat()
  [1 1 1]
  sage: Cp.check_mat()
  [1 0 1]
  [0 1 1]


.. _mt_roots_of_unity:

Mini-Topic: Factoring :math:`x^n -1`
------------------------------------

The smallest field containing :math:`\mathbb{F}_{q}` and containing the roots of :math:`x^n - 1` is :math:`GF(q^t)` where :math:`t` is the order of :math:`q` in :math:`\mathbb{Z} \bmod{n}`.

The factors of :math:`x^n - 1` over :math:`\mathbb{F}_{q}` must all have degree dividing :math:`t`.

Let us begin by first defining :math:`n` and :math:`q` and constructing the ambient rings. ::

    sage: n = 19
    sage: q = 2
    sage: F = GF(2)
    sage: P.<x> = PolynomialRing(F, 'x')

.. index:: factor

Remembering that since we are constructing a finite field that :math:`q` has to either be prime or a prime power. Now let us compute all of the irreducable factors of :math:`x^{n} -1` over :math:`\mathbb{F}_{q}`. ::

    sage: A = factor(x^n-1); A

.. index:: multiplicative_order

Now to verify the facts about the degrees of the factors computed that was stated ealier. Compare the list above with the order of :math:`2` in :math:`\mathbb{Z}_{n}`. ::

    sage: Integers(19)(2).multiplicative_order()

Remembering that since :math:`\mathbb{Z}_{n}` is a ring, we have to specify which type of *order* we want to compute, either *additive* or *multiplicative*.


Now let us repeat what we just did, but this time letting :math:`q=2^2`. Changing `q` alone will not change the base field nor the polynomial ring. So we will have to re-construct everything using our new parameter. ::

    sage: q = 4
    sage: F.<a> = GF(4,'a')
    sage: P.<x> = PolynomialRing(F,'x')

Now let us factor :math:`x^n - 1` again. This time over a non-prime field. ::

      sage: A = factor(x^n-1); A
      (x + 1) * (x^9 + a*x^8 + a*x^6 + a*x^5 + (a + 1)*x^4 + (a + 1)*x^3 + (a + 1)*x + 1) * (x^9 + (a + 1)*x^8 + (a + 1)*x^6 + (a + 1)*x^5 + a*x^4 + a*x^3 + a*x + 1)


**Exercises:**


   #. Try repeating the above for :math:`F= \mathbb{F}_{8}`.
   #. Compute the order of 2, 4, 8 mod 19. What are your observations?
   #. Try other values of n and other fields.


.. index:: Idempotent Polynomials, Mini-Topic; Idempotent Polynomials

.. _cyclic_codes_idempotents:

Mini-Topic: Idempotent Polynomials
----------------------------------

We'll find the idempotent which is 1 modulo the ith factor of :math:`x^n -1`. Continuing with :math:`\mathbb{F}_{4}`. ::

      sage: F.<a> = GF(4, 'a')
      sage: P.<x> = PolynomialRing(F, 'x')

.. index:: quotient, factor

Then we will create the quotient ring. ::

     sage: R.<y> = P.quotient(x^19 - 1)
     sage: A = factor(x^19 - 1); A
     (x + 1) * (x^9 + a*x^8 + a*x^6 + a*x^5 + (a + 1)*x^4 + (a + 1)*x^3 + (a + 1)*x + 1) * (x^9 + (a + 1)*x^8 + (a + 1)*x^6 + (a + 1)*x^5 + a*x^4 + a*x^3 + a*x + 1)

Since the :func:`factor` command returns a list of polynomial factors and their multiplicities, which we do not need, we will strip those out. ::

      sage: A = [p[0] for p in A]

Now we will just select one of these factors. The reader should also try different factors for themselves. ::

    sage: p0 = A[2]

.. index:: prod

Now we take the product of all of the other factors. ::

    sage: ap = prod( [p for p in A if p != a])
    x^10 + (a + 1)*x^9 + a*x^8 + a*x^7 + x^5 + (a + 1)*x^3 + (a + 1)*x^2 + a*x + 1

.. index:: xgcd

Then compute the :func:`xgcd` of `p0` and `ap`. ::

     sage: d, s, t = xgcd(p0, ap)

You should recall that :math:`d = s \cdot p_0 + t* ap` is the extended gcd. You should check that :math:`s\cdot p_0 \equiv 1 \bmod{p}` for all :math:`p \neq p_0` and :math:`s\cdot p_0 \equiv 0 \bmod{p_0}` ::

    sage: s*p0 % A[1]
    1
    sage: s*p0 % A[2]
    0
    sage: s*p0 % A[0]
    1

Now check that :math:`t\cdot ap \equiv 0 \bmod{p}` for :math:`p \neq p_0` and :math:`t \cdot ap \equiv 1 \bmod{p_0}`. ::

    sage: t*ap % A[0]
    0
    sage: t*ap % A[1]
    0
    sage: t*ap % A[2]
    1

Now we will check that the polynomial that we computed is an idempotent in :math:`F\left[x\right]/\left<x^n - 1 \right>`. ::

    sage: f = R(bp*ap)
    sage: f^2 == f
    True

.. index:: gcd

Check the generating polynomial. ::

      sage: gcd(b*p0, x^19-1)
      x^9 + (a + 1)*x^8 + (a + 1)*x^6 + (a + 1)*x^5 + a*x^4 + a*x^3 + a*x + 1
      sage: p0
      x^9 + (a + 1)*x^8 + (a + 1)*x^6 + (a + 1)*x^5 + a*x^4 + a*x^3 + a*x + 1

**Exercises:**

	#. Find the idempoent element of :math:`F\left[x\right]/\left<x^n -1\right>` For :math:`q = 4` and :math:`n =3, 5, 11` and :math:`17`.

For the reciprocal polynomials of idempotents, see Theorem 5 [MacWilliams1977]_ p. 219

.. [MacWilliams1977] MacWilliams, F. J. and Sloane, N. J. A., *The theory of error-correcting codes.* North-Holland Publishing Co. 1977


Other Codes
-----------

.. index:: Hamming Codes

.. _hamming_codes:

Hamming Codes
+++++++++++++

A Hamming Code is a simple linear code which has the capability to detect up to 2 contiguous errors and correct for any single error.

.. index:: HammingCode

We will begin by constructing a binary Hamming code with 3 parity checks. ::

  sage: F = GF(2)
  sage: C = HammingCode(3,F); C
  Linear code of length 7, dimension 4 over Finite Field of size 2

Hamming codes always have a length, :math:`\vert \mathbb{F} \vert^r - 1` where :math:`r` is the number of parity checks and :math:`\mathbb{F}` is the finite-field over which the code is defined. This is because the columns of it's *parity check* matrix consists of all non-zero elements of :math:`\mathbb{F}^r`. ::

  sage: C.check_mat()
  [1 0 1 0 1 0 1]
  [0 1 1 0 0 1 1]
  [0 0 0 1 1 1 1]

A Ternary Hamming Code is constructed by supplying a non-binary finite field as the base field. Here we will construct the ternary Hamming code over :math:`GF(2^3)` also with 3 parity checks. ::

  sage: C = HammingCode(3, F); C
  Linear code of length 73, dimension 70 over Finite Field in a of size 2^3

.. seealso::
   http://en.wikipedia.org/wiki/Hamming_code

.. index:: BCH Codes

.. _bch_codes:

BCH Codes
+++++++++

BCH codes, or Bose-Chaudhuri-Hockenghem codes, are a special class of the cyclic codes with 3 required parameters, :math:`n, \delta, F` and one optional one :math:`b`. Here :math:`n` is the length of the code words, :math:`\delta` is a parameter called the *designed distance* and :math:`F` is a finite field of order :math:`q^{n}` where :math:`gcd(n, q) = 1`.

.. index:: BCHCode

If :math:`b` is not provided then a default value of zero is used. For example, you construct construct a BCH code of length :math:`n = 13` with :math:`\delta = 5` over :math:`F = \mathrm{GF}(9)`. ::

  sage: F.<a> = GF(3^2,'a')
  sage: C = BCHCode(13, 5, F)
  sage: C
  Linear code of length 13, dimension 6 over Finite Field in a of size 3^2

We can compute the code's minimum distance using it's :meth:`.minimum_distance` method. ::

  sage: C.minimum_distance()
  6

Since BCH codes are also linear, you can use SageMath to compute the code's generating and check matrices. ::

  sage: C.gen_mat()
  [2 2 1 2 0 0 1 1 0 0 0 0 0]
  [0 2 2 1 2 0 0 1 1 0 0 0 0]
  [0 0 2 2 1 2 0 0 1 1 0 0 0]
  [0 0 0 2 2 1 2 0 0 1 1 0 0]
  [0 0 0 0 2 2 1 2 0 0 1 1 0]
  [0 0 0 0 0 2 2 1 2 0 0 1 1]
  sage: C.check_mat()
  [1 0 0 0 0 0 0 1 2 1 2 2 2]
  [0 1 0 0 0 0 0 1 0 0 0 1 1]
  [0 0 1 0 0 0 0 2 2 2 1 1 2]
  [0 0 0 1 0 0 0 1 1 0 1 0 0]
  [0 0 0 0 1 0 0 0 1 1 0 1 0]
  [0 0 0 0 0 1 0 0 0 1 1 0 1]
  [0 0 0 0 0 0 1 2 1 2 2 2 1]

We can also compute it's *dual* code. ::

  sage: Cp = C.dual_code(); Cp
  Linear code of length 13, dimension 7 over Finite Field in a of size 3^2
  sage: Cp.gen_mat()
  [1 0 0 0 0 0 0 1 2 1 2 2 2]
  [0 1 0 0 0 0 0 1 0 0 0 1 1]
  [0 0 1 0 0 0 0 2 2 2 1 1 2]
  [0 0 0 1 0 0 0 1 1 0 1 0 0]
  [0 0 0 0 1 0 0 0 1 1 0 1 0]
  [0 0 0 0 0 1 0 0 0 1 1 0 1]
  [0 0 0 0 0 0 1 2 1 2 2 2 1]
  sage: Cp.check_mat()
  [1 0 0 0 0 0 2 2 1 2 0 0 1]
  [0 1 0 0 0 0 1 0 1 2 2 0 2]
  [0 0 1 0 0 0 2 0 1 0 2 2 1]
  [0 0 0 1 0 0 1 0 2 2 0 2 1]
  [0 0 0 0 1 0 1 2 2 0 2 0 1]
  [0 0 0 0 0 1 1 2 1 0 0 2 2]



.. seealso::
   http://en.wikipedia.org/wiki/BCH_code
