.. _mathematical_structures:

******************************************
 Mathematical Structures
******************************************

.. _integers_modular_arithmetic:

Integers and Modular Arithmetic
===============================

.. _euclidean_algorithm:

Mini-Topic: Euclidean Algorithm
-------------------------------

    You should be familiar with :ref:`division_and_factoring`, :ref:`variables`, :ref:`external_files_and_sessions`, and :ref:`while_loops`

Recall that for :math:`a,b \in \mathbb{Z}` with :math:`b \neq 0`, there always exists unique :math:`q,r \in \mathbb{Z}` such that :math:`a=bq+r` with :math:`0 \leq r< b`. With that in mind, we will use Sage to calculate the *gcd* of two integers using the *Euclidean Algorithm*. The following code is an implementation of the Euclidean Algorithm in Sage.  

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

    #. Revise the loop in the ``euclid.sage`` so that only the gcd and the total number of divisions (i.e. the number of steps through the algorithm) are printed. Compare the speed of this version of the algorithm with the built-in Sage function :func:`.gcd` by using both functions on large integers.

    #. Write your own *Extended Euclidean Algorithm* by revising the loop in ``euclid.sage``. 


.. _integers_modulo_n:

Integers Modulo :math:`n`
-------------------------

    You should be familiar with :ref:`universes_and_coercion` and :ref:`variables`

In this section we cover how to construct :math:`\mathbb{Z}_{n}` and do some basic computations. 


To construct this ring, you use the :class:`.Integers` command. ::

  sage: Integers(7)
  Ring of integers modulo 7
  sage: Integers(100)
  Ring of integers modulo 100
				
We could do computations modulo an integer by repeatedly using the ``%`` operator in all of our expressions, but by constructing the ring explicitly we have access to a more natural method for doing arithmetic. ::

  sage: R=Integers(13)
  sage: a=R(6)
  sage: b=R(5)
  sage: a + b
  11
  sage: a*b
  4

And by explicitly coercing our numbers into the ring :math:`\mathbb{Z}_{n}` we can compute some of the mathematical properties of the elements. Like their order, both multiplicative and additive, and whether or not the element is a unit. ::

  sage: a.additive_order()
  13
  sage: a.multiplicative_order()
  12
  sage: a.is_unit()
  True

If the element is a unit, the *inverses* of this element are computed naturally, using ``-a`` and ``a^(-1)``::

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
division, Sage will complain ::

  sage: R(5/4)
  ...
  ZeroDivisionError: Inverse does not exist.
				
We have to be a little bit careful when we are doing this since we are asking Sage to coerce a rational number into the :math:`\mathbb{Z}_{24}` This may cause some unexpected consequences since some reduction is done on rational numbers before the coercion. For an example, consider the following: ::
  sage: R(20).is_unit()
  False
  sage: R(16/20)
  20
				
:math:`20` is not a unit, yet at first glance it would seem we divided by it in :math:`\mathbb{Z}_{24}`. However, note the order of operations. First sage reduces :math:`16/20` to  :math:`4/5`, and then coerces :math:`4/5` into :math:`\mathbb{Z}_{24}`. Since :math:`5` is a unit in :math:`\mathbb{Z}_{24}`, everything works out ok; however, that may have not been what we intended by the coercion.  

We can also compute some properties of the ring itself. ::

  sage: R
  Ring of integers modulo 13
  sage: R.order()
  13
  sage: R.is_ring()
  True
  sage: R.is_integral_domain()
  True
  sage: R.is_field()
  True

and if the ring is finite then we can have sage list all of it's elements. ::
  sage: R.list()
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

``R`` in this example is a field, since :math:`13` is a prime number, if our ring is not a field then the group of *units* is an subgroup of :math:`\left(\mathbb{Z}_{n}, \cdot \right)` of interest. Sage can compute a list of generators of the *group of units* using it's :meth:`unit_gens` method. ::

  sage: R = Integers(12)
  sage: R.uni
  R.unit_gens            R.unit_group_order     
  R.unit_group_exponent  R.unit_ideal           
  sage: R.unit_gens()
  [7, 5]

We can also compute the order of this subgroup. ::

  sage: R.unit_group_order()
  4

Unfortunately, Sage doesn't seem to have a function which directly computes the group of units for integer modulo :math:`m`, but using the information above we can do that ourselves without much trouble. ::

  sage: (a,b) = R.unit_gens()
  sage: a
  7
  sage: b
  5
  sage: [ (a^i)*(b^j) for i in range(2) for j in range(2) ] 
  [1, 5, 7, 11]

We can compute this list also by using a list comprehension. ::

  sage: [ x for x in R if x.is_unit()]
  [1, 5, 7, 11]

**Exercises:**

  #. Construct the ring of integers modulo :math:`16` and compute the following:
     a) Compute the multiplicative orders of :math:`2,4,5,6,13` and `15`?
     b) Which of the elements listed above is a unit? 
     c) What are the generators for the group of units? 
     d) Compute a list of all of the elements in the group of units.

  #. Do all of the steps above again, but with the ring of integers modulo :math:`17`.

  #. Use Sage to determine whether the following Rings are fields:

     a) :math:`\mathbb{Z}_{1091}`
     b) :math:`\mathbb{Z}_{1047}`
     c) :math:`\mathbb{Z}_{1037}`
     d) :math:`\mathbb{Z}_{1087}`

  #. Use an exhaustive search method to write a function which determines if a is a unit modulo n.

  #. For :math:`n = 13, 15` and :math:`21` determine which of :math:`3,4` and :math:`5` are units in :math:`\mathbb{Z}_{n}`. When you find a unit, determine its inverse and compare this to the output of :math:`xgcd(a,n)`. Try and explain this relationship.
 
.. _linear_congruences:

Linear Congruences
------------------

    You should be familiar with :ref:`integers_modulo_n` and :ref:`list_comprehensions`

A linear congruence is an equation of the form :math:`ax=b` in :math:`\mathbb{Z}_{n}`. One way to see if there is a solution to such a problem is an exhaustive search. For example, to determine if there exists a solution to :math:`9x = 6` we can do the following: ::

  sage: R=Integers(21)
  sage: a=R(9)
  sage: 6 in [ a*x for x in R ]
  True
				
Notice that the above tells us only that there exists at least one solution to the equation :math:`9x= 6` in :math:`\mathbb{Z}_{21}`. We can construct the list of these solutions by using the following list comprehension. ::

  sage: [ x for x in R if R(9)*x == R(6)]
  [3, 10, 17]

We can also determine when a solution does not exist in a similar fashion. ::
  sage: [ x for x in R if R(9)*x == R(2) ]
  []

We can also use the :func:`solve_mod` function to compute the same results. ::

  sage: solve_mod( 9*x == 6, 21)
  [(3,), (10,), (17,)]
  sage: solve_mod( 9*x == 2, 21)
  []

:func:`solve_mod` can handle linear congruences of more than one variable. ::

  sage: solve_mod( 9*x + 7*y == 2, 21)
  [(15, 14), (15, 8), (15, 2), (15, 17), (15, 11), (15, 5), (15, 20), (1, 14), (1, 8), (1, 2), (1, 17), (1, 11), (1, 5), (1, 20), (8, 14), (8, 8), (8, 2), (8, 17), (8, 11), (8, 5), (8, 20)]

Where the solution of the form :math:`\left(x,y\right)` where the variables are listed in alphabetical order. 

:func:`solve_mod` can even solve systems of linear congruences. ::

  sage: solve_mod( [9*x + 2*y == 2, 3*x + 2*y == 11   ], 21)
  [(9, 13), (16, 13), (2, 13)]
 
       
**Exercises:**

  #. Find all solutions to the following congruences over :math:`\mathbb{Z}_{42}`.
     a) :math:`41x = 2`
     b) :math:`5x = 13`
     c) :math:`6x = 0`
     c) :math:`6x = 12`
     d) :math:`6x = 18`
     e) :math:`37x = 21`

  #. Above you computed the solution sets for the congruences :math:`6x =0`, :math:`6x = 12` and ':math:`6x = 18`. What are the similarities? What are the differences? Can you use these results to say something in general about the structure of the set :math:`\left\{ 6x \ \vert\ x \in \mathbb{Z}_{42} \right\}`?

  #. Use the :func:`solve_mod` command find all of the solutions to the following congruences modulo :math:`36`:
     a) :math:`3x = 21`
     b) :math:`7x = 13`
     c) :math:`23x = 32`
     d) :math:`8x = 14`

.. _groups:

Groups
======

.. _permutation_groups:

Permutation Groups
------------------
.. sectionauthor:: David Monarres <dmmonarres@gmail.com>

In Sage a permutation is given in *cycle* notation, however since
parenthesis have another meaning to Python we must enclose our cycles
in quotations before we use them. ::

	sage: r = '(1,3)(2,4)(5)'
	sage: s = '(1,3,2)'

Constructing a permutation group is done by giving a list of these
permutation to the :class:`.PermutationGroup` command. ::

        sage: G = PermutationGroup([r,s])
	sage: G
	Permutation Group with generators [(1,3,2), (1,3)(2,4)]

First we will construct the symmetric group on :math:`\{ 1, 2, 3, 4 ,
5 \}` which is done by using the :class:`.SymmetricGroup` command.  ::
 
        sage: G = SymmetricGroup(5) 
        sage: G Symmetric group of order 5! as a permutation group

Once the group has been constructed we can list all of it's
:math:`5!` members. ::

        sage: G.list()
    	[(), (4,5), (3,4), (3,4,5), (3,5,4), (3,5), (2,3), (2,3)(4,5), (2,3,4), (2,3,4,5), (2,3,5,4), (2,3,5), (2,4,3), (2,4,5,3), (2,4), (2,4,5), (2,4)(3,5), (2,4,3,5), (2,5,4,3), (2,5,3), (2,5,4), (2,5), (2,5,3,4), (2,5)(3,4), (1,2), (1,2)(4,5), (1,2)(3,4), (1,2)(3,4,5), (1,2)(3,5,4), (1,2)(3,5), (1,2,3), (1,2,3)(4,5), (1,2,3,4), (1,2,3,4,5), (1,2,3,5,4), (1,2,3,5), (1,2,4,3), (1,2,4,5,3), (1,2,4), (1,2,4,5), (1,2,4)(3,5), (1,2,4,3,5), (1,2,5,4,3), (1,2,5,3), (1,2,5,4), (1,2,5), (1,2,5,3,4), (1,2,5)(3,4), (1,3,2), (1,3,2)(4,5), (1,3,4,2), (1,3,4,5,2), (1,3,5,4,2), (1,3,5,2), (1,3), (1,3)(4,5), (1,3,4), (1,3,4,5), (1,3,5,4), (1,3,5), (1,3)(2,4), (1,3)(2,4,5), (1,3,2,4), (1,3,2,4,5), (1,3,5,2,4), (1,3,5)(2,4), (1,3)(2,5,4), (1,3)(2,5), (1,3,2,5,4), (1,3,2,5), (1,3,4)(2,5), (1,3,4,2,5), (1,4,3,2), (1,4,5,3,2), (1,4,2), (1,4,5,2), (1,4,2)(3,5), (1,4,3,5,2), (1,4,3), (1,4,5,3), (1,4), (1,4,5), (1,4)(3,5), (1,4,3,5), (1,4,2,3), (1,4,5,2,3), (1,4)(2,3), (1,4,5)(2,3), (1,4)(2,3,5), (1,4,2,3,5), (1,4,2,5,3), (1,4,3)(2,5), (1,4)(2,5,3), (1,4,3,2,5), (1,4)(2,5), (1,4,2,5), (1,5,4,3,2), (1,5,3,2), (1,5,4,2), (1,5,2), (1,5,3,4,2), (1,5,2)(3,4), (1,5,4,3), (1,5,3), (1,5,4), (1,5), (1,5,3,4), (1,5)(3,4), (1,5,4,2,3), (1,5,2,3), (1,5,4)(2,3), (1,5)(2,3), (1,5,2,3,4), (1,5)(2,3,4), (1,5,3)(2,4), (1,5,2,4,3), (1,5,3,2,4), (1,5)(2,4,3), (1,5,2,4), (1,5)(2,4)]

We construct some elements in :math:`S_5` by coercing the
permutations, written in *cycle notation*, into the group constructed
earlier.  ::

        sage: r = G('(1,3)(2,4)')  
	sage: s = G('(1,4,3,2)')
	sage: t = G('(1,3,2)') 

The product of cycles are taken from *left-to-right* and are, of
course, not commutative. ::

        sage: s*t    
	(1,4,2,3)
	sage: t*s
	(1,2,4,3)

We can compute the order of an element by using the object's
:meth:`order` method and check this manually. Note that the empty
parenthesis `()` is used to represent the identity permutation. ::

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

You can construct the subgroup generated by a list of elements by
using the :meth:`subgroup` method. ::

        sage: H = G.subgroup([r,s])
	sage: H
	Subgroup of SymmetricGroup(5) generated by [(1,3)(2,4), (1,4,3,2)]
	sage: H.list()
	[(), (1,2,3,4), (1,3)(2,4), (1,4,3,2)]

We can test to see if the subgroup that we have just created has
certain properties by using the appropriate methods. ::

        sage: H.is_abelian()
	True
	sage: H.is_cyclic()
	True
	sage: H.gens()      
	[(1,3)(2,4), (1,4,3,2)]
	sage: H.gens_small()
	[(1,4,3,2)]

Next we will construct a different subgroup of :math:`S_5` and list
it's members. This subgroup may look familiar if you have studied
group theory before.  ::

        sage: r = G('(1,2,5,4,3)') 
	sage: s = G('(1,5),(3,4)') 
	sage: H = G.subgroup([r,s])
	sage: H
	Subgroup of SymmetricGroup(5) generated by [(1,2,5,4,3), (1,5)(3,4)]
	sage: H.list()
	[(), (2,3)(4,5), (1,2)(3,5), (1,2,5,4,3), (1,3,4,5,2), (1,3)(2,4), (1,4,2,3,5), (1,4)(2,5), (1,5)(3,4), (1,5,3,2,4)]
	sage: H.order()
	10

The subgroup that we have constructed is the *Dihedral Group* . You
can construct this group directly by using the :class:`DihedralGroup()`
function. You can also test whether or not these two groups are
isomorphic. ::

        sage: D = DihedralGroup(5)
	sage: D
	Dihedral group of order 10 as a permutation group
	sage: D.list()
	[(), (2,5)(3,4), (1,2)(3,5), (1,2,3,4,5), (1,3)(4,5), (1,3,5,2,4), (1,4)(2,3), (1,4,2,5,3), (1,5,4,3,2), (1,5)(2,4)]
	sage: H.is_isomorphic(D)
	True

Often when we have two groups which are isomorphic we will want to
compute a concrete isomorphism between the two groups. A useful tool
for examining the structure is by examining the groups *Cayley
Table*. You can do this by invoking the group's :meth:`cayley_table()`
method. ::

        sage: H.cayley_table()
	*  a b c d e f g h i j
	+--------------------
	a| a b c d e f g h i j
	b| b a d c f e h g j i
	c| c e a i b g f j d h
	d| d f b j a h e i c g
	e| e c i a g b j f h d
	f| f d j b h a i e g c
	g| g i h e j c d b f a
	h| h j g f i d c a e b
	i| i g e h c j b d a f
	j| j h f g d i a c b e

	sage: D.cayley_table()
	*  a b c d e f g h i j
	+--------------------
	a| a b c d e f g h i j
	b| b a d c f e h g j i
	c| c i a e d g f j b h
	d| d j b f c h e i a g
	e| e h i g a j d b c f
	f| f g j h b i c a d e
	g| g f h j i b a c e d
	h| h e g i j a b d f c
	i| i c e a g d j f h b
	j| j d f b h c i e g a
		    
Now, the way that Sage displays the group's cayley table may be a bit
confusing. Instead of listing the elements themselves, Sage decides to
encode the results alphabetically using the same ordering as the
output of ``H.list()`` and ``D.list()``. In this example the encoding
summarized in the following table.

.. table:: Example encoding for `cayley_table()`


        ========== =============== ===============
        Letter      H.list()        D.list()
        ========== =============== ===============
  	a          ()              ()

	b          (2,3)(4,5)      (2,5)(3,4)

	c          (1,2)(3,5)      (1,2)(3,5)

	d          (1,2,5,4,3)     (1,2,3,4,5)

	e          (1,3,4,5,2)     (1,3)(4,5)

	f          (1,3)(2,4)      (1,3,5,2,4)

	g          (1,4,2,3,5)     (1,4)(2,3)

	h          (1,4)(2,5)      (1,4,2,5,3)

	i          (1,5)(3,4)      (1,5,4,3,2)

	j          (1,5,3,2,4)     (1,5)(2,4)

	========== =============== ===============

Computing the sign of a permutation can be done with the object's
:meth:`sign` method. ::

        sage: G('(2,3,4)').sign() 
	1
	sage: G('(4,5)').sign()   
	-1

The collection of all even permutations, permutations with positive
sign, is a subgroup of :math:`S_5` called the *Alternating Group*. We
can construct this subgroup directly using the :class:`AlternatingGroup`
command. ::

        sage: H = AlternatingGroup(5)
	sage: H
	Alternating group of order 5!/2 as a permutation group

Since the alternating group is a subgroup of :math:`S_5` we can test
for element membership by using the ``in`` conditional. ::

        sage: G('(2,3,4)') in H
	True
	sage: G('(4,5)') in H  
	False

More properties of the alternating group can be tested and each of
it's elements listed. ::

        sage: H.is_subgroup(G)
	True
	sage: H.is_normal(G)  
	True
	sage: H.list()
	[(), (3,4,5), (3,5,4), (2,3)(4,5), (2,3,4), (2,3,5), (2,4,3),
	(2,4,5), (2,4)(3,5), (2,5,3), (2,5,4), (2,5)(3,4), (1,2)(4,5),
	(1,2)(3,4), (1,2)(3,5), (1,2,3), (1,2,3,4,5), (1,2,3,5,4),
	(1,2,4,5,3), (1,2,4), (1,2,4,3,5), (1,2,5,4,3), (1,2,5),
	(1,2,5,3,4), (1,3,2), (1,3,4,5,2), (1,3,5,4,2), (1,3)(4,5),
	(1,3,4), (1,3,5), (1,3)(2,4), (1,3,2,4,5), (1,3,5,2,4),
	(1,3)(2,5), (1,3,2,5,4), (1,3,4,2,5), (1,4,5,3,2), (1,4,2),
	(1,4,3,5,2), (1,4,3), (1,4,5), (1,4)(3,5), (1,4,5,2,3),
	(1,4)(2,3), (1,4,2,3,5), (1,4,2,5,3), (1,4,3,2,5), (1,4)(2,5),
	(1,5,4,3,2), (1,5,2), (1,5,3,4,2), (1,5,3), (1,5,4),
	(1,5)(3,4), (1,5,4,2,3), (1,5)(2,3), (1,5,2,3,4), (1,5,2,4,3),
	(1,5,3,2,4), (1,5)(2,4)]

By using python's *list comprehensions* (see :ref:`lists`) we can
create a list of elements with certain properties. In this case we can
construct the list of all transpositions. ::

        sage: T = [s for s in G  if s.order() == 2 ] 
	sage: T
	[(4,5), (3,4), (3,5), (2,3), (2,3)(4,5), (2,4), (2,4)(3,5), (2,5), (2,5)(3,4), (1,2), (1,2)(4,5), (1,2)(3,4), (1,2)(3,5), (1,3), (1,3)(4,5), (1,3)(2,4), (1,3)(2,5), (1,4), (1,4)(3,5), (1,4)(2,3), (1,4)(2,5), (1,5), (1,5)(3,4), (1,5)(2,3), (1,5)(2,4)]

Sage also contains functions which allow for us to construct the
*Cyclic Permutation* and *Klein Four Group*. Note that the order of
the Klein Four Group need not to be specified. ::

        sage: C = CyclicPermutationGroup(10)
	sage: C
	Cyclic group of order 10 as a permutation group
	sage: K = KleinFourGroup()
	sage: K
	The Klein 4 group of order 4, as a permutation group
		    
.. seealso::
        `Group Theory and Sage: A Primer
        <http://buzzard.ups.edu/sage/sage-group-theory-primer.pdf>`_
        by Rob Beezer

.. _group_homomorphisms:

Permutation Group Homomorphisms
-------------------------------

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

A homomorphism between these is constructed by listing an association between the **generators** of one group to the generators of the other. To see these we will use the :meth:`.gens()` method provided by our groups ::

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

Note that we get the, rather unhelpful in this case, :exc:`AttributeError` because the permutation :math:`(1,5)` is not in the domain of this function. 

The homomorphism also comes equipped with a few useful methods, the most useful is the :meth:`.kernel` method, which yields the kernel of the homomorphism. Which, since this homomorphism is an injection is just the trivial group. ::

	sage: phi.kernel()
	Permutation Group with generators [()]



.. _linear_algebra:

Linear Algebra
==============

.. _vectors_and_matrices:

Vectors and Matrices
--------------------

To create a vector use the :func:`vector` command with a list of
entries. Scalar multiples and the dot product are straightforward to
compute. As with lists, vectors are indexed starting from :math:`0`. ::

	sage: v= vector([1,2,3,4])
        sage: 7*v
	(7, 14, 21, 28)
	sage: v*v
	30
	sage: v[0]
	1
	sage: v[4]
	ERROR: An unexpected error occurred while tokenizing input
				

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

By default, Sage constructs the matrix over the smallest universe which contains the coordinates. ::
 
  sage: parent(matrix(2,[1,2,3,4]))
  Full MatrixSpace of 2 by 2 dense matrices over Integer Ring
  sage: parent(matrix(2,[1,2/1,3,4]))
  Full MatrixSpace of 2 by 2 dense matrices over Rational Field
  sage: parent(matrix(2, [x,y,z,t]))
  Full MatrixSpace of 2 by 2 dense matrices over Symbolic Ring
			
We can specify the universe for the coordinates of our matrix by giving it as an optional argument. ::

	sage: matrix(QQ,2,[1.1,1.2,1.3,1.4])
	[11/10   6/5]
	[13/10   7/5]
				
There are shortcuts in Sage to construct some of the more commonly used matrices. To construct the identity matrix we use the :func:`identity_matrix` function. ::

	sage: identity_matrix(3)
	[1 0 0]
	[0 1 0]
	[0 0 1]
				
To construct the zero matrix we may use :func:`zero_matrix` or the
regular matrix function with no list inputted. ::

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

  #. Use Sage to construct the vector :math:`v = \left(4, 10, 17, 28, 2 \right)`
  #. Construct the following matrix over the rational numbers in Sage.  

     .. math::
	\left(\begin{array}{ccc}
	5 & 3 & 2 \\
	4 & 7 & 10 \\
	2 & 11 & 1 \end{array}\right)

  #. Construct a 10x10 identity matrix. 
  #. Construct a 20x10 zero matrix.


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

We can compute the *inverse* of a matrix by raising it to the :math:`-1`-th power. ::

	sage: A^-1
	[ 1 -1]
	[ 0  1]
				
If the matrix is not invertible Sage will complain about a :class:`ZeroDivisionError`. ::

  sage: A = matrix([[4,2],[8,4]])
  sage: A^-1
  ---------------------------------------------------------------------------
  ZeroDivisionError                         Traceback (most recent call last)
  ... (Long error message)
  ZeroDivisionError: input matrix must be nonsingular

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
				
We use the :meth:`det` method to calculate the *determinant* of a square matrix. ::

  sage: A= matrix([[-1/2,0,-1],[0,-2,2],[1,0,-1/2]]); A
  [-1/2    0   -1]
  [   0   -2    2]
  [   1    0 -1/2]
  sage: A.det()
  -5/2
				
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

In this example, Sage assumes that the matrix ``B`` is defined over the integers and not the rationals, where it does not have an inverse. But if we define ``B`` as a matrix over the rationals, we obtain different results. ::

  sage: B = matrix(QQ, 2,[1,2,3,4])
  sage: B
  [1 2]
  [3 4]       
  sage: B.is_invertible()
  True

If we ask Sage to compute the inverse of a matrix over the integers it will automatically coerce ``B`` into a matrix over the rationals if necessary. ::
  
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

Matrix Manipulation
-------------------

    You should be familiar with :ref:`vectors_and_matrices` and :ref:`matrix_arithmetic`. 

In this section we will cover some of the commands that we can use to *manipulate* matrices. Let's begin by defining the a matrix over the rational numbers. ::

  sage: M = matrix(QQ, [[1,2,3],[4,5,6],[7,8,9]]); M
  [1 2 3]
  [4 5 6]
  [7 8 9]

To get a list of row and column vectors, we use the :meth:`rows` and :meth:`columns` methods. ::

   sage: M.rows()
   [(1, 2, 3), (4, 5, 6), (7, 8, 9)]
   sage: M.columns()
   [(1, 4, 7), (2, 5, 8), (3, 6, 9)]

If we want only one row or column vector then we use the singular with the number row and or column as its argument. You should recall that Sage follows Python's convention and all of the indicies begin with zero. ::

   sage: M.row(0)
   (1, 2, 3)
   sage: M.row(2)
   (7, 8, 9)
   sage: M.column(1) 	
   (2, 5, 8)
   sage: M.column(2)
   (3, 6, 9)

You can even get a list of the diagonal entries, by calling the :meth:`diagonal` method. ::

   sage: M.diagonal()
   [1, 5, 9]


Sage also allows us to contruct new matrices from the row and/or column vectors. ::

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

We can add a multiple of a row or column to another row or column by using the :meth:`add_multiple_of_row` method. The first command takes :math:`-4` times the first row and adds it to the second row. Once again it helps to remember that everything with a matrices in Sage are index starting with zero. So `0` below is refering to the first row and `1` to the second. We can all blame the C programming language for this confusion.  ::
   
   sage: M.add_multiple_of_row(1,0,-4); M
   [ 1  2 -1]
   [ 0 -3  2]
   [ 7  8 -3]
   sage: M.add_multiple_of_row(2,0,-7); M 
   [ 1  2 -1]
   [ 0 -3  2]
   [ 0 -6  4]

The same can be done with the column vectors, which are also zero indexed. ::

   sage: M.add_multiple_of_column(1,0,-2);M
   [ 1  0 -1]
   [ 0 -3  2]
   [ 0 -6  4]
   sage: M.add_multiple_of_column(2,0,1);M
   [ 1  0  0]
   [ 0 -3  2]
   [ 0 -6  4]


If we don't like the ordering of our rows or colums we can swap them in place.  ::

   sage: M.swap_rows(1,0); M
   [ 0 -3  2]
   [ 1  0  0]
   [ 0 -6  4]
   sage: M.swap_columns(0,2); M
   [ 2 -3  0]
   [ 0  0  1]
   [ 4 -6  0]


If we want to change a row or column of `M` then we use the :meth:`set_column` or :meth:`set_row` methods. ::

   sage: M.set_column(0,[1,2,3]);M
   [ 1 -3  0]
   [ 2  0  1]
   [ 3 -6  0]
   sage: M.set_row(0,[1,2,5]);M
   [ 1  2  5]
   [ 2  0  1]
   [ 3 -6  0]

And finally if we want to change a whole "block" of a matrix, we use the :meth:`set_block` method with the coordinates of where we want the upper right corner of the block to begin. ::

   sage: B = matrix(QQ,[ [1,0 ],[0,1]]); B
   [1 0]
   [0 1] 
   sage: M.set_block(1,1,B); M
   [1 2 5]
   [2 1 0]
   [3 0 1]


Of course, if all we want is the *echelon form* of the matrix we can use either the :meth:`echelon_form` or :meth:`echelonize` methods. The difference between the two is the former returns a copy of the matrix in echelon form without changing the original matrix and the latter alters the matrix itself. ::

   sage: M.echelon_form()
   [1 0 0]
   [0 1 0]
   [0 0 1]
   
   sage: M.echelonize(); M
   [ 1  0  0]
   [ 0  1  0]
   [ 0  0  1]


Next we would like to use the *augmented* metrix and the echelon form to solve a :math:`5\times5` system of the form :math:`Mx = b`. First we define the matrix `M` and the vector `b` ::

   sage: M = matrix(QQ, [[2,4,6,2,4],[1,2,3,1,1],[2,4,8,0,0],[3,6,7,5,9]]); M   [2 4 6 2 4]
   [1 2 3 1 1]
   [2 4 8 0 0]
   [3 6 7 5 9]
   sage: b = vector(QQ, [56, 23, 34, 101])

Then we construct the augmented matrix :math:`\left( M\ \vert b  \right)`, store it in the variable `M_aug` and compute it's echelon form. ::

   sage: M_aug = m.augment(b); M_aug
   [  2   4   6   2   4  56]
   [  1   2   3   1   1  23]
   [  2   4   8   0   0  34]
   [  3   6   7   5   9 101]
   sage: M_aug.echelon_form()
   [ 1  2  0  4  0 21]
   [ 0  0  1 -1  0 -1]
   [ 0  0  0  0  1  5]
   [ 0  0  0  0  0  0]

This tells us that we have a one dimensional solution space that consists of vectors of the form :math:`v = c \left(-2,1,0,0,0 \right) + \left(17,0,1,5\right)`

If all we need is a *single* solution to this system, we can use the :meth:`solve_right` method. ::

   sage: M.solve_right(b)
   (21, 0, -1, 0, 5)

With some of the basic matrix operations under our belt, we are ready to move on to the next section. 

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

Vector and Matrix Spaces
------------------------

It is sometimes useful to create the space of all matrices of
particular dimension, for which we use the :func:`MatrixSpace`
function. We must specify the field (or indeed any ring) where the
entries live. ::

	sage: MatrixSpace(QQ,2,3)
	Full MatrixSpace of 2 by 3 dense matrices over Rational Field
				

If we input a ring R and an integer n we get the matrix ring of n×n
matrices of R. Coercion can be used to construct the zero matrix, the
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

   Use Sage to compute the bases for the following spaces:

     a) The right and left kernel. 
     b) The row space.
     c) The column space.
 

.. _vectors_and_matrices__jordan_form:

Mini-Topic: The Jordan Canonical Form
-------------------------------------

For every linear transformation :math:`\mathrm{T}:\mathbb{R}^n \longrightarrow \mathbb{R}^{n}` there is a basis of :math:`\mathbb{R}^n` such that the matrix :math:`\left[m\right]_{\mathcal{B}}` is in an *almost* diagonal form. This unique matrix is called the *Jordan Canonical Form* of :math:`\mathrm{T}`. For more information on this please refer to this article_ on Wikipedia. To demonstrate some common tools that we use in Sage we will compute this basis for the linear transformation

.. math::
   \mathrm{T}\left(x,y,z,t \right) = \left(2x+y, 2y+1, 3z, y-z+3t \right). 

We will begin by defining :math:`\mathrm{T}` in Sage. ::
      
      sage: T = lambda x,y,z,t: (2*x+y, 2*y+1, 3*z, y - z + 3*t)

Now, let's use the standard ordered basis of :math:`\mathbb{R}^3` to find the matrix form of :math:`\mathrm{T}`. Note that since Sage uses rows to construct a matrix we must use the  :func:`transpose` function to get the matrix we expect. ::

       sage: M = transpose(matrix([[2,1,0,0],[0,2,1,0], [0,0,3,0],[0,1,-1,3]])); <
       [ 2  1  0  0]
       [ 0  2  1  0]
       [ 0  0  3  0]
       [ 0  1 -1  3]

Once we have the matrix we will compute it's *characteristic polynomial*  and factorization. Note that in order to save a couple of keystrokes we use the `_` special variable. `_` is the variable that always contains the output of the last command. It's a handy variable to know, and we will use it often.  ::

      sage: M.characteristic_polynomial()
      x^4 - 10*x^3 + 37*x^2 - 60*x + 36
      sage: factor(_)
      (x - 3)^2 * (x - 2)^2

Above  we have two eigenvalues :math:`\lambda_1 = 3` and :math:`\lambda_2 = 2` and both are of algebraic multiplicity :math:`2`. Now we need to look at the associated  *eigenvectors*. To do so we will use the :meth:`eigenvectors_right` method. 
 ::

      sage: ev_M = M.eigenvectors_right(); ev_M      
      [(3, [
      (1, 1, 1, 0),
      (0, 0, 0, 1)
      ], 2), (2, [
      (1, 0, 0, 0)	
      ], 2)]
      sage: ev_M[1][1][0]
      (1, 0, 0, 0)

What is returned is a :func:`list` of lists. Each list consisting of an eigenvalue and the associated linearly independent eigenvectors. Note that the eigenvalue :math:`2` has algebraic multiplicity of :math:`2` but geometric multiplicity of only :math:`1`. This means that we will have to compute a *generalized eigenvector* for this eigenvalue. We will do this by solving the system :math:`\left(M - 2\mathrm{I}\right) v = x`, where :math:`x` is the eigenvector :math:`\left(1,0,0,0\right)`. I will use the :meth:`echelon_form` of the augmented matrix to solve the system.  ::
 
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

With the generalized eigenvector `gv`, we now have the right number of linearly independent vectors to form a basis for our *Jordan Form* matrix. We will next form the *change of basis matrix* that consists of these vectors as columns.  ::

      sage: S = transpose( matrix( [[1,1,1,0],[0,0,0,1],[1,0,0,0],gv])); S
      [ 1  0  1  1]
      [ 1  0  0  1]
      [ 1  0  0  0]
      [ 0  1  0 -1]

Now we will compute the matrix representation of :math:`\mathrm{T}` with respect to this basis. ::
    
      sage: S.inverse()*M*S
      [3 0 0 0]
      [0 3 0 0]
      [0 0 2 1]
      [0 0 0 2]

And there it is, the *Jordan Canonical Form* of the linear transformation :math:`\mathrm{T}`. Of course we could have just used Sage's built in :meth:`jordan_form` method to compute this directly. ::
   
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

Rings
=====

.. _polynomial_rings:

Polynomial Rings
----------------

Constructing polynomial rings in Sage is fairly straightforward. We
just specify the name of the "indeterminate" variable as well as the
coefficient ring. ::

	sage: R.<x>=PolynomialRing(ZZ)
	sage: R
	Univariate Polynomial Ring in x over Integer Ring

Once the polynomial ring has been defined we can construct a polynomial without any special coercions. ::

  sage: p = 2*x^2 + (1/2)*x + (3/5)
  sage: parent(p)
  Univariate Polynomial Ring in x over Rational Field

Though x is the most common choice for a variable, we could have chosen
any letter for the indeterminate.  ::

	sage: R.<Y>=PolynomialRing(QQ) 
	sage: R
	Univariate Polynomial Ring in Y over Rational Field

Then polynomials with rational coefficients in Y are valid objects in Sage. ::

  sage: q = Y^4 + (1/2)*Y^3 + (1/3)*Y + (1/4)
  sage: q
  Y^4 + 1/2*Y^3 + 1/3*Y + 1/4
  sage: parent(q)
  Univariate Polynomial Ring in Y over Rational Field
				
We can define polynomial rings over any ring or field.  ::

	sage: Z7=Integers(7)
	sage: R.<x>=PolynomialRing(Z7); R
	Univariate Polynomial Ring in x over Ring of integers modulo 7

When entering a polynomial into Sage the coefficients are automatically coerced into the ring or field specified.  ::

  sage: p = 18*x^2 + 7*x + 16; p
  4*x^2 + 2
  sage: parent(p)
  Univariate Polynomial Ring in x over Ring of integers modulo 7

Of course this coercion has to be well defined.  ::

  sage: q  = x^4 + (1/2)*x^3 + (1/3)*x^2 + (1/4)*x + (1/5)
  ---------------------------------------------------------------------------
  TypeError                                 Traceback (most recent call last)  ...
  TypeError: unsupported operand parent(s) for '*': 'Rational Field' and 'Univariate Polynomial Ring in x over Ring of integers modulo 7'

When prudent, Sage will extend the universe of definition to fit the polynomial entered. For example, if we ask for a rational coefficient in a polynomial ring over :math:`\mathbb{Z}`, Sage will naturally coerce this polynomial into a ring over :math:`\mathbb{Q}` ::

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
  sage: f/g
  (x + 1)/(x^2 + x - 1)
  sage: h^3
  1/8*x^3 + 9/16*x^2 + 27/32*x + 27/64
				
A fundamental attribute of a polynomial is its degree. We use the :meth:`degree` method to calculate this. ::

  sage: R.<x>=PolynomialRing(QQ)
  sage: (x^3+3).degree()
  3
  sage: R(0).degree()
  -1
				
Notice that by convention Sage sets the degree of 0 to be -1.

To check whether a polynomial is irreducible, we use it's :meth:`is_irreducible` method. ::

  sage: R.<x>=PolynomialRing(Integers(5))
  sage: (x^3+x+1).is_irreducible()
  True
  sage: (x^3+1).is_irreducible()  
  False
				
This method is only suitable for polynomial rings that are defined over a field, as polynomials defined more generally do not necessarily posses a unique factorization. 

To compute the *factorization* of a polynomial, where defined, we use the :func:`.factor` command.  ::

  sage: R.<x>=PolynomialRing(Integers(5))
  sage: factor(x^3+x+1)        
  x^3 + x + 1
  sage: factor(x^3+1)        
  (x + 1) * (x^2 + 4*x + 1)
				
In the example above, we see a confirmation that :math:`x^3+x+1` is irreducible in :math:`\mathbb{Z}_{5}[x]` whereas :math:`x^3+1` may be factored, hence is reducible.

Just like with the integers, :math:`F[x]` has a division algorithm. And just like with integers, we may use the ``//`` operator to determine the *quotient* and the ``%`` operator to determine the *remainder* of a division. ::

  sage: R.<x>=PolynomialRing(Integers(7))
  sage: f=x^6+x^2+1
  sage: g=x^3+x+1
  sage: f // g
  x^3 + 6*x + 6
  sage: f % g
  2*x^2 + 2*x + 2
				
Additionally, if the coefficients of the polynomial are in :math:`\mathbb{Z}` or :math:`\mathbb{Q}`, we may use the :func:`.divmod` command to compute both a the same time.  ::

  sage: S.<y>=PolynomialRing(QQ)
  sage: a=(y+1)*(y^2+1)
  sage: b=(y+1)*(y+5)
  sage: a // b
  y - 5
  sage: a % b
  26*y + 26
  sage: divmod(a,b)
  (y - 5, 26*y + 26)
				
Since :math:`F[x]` has unique factorization, we have a unique greatest common divisor (gcd) of polynomials. This can be computed using the :func:`gcd` command.  ::

  sage: R.<x> = PolynomialRing(QQ)
  sage: p = x^4 + 2*x^3 + 2*x^2 + 2*x + 1
  sage: q = x^4 - 1
  sage: gcd(p,q)
  x^3 + x^2 + x + 1

As with integers, the greatest common divisor of two polynomials can be represented as a linear combination. The extended Euclidean algorithm is to determine polynomials which constitute that linear combination. For polynomials defined over the integers or rationals, we may use the :func:`xgcd` function to compute the extended Euclidean algorithm. ::

  sage: R.<x>=PolynomialRing(ZZ)
  sage: a=x^4-1
  sage: b=(x+1)*x   
  sage: xgcd(a,b)
  (x + 1, -1, x^2 - x + 1)
  sage: d,u,v=xgcd(a,b)
  sage: a*u+b*v
  x + 1
				
We can also consider polynomials in :math:`R[x]` as functions from :math:`R` to :math:`R` by *evaluation*, that is by substituting the indeterminate variable with a member of the coefficient ring. Evaluation of polynomials in Sage works as expected, by *calling* the polynomial like a function. ::

  sage: R.<x>=PolynomialRing(Integers(3))
  sage: f=2*x+1
  sage: f(0)
  1
  sage: f(1)
  0
  sage: f(2)
  2
				
Calculating the *roots*, or *zeros*, of a polynomial can be done by using the :meth:`roots` method. ::

  sage: ((x-1)^2*(x-2)*x^3).roots()
  [(2, 1), (1, 2), (0, 3)]
				
Sage returns a list of pairs :math:`(r,m)` where ``r`` is the root and ``m`` is it's multiplicity. Of course, a polynomial need not have any roots and in this case the *empty list* is returned.  ::

  sage: (x^2+1).roots()
  []


Multivariate Polynomial Rings
++++++++++++++++++++++++++++++

Defining a polynomial ring with more that one variable can be done easily by supplying an extra argument to :func:`.PolynomialRing` which specifies the number of variables desired. ::

  sage: R.<x,y,z> = PolynomialRing(QQ, 3)
  sage: p = -1/2*x - y*z - y + 8*z^2; p
  -y*z + 8*z^2 - 1/2*x - y

Unlike with univariate polynomials, there is not a single way that we can order the terms of a polynomial. So to specify things like the *degree* and the *leading term* of a polynomial we must first fix a rule for deciding when one term is larger than another.  If no argument is specified, Sage defaults to the *graded reverse lexicographic* ordering, sometimes referred to as *grevlex*, to make these decisions. To read more about *Monomial Orderings*, see this page_ on Wikipedia. 

.. _page: http: http://en.wikipedia.org/wiki/Monomial_order   


To access a list of monomials, terms without coefficients, you use the :meth:`.monomials` method. ::

  sage: p.monomials()
  [y*z, z^2, x, y]

These monomials are listed in descending order using the term ordering specified when the ring was constructed. 

To access a list of *coefficients* we use the :meth:`.coefficients` method. ::

  sage: p.coefficients()
  [-1, 8, -1/2, -1]

The list of coefficients is provided in the same order as the monomial listing computed earlier. This means that we can create a list of *terms* of our polynomial by  :func:`.zip`-ing up the two lists. ::

  sage: [ a*b for a,b in zip(p.coefficients(),p.monomials())]
  [-y*z, 8*z^2, -1/2*x, -y]

Often you want to compute information pertaining to the *largest*, or *leading*, term. We can compute the *lead coefficient*, *leading monomial*, and the *lead term* as follows: ::

  sage: p.lc()
  -1
  sage: 
  sage: p.lm()
  y*z
  sage: p.lt()
  -y*z

We can also compute the polynomial's *total degree* using the :meth:`.total_degree` method. ::

  sage: p.total_degree()
  2

The exponents of each variable in each term, once again specified in descending order, is computed using the :meth:`.exponents` method. ::

  sage: p.exponents()
  [(0, 1, 1), (0, 0, 2), (1, 0, 0), (0, 1, 0)]

and the exponent of the lead term is computed by chaining together two of the methods just presented. ::

  sage: p.lm().exponents()
  [(0, 1, 1)]

To change the term ordering we must reconstruct both the ring itself and all of the polynomials with which we were working. The following code constructs a multivariate polynomial ring in :math:`x,y,` and :math:`z` using the *lexicographic* monomial ordering. ::

  sage: R.<x,y,z> = PolynomialRing(QQ,3,order='lex')
  sage: p = -1/2*x - y*z - y + 8*z^2; p
  -1/2*x - y*z - y + 8*z^2

Once the term order is changes, all of the methods discussed earlier, even how Sage displays the polynomial, take this into account. ::

  sage: p.lm()
  x
  sage: p.lc()
  -1/2
  sage: p.lt()
  -1/2*x           
  sage: p.monomials()
  [x, y*z, y, z^2]

Note that even with the same monomial ordering, in this case the lexicographic ordering, the order of the  indeterminates themselves is important. We can change the relative order of each indeterminate by changing the order in which we specify them when we construct the polynomial ring. The variables are considered to be in *descending* order. ::

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

Finally we can *reduce* a polynomial modulo a list of polynomials using the :meth:`.mod` method. ::

  sage: r = -x^2 + 1/58*x*y - y + 1/2*z^2
  sage: r.mod([p,q])
  -238657765/29696*y^2 + 83193/14848*y*z^2 + 68345/14848*y - 1/1024*z^4 + 255/512*z^2 - 1/1024



**Exercises:**

  #. Use Sage to find out which of the following polynomials with rational coefficients are irreducible?

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

.. _ideals:

Ideals
++++++

Once a ring is constructed and a list of generating elemets have been selected, the ideal generated by this list is constructed by using the ``*`` operator. ::

  sage: R.<x> = PolynomialRing(QQ)
  sage: I = [2*x^2 + 8*x - 10, 10*x - 10]*R; I
  Principal ideal (x - 1) of Univariate Polynomial Ring in x over Rational Field
  sage: J = [ x^2 + 1, x^3 + x ]*R; J
  Principal ideal (x^2 + 1) of Univariate Polynomial Ring in x over Rational Field
  sage: K = [ x^2 + 1, x - 2]*R; K
  Principal ideal (1) of Univariate Polynomial Ring in x over Rational Field
					
Sage automatically reduces the set of generators. This can be see by using the :meth:`.gens` method which returns the list of the ideal's generating elements. ::

  sage: I.gens()
  (x - 1,)
  sage: J.gens()
  (x^2 + 1,)
  sage: K.gens()
  (1,)

Ideal membership can be determined by using the ``in`` conditional. ::

  sage: R(x-1) in I
  True
  sage: R(x) in I  
  False
  sage: R(2) in J
  False
  sage: R(2) in K
  True
					
You can determine some properties of the ideal by using the corresponding ``is_*`` method. For example, to determine weather the ideals are *prime*,*principal*, or *idempotent* we enter the following: ::

	sage: J.is_prime()
	True
	sage: K.is_prime()
	False      
	sage: I.is_idempotent()
	False
	sage: K.is_principal()
	True
					
Unfortunately, as of the time of this writing, many of these methods are not implemented for all rings. For example, if you wanted to know if :math:`J` was a *maximal ideal*, you would normally type: ::

  sage: J.is_maximal()
  --------------------------------------------------------------------------
  NotImplementedError                       Traceback (most recent call last)

But we get a :obj:`NotImplementedError`, since Sage is not yet able to determine this.


Ideals in Multivarate Polynomial Rings
++++++++++++++++++++++++++++++++++++++

::
  sage: R.<x,y,z> = PolynomialRing(QQ,3,order='lex')
  sage: p = -1/2*x - y*z - y + 8*z^2
  sage: q = -32*x + 2869*y - z^2 - 1

::
  sage: I = [p,q]*R
  sage: I
  Ideal (-1/2*x - y*z - y + 8*z^2, -32*x + 2869*y - z^2 - 1) of Multivariate Polynomial Ring in x, y, z over Rational Field

::
  sage: I.groebner_basis()
  [x - 2869/32*y + 1/32*z^2 + 1/32, y*z + 2933/64*y - 513/64*z^2 - 1/64]

::
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

::
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


.. _quotient_rings:
					
Quotient Rings
--------------

To construct the *quotient ring* of a ring R with an ideal I we use the
:meth:`quotient` method ::

	sage: R = ZZ
	sage: I = R*[5]
	sage: I
	Principal ideal (5) of Integer Ring 
	sage: Q = R.quotient(I)
	sage: Q
	Ring of integers modulo 5
					
Much like when working in other universes, we have to coerce elements into the ring before we can preform arithmetic in the quotient ring. ::

	sage: Q(10)
	0
	sage: Q(12)
	2
	sage: Q(10) + Q(12)
	2
	sage: Q(10 + 12)
	2
					
When working with quotients of polynomial rings it is helpful to give
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



.. _rings_properties_and_tests:

Properties of Rings
------------------------------

In Sage, you may check some of the properties of the rings which have been constructed. For example, to check whether a ring is a *integral domain* or a *field* we use the :meth:`.is_integral_domain` or :meth:`.is_field` methods.   ::

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

These properties are often determined instantaneously since they built into the definitions of the rings and not calculated on the fly. 

For a complete listing of properties that are built into a ring, you can use Sage's built in *tab-completion*. For example, to see all of the properties which can be determined for the rational numbers we type ``QQ.is`` then the tab key. What we get is a list of all of the properties that we can compute. ::
  sage: QQ.is[TAB]
  QQ.is_absolute           QQ.is_finite             QQ.is_ring
  QQ.is_atomic_repr        QQ.is_integral_domain    QQ.is_subring
  QQ.is_commutative        QQ.is_integrally_closed  QQ.is_zero
  QQ.is_exact              QQ.is_noetherian         
  QQ.is_field              QQ.is_prime_field        

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

.. mv_division_algorithm

Mini-Topic: Multi-Variate Polynomial Division Algorithm
-------------------------------------------------------

In this section we will use Sage to construct a *division* algorithm for multivariate polynomials. Specifically, for a given polynomial :math:`f` (the dividend) and a sequence of polynomials :math:`f_1, f_2, \ldots, f_k` (the divisors) we want to compute a sequence of quotients :math:`a_1, a_2,\ldots, a_k` and a remainder polynomial :math:`r` so that

.. math::
   f = \sum_{i=1}^{i=k} a_i \cdot f_i + r

where no terms of :math:`r` are divisible by any of the leading terms of :math:`f_i`.


The first thing that we will do is to construct the base field for the polynomial ring and determine how many variables we want for the polynomial ring. In this case, lets define a two variable polynomial ring over the finite field :math:`\mathbb{F}_{2}`. ::

    sage: K = GF(2)
    sage: n = 2

Next we will construct the polynomial ring. ::
     
     sage: P.<x,y> = PolynomialRing(F,2,order="lex")

Since we are working with more than one variable we must tell Sage how to order the terms, in this case we selected a *lexicographic* ordering. The default term ordering is *degree reverse lexicographic*, where the *total degree* is used first to determine the order of the monomials, then a *reverse lexicographic* order is used to break ties. Other options for monomial orderings are `deglex` (degree lexicographic) or you can define a *block* ordering by using the :func:`TermOrder` command. You can read more on monomial orderings on-line on Wikipedia_ and on MathWorld_,  or the book [Cox2007]_ .

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
        

.. _finite_fields:

Finite Fields
=============

In a prior section we constructied rings of integers modulo :math:`n`. We know that when :math:`n` is a prime number the *ring* :math:`\mathbb{Z}_{n}` is actually a *field*. Sage will allow us to construct this same object a either a ring or a field. ::

  sage: R = Integers(7)
  sage: F7 = GF(7)
  sage: R, F7
  (Ring of integers modulo 7, Finite Field of size 7)

To take advantage of the extra stucture it is best to use the :func:`GF` command to construct this object. Just like with modular rings we have to coerece integers into the field in order to do arithemetic in the field. ::

  sage: F7(4 + 3)
  0
  sage: F7(2*3)
  6
  sage: F7(3*7)
  0
  sage: F7(3/2)
  5

We can use Sage to construct any *finite field*, recall that a finite field is always of order :math:`n = p^k` where :math:`p` is a prime number. So to construct the field of order :math:`25 = 5^2` we input the following command. ::

  sage: F25.<a> = GF(25, 'a')

Recall that the finite field of order :math:`5^2` can be thought of a an *extension* of :math:`\mathbb{Z}_{5}` using a root of a polynomial of degree :math:`2`. The ``a`` that you specified is a root of this polynomial. There are different polynomials that can be used to construct this extension and Sage chooses one for you. You can see the polynomial chosen by using the, aptly named, :meth:`polynomial` method. ::

  sage: p = F25.polynomial();
  sage: p
  a^2 + 4*a + 2

We can quickly verify that ``a`` satisfies this polynomial. ::

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
  sage: parent(_)
  Integer Ring
  sage: F25(3 + 4)
  2
  sage: parent(_)
  Finite Field in a of size 5^2

Sometimes we would like to specify the polynomial used to construct out extension. to do so we just need to add the *modulus* option to our field constructor. ::

  sage: F25.<a> = GF(25, 'a', modulus=x^2 + x + 1)
  sage: a^2 + a + 1
  0
  sage: a^2
  4*a + 4

Remember that the modulus must be a polynomial which is *irreducible* over :math:`\mathbb{F}_{5}[x]`. Many times we would like for the modulus to not just be irreducible, but to be primitive_. Next we will construct all of the primitive polynomials of degree :math:`2`. The following example uses some constructions that we haven't discussed yet, like :ref:`polynomial_rings` and :ref:`list_comprehensions`. First thing that we will do is construct a list of all polynomials over :math:`\mathrm{GF}(5)` ::

  sage: F5 = GF(5)
  sage: P.<x> = PolynomialRing(F, 'x')
  sage: AP = [ a0 + a1*x + a2*x^2 for (a0,a1,a2) in F^3 if (a2 != F(0))]
  sage: AP
  [x^2, x^2 + 1, x^2 + 2, x^2 + 3, x^2 + 4, x^2 + x, x^2 + x + 1, x^2 + x + 2, x^2 + x + 3, x^2 + x + 4, x^2 + 2*x, x^2 + 2*x + 1, x^2 + 2*x + 2, x^2 + 2*x + 3, x^2 + 2*x + 4, x^2 + 3*x, x^2 + 3*x + 1, x^2 + 3*x + 2, x^2 + 3*x + 3, x^2 + 3*x + 4, x^2 + 4*x, x^2 + 4*x + 1, x^2 + 4*x + 2, x^2 + 4*x + 3, x^2 + 4*x + 4, 2*x^2, 2*x^2 + 1, 2*x^2 + 2, 2*x^2 + 3, 2*x^2 + 4, 2*x^2 + x, 2*x^2 + x + 1, 2*x^2 + x + 2, 2*x^2 + x + 3, 2*x^2 + x + 4, 2*x^2 + 2*x, 2*x^2 + 2*x + 1, 2*x^2 + 2*x + 2, 2*x^2 + 2*x + 3, 2*x^2 + 2*x + 4, 2*x^2 + 3*x, 2*x^2 + 3*x + 1, 2*x^2 + 3*x + 2, 2*x^2 + 3*x + 3, 2*x^2 + 3*x + 4, 2*x^2 + 4*x, 2*x^2 + 4*x + 1, 2*x^2 + 4*x + 2, 2*x^2 + 4*x + 3, 2*x^2 + 4*x + 4, 3*x^2, 3*x^2 + 1, 3*x^2 + 2, 3*x^2 + 3, 3*x^2 + 4, 3*x^2 + x, 3*x^2 + x + 1, 3*x^2 + x + 2, 3*x^2 + x + 3, 3*x^2 + x + 4, 3*x^2 + 2*x, 3*x^2 + 2*x + 1, 3*x^2 + 2*x + 2, 3*x^2 + 2*x + 3, 3*x^2 + 2*x + 4, 3*x^2 + 3*x, 3*x^2 + 3*x + 1, 3*x^2 + 3*x + 2, 3*x^2 + 3*x + 3, 3*x^2 + 3*x + 4, 3*x^2 + 4*x, 3*x^2 + 4*x + 1, 3*x^2 + 4*x + 2, 3*x^2 + 4*x + 3, 3*x^2 + 4*x + 4, 4*x^2, 4*x^2 + 1, 4*x^2 + 2, 4*x^2 + 3, 4*x^2 + 4, 4*x^2 + x, 4*x^2 + x + 1, 4*x^2 + x + 2, 4*x^2 + x + 3, 4*x^2 + x + 4, 4*x^2 + 2*x, 4*x^2 + 2*x + 1, 4*x^2 + 2*x + 2, 4*x^2 + 2*x + 3, 4*x^2 + 2*x + 4, 4*x^2 + 3*x, 4*x^2 + 3*x + 1, 4*x^2 + 3*x + 2, 4*x^2 + 3*x + 3, 4*x^2 + 3*x + 4, 4*x^2 + 4*x, 4*x^2 + 4*x + 1, 4*x^2 + 4*x + 2, 4*x^2 + 4*x + 3, 4*x^2 + 4*x + 4]

Next we will *filter* out the primitive polynomials out of this list. ::

  sage: PR = [ p for p in AP if p.is_primitive() ]
  sage: PR
  [x^2 + x + 2, x^2 + 2*x + 3, x^2 + 3*x + 3, x^2 + 4*x + 2, 2*x^2 + x + 1, 2*x^2 + 2*x + 4, 2*x^2 + 3*x + 4, 2*x^2 + 4*x + 1, 3*x^2 + x + 4, 3*x^2 + 2*x + 1, 3*x^2 + 3*x + 1, 3*x^2 + 4*x + 4, 4*x^2 + x + 3, 4*x^2 + 2*x + 2, 4*x^2 + 3*x + 2, 4*x^2 + 4*x + 3]

If we wanted all of the *irreducible* polynomials we would only change the last command slightly. ::

  sage: IR = [ p for p in AP if p.is_irreducible() ]
  sage: IR
  [x^2 + 2, x^2 + 3, x^2 + x + 1, x^2 + x + 2, x^2 + 2*x + 3, x^2 + 2*x + 4, x^2 + 3*x + 3, x^2 + 3*x + 4, x^2 + 4*x + 1, x^2 + 4*x + 2, 2*x^2 + 1, 2*x^2 + 4, 2*x^2 + x + 1, 2*x^2 + x + 3, 2*x^2 + 2*x + 2, 2*x^2 + 2*x + 4, 2*x^2 + 3*x + 2, 2*x^2 + 3*x + 4, 2*x^2 + 4*x + 1, 2*x^2 + 4*x + 3, 3*x^2 + 1, 3*x^2 + 4, 3*x^2 + x + 2, 3*x^2 + x + 4, 3*x^2 + 2*x + 1, 3*x^2 + 2*x + 3, 3*x^2 + 3*x + 1, 3*x^2 + 3*x + 3, 3*x^2 + 4*x + 2, 3*x^2 + 4*x + 4, 4*x^2 + 2, 4*x^2 + 3, 4*x^2 + x + 3, 4*x^2 + x + 4, 4*x^2 + 2*x + 1, 4*x^2 + 2*x + 2, 4*x^2 + 3*x + 1, 4*x^2 + 3*x + 2, 4*x^2 + 4*x + 3, 4*x^2 + 4*x + 4]

It should be noted that the above code will only work if the polynomials are over *finite* rings or fields.

**Exercises:**

#. Compute the list of all *primitive polynomials* over :math:`GF(5)`.


.. _primitive: http://en.wikipedia.org/wiki/Primitive_polynomial


.. _coding_theory: 

Coding Theory
=============

.. _linear_codes:

Linear Codes
------------

A *linear code* is just a finite-dimensional vector space commonly defined over a finite field. To construct a linear code in Sage we first define a finite field and a matrix over this field whose range will define this vector space. ::

  sage: F = GF(2)
  sage: G = matrix(F, [(0,1,0,1,0),(0,1,1,1,0),(0,0,1,0,1),(0,1,0,0,1)]); G 
  [0 1 0 1 0]
  [0 1 1 1 0]
  [0 0 1 0 1]
  [0 1 0 0 1]

The code itself is constructed by the :func:`LinearCode` command. ::

  sage: C = LinearCode(G); C
  Linear code of length 5, dimension 4 over Finite Field of size 2

While the *length* and *dimension* of the code are displayed in the object's *description*, you can also obtain these properties at anytime using the code's :meth:`.length` and :meth:`.dimension` methods. ::

  sage: C.length()
  5
  sage: C.dimension()
  4

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

The *minimum distance* of ``C`` can be computed by using the :meth:`.minimum_distance` method. ::

  sage: C.minimum_distance()
  1

Sage can also compute the *distribution* of weights for the code. ::

  sage: C.weight_distribution()
  [1, 4, 6, 4, 1, 0]

Where the value listed at index ``i`` of the list, starting with zero and ending with the length of the code, is the number of codewords with that weight. 

Related to the weight distribution is the *weight enumerator* polynomial, which you compute using the code's :meth:`.weight_enumerator` method. ::

  sage: C.weight_enumerator()
  x^5 + 4*x^4*y + 6*x^3*y^2 + 4*x^2*y^3 + x*y^4

The *generating* and *check* matrices are computed using the :meth:`gen_mat` and :meth:`check_mat` methods. ::

  sage: C.gen_mat()
  [0 1 0 1 0]
  [0 1 1 1 0]
  [0 0 1 0 1]
  [0 1 0 0 1]
  sage: C.check_mat()
  [1 0 0 0 0]

The *systematic* form of the generating matrix is computed using :meth:`gen_mat_systematic`. ::

  sage: C.gen_mat_systematic()
  [0 1 0 0 0]
  [0 0 1 0 0]
  [0 0 0 1 0]
  [0 0 0 0 1]

Sage can both *extend* and *puncture* our code. The *extended code* is computed as follows:  ::

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

The *punctured* code is computed by supplying the code's :meth:`.punctured` method a list of coordinates in which to delete. The following commands construct the code that results when the 1st and 3rd coordinate from every code word in ``C`` are deleted. Note that unlike vectors, lists and matrices the 1st column is indexed by 1 and not 0 when puncturing a code. ::

  sage: Cp = C.punctured([1,3]); Cp
  Linear code of length 3, dimension 2 over Finite Field of size 2
  sage: Cp.gen_mat()
  [0 1 0]
  [0 0 1]
  sage: Cp.check_mat()
  [1 0 0]

Sage can also compute the *dual* of ``C``. ::

  sage: Cd = C.dual_code(); Cd
  Linear code of length 5, dimension 1 over Finite Field of size 2
  sage: Cd.gen_mat()
  [1 0 0 0 0]
  sage: Cd.check_mat()
  [0 1 0 0 0]
  [0 0 1 0 0]
  [0 0 0 1 0]
  [0 0 0 0 1]

And finally Sage can *decode* a received vector. The following simulates a communications channel; We begin with a code word, introduce an error and then correct this error by *decoding* the received message. ::

  sage: wrd = vector(F,(0,0,0,0,1))
  sage: err = vector(F,(0,0,1,0,0))
  sage: msg = wrd + err; msg 
  (0, 0, 1, 0, 1)
  sage: C.decode(msg)
  (0, 0, 0, 0, 1)
  sage: C.decode(msg) == wrd
  True

It should be noted that since the above code has a minimum distance of only 1 that decoding will not always produce the code word that you may have expected. 

These are only some of the commands that Sage offers for computing and working with linear codes. There is much more information on the following web sites:

.. seealso::

   #. http://www.sagemath.org/doc/constructions/linear_codes.html
   #. http://www.sagemath.org/doc/reference/sage/coding/linear_code.html


.. _cyclic_codes:

Cyclic Codes
------------

To construct a cyclic code of length :math:`3` over :math:`\mathbb{F}_2` we first need a *generating polynomial*, which can be any *irreducible* factor of :math:`x^{3} - 1`. A list of irreducible factors is computed using the :func:`.factor` command.  ::

  sage: P.<x> = PolynomialRing(GF(2),'x')
  sage: factor(x^3 -1 )
  (x + 1) * (x^2 + x + 1)

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

Sage can also compute a *parity check* matrix of :math:`C` using the code's :meth:`.check_mat` method. ::

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

Remembering that since we are constructing a finite field that :math:`q` has to either be prime or a prime power. Now let us compute all of the irreducable factors of :math:`x^{n} -1` over :math:`\mathbb{F}_{q}`. ::

    sage: A = factor(x^n-1); A

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

.. cyclic_codes_idempotents

Mini-Topic: Idempotent Polynomials
----------------------------------

We'll find the idempotent which is 1 modulo the ith factor of :math:`x^n -1`. Continuting with :math:`\mathbb{F}_{4}`. ::

      sage: F.<a> = GF(4, 'a')
      sage: P.<x> = PolynomialRing(F, 'x')

Then we will create the quotient ring. ::

     sage: R.<y> = P.quotient(x^19 - 1)
     sage: A = factor(x^19 - 1); A
     (x + 1) * (x^9 + a*x^8 + a*x^6 + a*x^5 + (a + 1)*x^4 + (a + 1)*x^3 + (a + 1)*x + 1) * (x^9 + (a + 1)*x^8 + (a + 1)*x^6 + (a + 1)*x^5 + a*x^4 + a*x^3 + a*x + 1)

Since the :func:`factor` command returns a list of polynomial factors and their multiplicities, which we do not need, we will strip those out. ::

      sage: A = [p[0] for p in A] 

Now we will just select one of these factors. The reader should also try different factors for themselves. ::

    sage: p0 = A[2]

Now we take the product of all of the other factors. ::

    sage: ap = prod( [p for p in A if p != a])
    x^10 + (a + 1)*x^9 + a*x^8 + a*x^7 + x^5 + (a + 1)*x^3 + (a + 1)*x^2 + a*x + 1

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

Hamming Codes
+++++++++++++
Aenean a dapibus risus. Aliquam erat volutpat. Phasellus ullamcorper, lacus vel scelerisque luctus, elit enim egestas lacus, non lobortis velit dolor eget nisl. Morbi commodo massa eu arcu porta sed eleifend eros tempor. Morbi nibh quam, vehicula et fringilla eget, sodales ut magna. Sed iaculis cursus arcu, non varius lectus fringilla in. Suspendisse non euismod leo. Suspendisse vel quam erat, vitae sagittis nisl. Mauris at mi sit amet nulla scelerisque convallis et in mauris. Etiam in risus nibh, vel interdum urna. ::

  sage: C = HammingCode(3, F)
  sage: C.gen_mat()
  70 x 73 dense matrix over Finite Field in a of size 2^3
  sage: C.check_mat()
  3 x 73 dense matrix over Finite Field in a of size 2^3

.. seealso::
   http://en.wikipedia.org/wiki/Hamming_code


BCH Codes
+++++++++

BCH codes, or Bose-Chaudhuri-Hockenghem codes, are a special class of the cyclic codes with 3 required parameters, :math:`n, \delta, F` and one optional one :math:`b`. Where :math:`n` is the length of the code, :math:`\delta` is called the *designed distance* and :math:`F` is a finite field of order :math:`q^{n}` where :math:`gcd(n, q) = 1`. 

If :math:`b` is not provided then a default value of zero is used. For example the following commands will construct a BCH code of length :math:`n = 13` with :math:`\delta = 5` over :math:`F = \mathrm{GF}(9)`. ::

  sage: F.<a> = GF(3^2,'a')
  sage: C = BCHCode(13, 5, F)
  sage: C                    
  Linear code of length 13, dimension 6 over Finite Field in a of size 3^2

We can compute the code's minimum distance using it's :meth:`.minimum_distance` method. ::

  sage: C.minimum_distance()
  6

Since BCH codes are also linear, you can use Sage to compute the code's generating and check matrices. ::

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


Binary Golay Codes
++++++++++++++++++

Etiam sodales condimentum tellus, eget condimentum nunc imperdiet at. Vivamus et consectetur mauris. Duis auctor mollis mi a hendrerit. Suspendisse eget lobortis felis. Nunc porttitor, turpis vel congue suscipit, velit est interdum dolor, volutpat luctus dui felis sed tellus. Nulla velit eros, porta ut mattis vel, tempor id ligula. Suspendisse eleifend orci vel elit tristique non ultricies orci euismod. Ut feugiat, nisi in accumsan vulputate, magna orci pellentesque nulla, eu sagittis dolor dolor sit amet neque. 

.. seealso::
   http://en.wikipedia.org/wiki/Binary_Golay_code


Reed Solomon Codes
++++++++++++++++++

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sem dui, rutrum a tincidunt in, tempus at nisl. Donec sit amet odio id enim ultricies condimentum. In sodales sem quis nibh bibendum vitae mattis quam cursus. Sed elementum odio eget nulla varius eget eleifend turpis blandit.

.. seealso::
   http://en.wikipedia.org/wiki/Reed%E2%80%93Solomon_error_correction


Toric Codes
++++++++++++

Integer ac mi at tortor porta varius eget interdum turpis. Etiam ante nulla, posuere ac porttitor non, suscipit ac lorem. Cras a tortor sed risus blandit feugiat consequat ac mi. Morbi faucibus mi non erat dictum nec scelerisque magna interdum. Nulla ac nisl in lorem vulputate posuere sed vel nisi. Pellentesque arcu massa, porta eget tincidunt ac, fringilla et ante.

.. seealso::
   http://en.wikipedia.org/wiki/Toric_code


Walsh Codes
+++++++++++

Pellentesque accumsan ornare convallis. Sed sapien erat, tincidunt vel bibendum a, feugiat vel nulla. Nam vel lectus nibh. Quisque facilisis, quam ut faucibus rutrum, nulla leo fermentum nibh, a varius turpis sapien non mauris. Mauris auctor malesuada viverra.

.. seealso::
   http://en.wikipedia.org/wiki/Walsh_code
