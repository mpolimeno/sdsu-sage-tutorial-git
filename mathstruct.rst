.. _mathematical_structures:

******************************************
 Mathematical Structures
******************************************

.. _integers_modular_arithmetic:

Integers and Modular Arithmetic
===============================

.. _euclidean_algorithm:

Euclidean Algorithm
-------------------

|       You should be familiar with :ref:`division_and_factoring`, :ref:`variables`, :ref:`sessions`, and :ref:`while_loops`

Recall that the division algorithm states that for :math:`a,b \in
\mathbb{Z}` with :math:`b \neq 0`, there exist a unique :math:`q,r \in
\mathbb{Z}` such that :math:`a=bq+r` and :math:`0 \leq r< b`. This
result is the stepping stone which leads us to the Euclidean Algorithm
to calculate the gcd of two integers :math:`a` and :math:`b` with :math:`b \neq 0`. Here is an implementation of the Euclidean algorithm in Sage (:download:`euclid.sage <./euclid.sage>`) 

.. code-block:: python

	# Begin euclid.sage
	r=a%b
	print (a,b,r)
	while r != 0:
	        a=b; b=r
	        r=a%b
	        print (a,b,r)
	# End euclid.sage
				

If we create a file ``euclid.sage`` containing the text above, then the output when we load the file is: ::

	sage: a=15; b=4 sage: load euclid.sage (15, 4, 3) (4, 3, 1)
	(3, 1, 0) sage: a=15; b=5 sage: load euclid.sage (15, 5, 0)
				

In the first case, we see that the gcd was 1, while in the second the gcd was 5.

**Exercises**
        1. Revise the while loop so that only the :math:`gcd(a,b)` and
	the total number of divisions (i.e. the number of steps
	through the algorithm) are printed. Compare the speed of this
	version of the algorithm with the built-in sage function
	:func:`.gcd` You will need to test large integers. By backwards
	substitution, the Euclidean algorithm addit onally allows us
	to determine integers :math:`u` and :math:`v` such that
	:math:`au+bv=gcd(a,b)`. This is known as the extended
	Euclidean algorithm. We use the :func:`.xgcd` function to obtain the triple :math:`(gcd(a,b),u,v)` ::

	        sage: d,u,v=xgcd(24,33)
		sage: 24*u+33*v
		3	
		sage: d
		3
				
	2. Write your own extended Euclidean algorithm by revising the while loop above.



.. _integers_modulo_n:

Integers Modulo :math:`n`
-------------------------

.. seealso::
     Before beginning, you should be familiar with :ref:`universes`
     and :ref:`variables`


In this section we shall cover how to construct and manipulate
:math:`\mathbb{Z}_n` and its elements.
To construct the ring of integers modulo n, we use the :class:`.Integers`
function. ::

	sage: Integers(7)
	Ring of integers modulo 7
	sage: Integers(100)
	Ring of integers modulo 100
				

Using this construction allows us to efficiently work in
:math:`\mathbb{Z}_n` as opposed to repeatedly using the ``%``
operator. To do this we will coerce integers into
:math:`\mathbb{Z}_n`. ::

	sage: R=Integers(13)
	sage: a=R(5)
	sage: b=R(8)
	sage: a+b
	0
	sage: a*b
	1
	sage: a-110
	12
				

Notice that in the last example, Sage naturally coerces the integer
110 into Z13. When it makes sense to coerce elements from
:math:`\mathbb{Z}_m` to :math:`\mathbb{Z}_n`, Sage will do so. ::

	sage: Z2=Integers(2)
	sage: Z4=Integers(4)
	sage: Z5=Integers(5)
	sage: a=Z2(1)
	sage: b=Z4(3)
	sage: c=Z5(2)
	sage: a*b
	1
	sage: a*c
	..
	TypeError: unsupported operand parent(s) for '*': 'Ring of integers modulo 2' and 'Ring of integers modulo 5'
	sage: b+a
	0
				

Some caution needs to be taken, for Sage allows the following: ::

	sage: Z5(Z2(1)) # this does not make sense
	1
				

It does not take much effort to realize why this does not make
sense. In :math:`\mathbb{Z}_2`, the element 1 represents the class of odd integers. Thus
13=1 in :math:`\mathbb{Z}_2`, but 13=3 in :math:`\mathbb{Z}_5`.

.. _linear_congruences:

Linear Congruences, inverses and division
-----------------------------------------

|  You should be familiar with :ref:`integers_modulo_n` and :ref:`lists_in_loops`


A linear congruence is an equation of the form :math:`ax=b` in :math:`\mathbb{Z}_n`. One way to
solve such a problem is an exhaustive search by constructing the list
of containing ax for each :math:`x \in \mathbb{Z}_n`. ::

	sage: R=Integers(15)
	sage: a=R(7)
	sage: 11 in [ a*x for x in R ]
	True
	sage: a=R(5)
	sage: 11 in [ a*x for x in R ]
	False
				

Notice here :math:`7x=11` had a solution in :math:`\mathbb{Z}_15` while :math:`5x=11` did not.

If :math:`ax=1` has a solution modulo n, then we say that a is a unit
in :math:`\mathbb{Z}_n`.

**Exercise:**
     1. Use an exhuastive search method to write a function which
     determines if a is a unit modulo n. 

In Sage we may use the :meth:`.is_unit` method to determine if a is a
unit mod n ::

       sage: R=Integers(21)
       sage: R(3).is_unit()
       False
       sage: R(4).is_unit()
       True
				
If an element is invertible, then we may raise it to the -1st power to
obtain its inverse ::

      sage: R=Integers(21)
      sage: R(4)^(-1)
      16
      sage: R(4)^-1
      16

.. note:: 
     It is not necessary here to put the -1 in parentheses, but it is good practice.

**Exercise:**
        1. For n = 13, 15 and 21 determine which of 3,4 and 5 are
        units in :math:`\mathbb{Z}_n`. When you find a unit, determine
        its inverse and compare this to the output of :math:`xgcd(a,n)`. Try and explain this relationship.


It is important to understand that division in :math:`\mathbb{Z}_n` is
really multiplication by an inverse. ::

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
				

Notice that in the cases ``R(4/5)`` and ``R(5/4)`` we are asking Sage
to coerce a rational number into the :math:`\mathbb{Z}_24` Thus,
consider the following example, which at first seems like an error ::

      sage: R(20).is_unit()
      False
      sage: R(16/20)
      20
				
20 is not a unit, yet at first glance it would seem we divided by it in :math:`\mathbb{Z}_24`. However, note the order of operations. First sage says 16/20 is really 4/5, and then coerces 4/5 into :math:`\mathbb{Z}_24`. Since 5 is a unit in :math:`\mathbb{Z}_24`, everything works out ok; however, we should be careful to understand that even though Sage does not complain about coercing :math:`ab` into :math:`\mathbb{Z}_n`, this does not necessarily mean b is a unit. 

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
summarised in the following table.

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
================



.. _vectors_and_matrices:

Vectors and Matrices
-------------------------

.. _vectors_and_matrices_constructions:

Constructions
^^^^^^^^^^^^^^^

To create a vector use the :func:`vector` command with a list of
entries. Scalar multiples and the dot product are straightforward to
compute. As with lists, vectors are indexed starting from 0. ::

	sage: v= vector([1,2,3,4])
        sage: 7*v
	(7, 14, 21, 28)
	sage: v*v
	30
	sage: v[0]
	1
	sage: v[4]
	ERROR: An unexpected error occurred while tokenizing input
				

Use the matrix command with a list containing m lists of length n, to
obtain an m×n matrix with the inputted lists as rows. Alternatively,
input integers m,n and a list of length mn, to obtain an m×n
matrix. Indexing of matrices also starts with 0. ::

	sage: matrix([[1,2],[3,4]])
	[1 2]
	[3 4]
	sage: m = matrix(2,2, [1,2,3,4])
	sage: m[1,1]
	4
				

If we input an integer n and a list of length :math:`n^2` we obtain an
n×n matrix by chopping up the list into n rows. ::

	sage: matrix(2,[1,2,3,4])  
	[1 2]
	[3 4]
				

We may specify the parent of the entries of the matrix. ::

	sage: matrix(QQ,2,[1.1,1.2,1.3,1.4])
	[11/10   6/5]
	[13/10   7/5]
				

There are also several special matrices built into Sage. To construct
the identity matrix we use the :func:`identity_matrix` function. ::

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

Matrix Manipulations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Nulla sem libero, porttitor ut convallis sed, placerat ut ipsum. Vestibulum semper pretium scelerisque. Quisque vulputate, elit ut aliquet interdum, quam libero accumsan justo, non tempus elit ipsum vel sapien. Nulla in nunc quam. Aliquam dictum mi ut lacus pulvinar et imperdiet lectus adipiscing. Donec at velit dolor. ::

      sage: m = matrix(QQ, [[1,2,3],[4,5,6],[7,8,9]]); m
      [1 2 3]
      [4 5 6]
      [7 8 9]

In cursus suscipit sapien sit amet suscipit. Fusce sed quam odio, id pharetra justo. Donec vitae dui vitae massa ultricies sodales. Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. Duis laoreet vulputate vulputate. Suspendisse nec consequat ligula. Curabitur vel commodo sem. Sed varius neque eu felis porttitor placerat. Nunc eu nisi at nulla mattis porta in at ante. Morbi euismod congue elit. Maecenas tristique venenatis nulla eget dignissim. Vestibulum pharetra laoreet nibh, quis sagittis erat egestas sed. Proin adipiscing lobortis odio. Nam posuere condimentum orci, id aliquet risus pulvinar eget. In sit amet aliquam mi. Praesent mattis orci in justo lacinia in tempus nulla vulputate. ::

   sage: m.rows()
   [(1, 2, 3), (4, 5, 6), (7, 8, 9)]
   sage: m.columns()
   [(1, 4, 7), (2, 5, 8), (3, 6, 9)]

In cursus suscipit sapien sit amet suscipit. Fusce sed quam odio, id pharetra justo. Donec vitae dui vitae massa ultricies sodales. Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. Duis laoreet vulputate vulputate. Suspendisse nec consequat ligula. Curabitur vel commodo sem. Sed varius neque eu felis porttitor placerat. Nunc eu nisi at nulla mattis porta in at ante. Morbi euismod congue elit. Maecenas tristique venenatis nulla eget dignissim. Vestibulum pharetra laoreet nibh, quis sagittis erat egestas sed. Proin adipiscing lobortis odio. Nam posuere condimentum orci, id aliquet risus pulvinar eget. In sit amet aliquam mi. Praesent mattis orci in justo lacinia in tempus nulla vulputate. ::

   sage: m.row(0)
   (1, 2, 3)
   sage: m.row(2)
   (7, 8, 9)
   sage: m.column(1) 	
   (2, 5, 8)
   sage: m.column(2)
   (3, 6, 9)

In cursus suscipit sapien sit amet suscipit. Fusce sed quam odio, id pharetra justo. Donec vitae dui vitae massa ultricies sodales. Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. Duis laoreet vulputate vulputate. Suspendisse nec consequat ligula. Curabitur vel commodo sem. Sed varius neque eu felis porttitor placerat. Nunc eu nisi at nulla mattis porta in at ante. Morbi euismod congue elit. Maecenas tristique venenatis nulla eget dignissim. Vestibulum pharetra laoreet nibh, quis sagittis erat egestas sed. Proin adipiscing lobortis odio. Nam posuere condimentum orci, id aliquet risus pulvinar eget. In sit amet aliquam mi. Praesent mattis orci in justo lacinia in tempus nulla vulputate. ::

   sage: m.diagonal()
   [1, 5, 9]

In cursus suscipit sapien sit amet suscipit. Fusce sed quam odio, id pharetra justo. Donec vitae dui vitae massa ultricies sodales. Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. ::

   sage: m.matrix_from_columns([0,2])
   [1 3]
   [4 6]
   [7 9]
   sage: m.matrix_from_rows([0,2])
   [1 2 3]
   [7 8 9]
   sage: m.matrix_from_rows_and_columns([0,2],[0,2])
   [1 3]
   [7 9]

Duis laoreet vulputate vulputate. Suspendisse nec consequat ligula. Curabitur vel commodo sem. Sed varius neque eu felis porttitor placerat. Nunc eu nisi at nulla mattis porta in at ante. Morbi euismod congue elit. Maecenas tristique venenatis nulla eget dignissim. Vestibulum pharetra laoreet nibh, quis sagittis erat egestas sed. Proin adipiscing lobortis odio. Nam posuere condimentum orci, id aliquet risus pulvinar eget. In sit amet aliquam mi. Praesent mattis orci in justo lacinia in tempus nulla vulputate. ::

   sage: m.rescale_row(1,-1/4); m
   [   1    2    3]
   [  -1 -5/4 -3/2] 	
   [   7    8    9]
   sage: m.rescale_col(2,-1/3); m 
   [   1    2   -1]
   [  -1 -5/4  1/2]
   [   7    8   -3]
   sage: m.rescale_row(1,-4); m
   [ 1  2 -1]
   [ 4  5 -2]
   [ 7  8 -3]


In cursus suscipit sapien sit amet suscipit. Fusce sed quam odio, id pharetra justo. Donec vitae dui vitae massa ultricies sodales. Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. Duis laoreet vulputate vulputate. Suspendisse nec consequat ligula. Curabitur vel commodo sem. Sed varius neque eu felis porttitor placerat. Nunc eu nisi at nulla mattis porta in at ante. Morbi euismod congue elit. Maecenas tristique venenatis nulla eget dignissim. Vestibulum pharetra laoreet nibh, quis sagittis erat egestas sed. Proin adipiscing lobortis odio. Nam posuere condimentum orci, id aliquet risus pulvinar eget. In sit amet aliquam mi. Praesent mattis orci in justo lacinia in tempus nulla vulputate. ::
   
   sage: m.add_multiple_of_row(1,0,-4); m
   [ 1  2 -1]
   [ 0 -3  2]
   [ 7  8 -3]
   sage: m.add_multiple_of_row(2,0,-7); m 
   [ 1  2 -1]
   [ 0 -3  2]
   [ 0 -6  4]

Suspendisse nec consequat ligula. Curabitur vel commodo sem. Sed varius neque eu felis porttitor placerat. Nunc eu nisi at nulla mattis porta in at ante. Morbi euismod congue elit. Maecenas tristique venenatis nulla eget dignissim. Vestibulum pharetra laoreet nibh, quis sagittis erat egestas sed. Proin adipiscing lobortis odio. Nam posuere condimentum orci, id aliquet risus pulvinar eget. In sit amet aliquam mi. Praesent mattis orci in justo lacinia in tempus nulla vulputate. ::

   sage: m.add_multiple_of_column(1,0,-2);m
   [ 1  0 -1]
   [ 0 -3  2]
   [ 0 -6  4]
   sage: m.add_multiple_of_column(2,0,1);m
   [ 1  0  0]
   [ 0 -3  2]
   [ 0 -6  4]


Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. ::

   sage: m.swap_rows(1,0); m
   [ 0 -3  2]
   [ 1  0  0]
   [ 0 -6  4]
   sage: m.swap_columns(0,2); m
   [ 2 -3  0]
   [ 0  0  1]
   [ 4 -6  0]


In cursus suscipit sapien sit amet suscipit. Fusce sed quam odio, id pharetra justo. Donec vitae dui vitae massa ultricies sodales. Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. Duis laoreet vulputate vulputate. Suspendisse nec consequat ligula. ::

   sage: m.set_column(0,[1,2,3]);m
   [ 1 -3  0]
   [ 2  0  1]
   [ 3 -6  0]
   sage: m.set_row(0,[1,2,5]);m
   [ 1  2  5]
   [ 2  0  1]
   [ 3 -6  0]

In cursus suscipit sapien sit amet suscipit. Fusce sed quam odio, id pharetra justo. Donec vitae dui vitae massa ultricies sodales. Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. Duis laoreet vulputate vulputate. ::

   sage: b = matrix(QQ,[ [1,0 ],[0,1]]); b
   [1 0]
   [0 1] 
   sage: m.set_block(1,1,b); m
   [1 2 5]
   [2 1 0]
   [3 0 1]


Curabitur vel commodo sem. Sed varius neque eu felis porttitor placerat. Nunc eu nisi at nulla mattis porta in at ante. Morbi euismod congue elit. Maecenas tristique venenatis nulla eget dignissim. Vestibulum pharetra laoreet nibh, quis sagittis erat egestas sed. Proin adipiscing lobortis odio. Nam posuere condimentum orci, id aliquet risus pulvinar eget. In sit amet aliquam mi. Praesent mattis orci in justo lacinia in tempus nulla vulputate. ::

   sage: m.echelon_form()
   [1 0 0]
   [0 1 0]
   [0 0 1]
   
   sage: m.echelonize(); m
   [ 1  0  0]
   [ 0  1  0]
   [ 0  0  1]

In cursus suscipit sapien sit amet suscipit. Fusce sed quam odio, id pharetra justo. Donec vitae dui vitae massa ultricies sodales. Proin lectus ligula, ullamcorper nec malesuada nec, fringilla ut eros. Cras semper, velit vel luctus mattis, sapien lectus dignissim metus, nec tempor orci sapien non urna. Quisque turpis lacus, condimentum in vehicula vitae, elementum sit amet elit. Duis laoreet vulputate vulputate. ::

   sage: m = matrix(QQ, [[2,4,6,2,4],[1,2,3,1,1],[2,4,8,0,0],[3,6,7,5,9]]); m
   [2 4 6 2 4]
   [1 2 3 1 1]
   [2 4 8 0 0]
   [3 6 7 5 9]
   sage: b = vector(QQ, [56, 23, 34, 101])
   sage: m_aug = m.augment(b); m_aug
   [  2   4   6   2   4  56]
   [  1   2   3   1   1  23]
   [  2   4   8   0   0  34]
   [  3   6   7   5   9 101]
   sage: m_aug.echelon_form()
   [ 1  2  0  4  0 21]
   [ 0  0  1 -1  0 -1]
   [ 0  0  0  0  1  5]
   [ 0  0  0  0  0  0]


Suspendisse nec consequat ligula. Curabitur vel commodo sem. Sed varius neque eu felis porttitor placerat. Nunc eu nisi at nulla mattis porta in at ante. Morbi euismod congue elit. Maecenas tristique venenatis nulla eget dignissim. ::

   sage: m.solve_right(b)
   (21, 0, -1, 0, 5)

Vestibulum pharetra laoreet nibh, quis sagittis erat egestas sed. Proin adipiscing lobortis odio. Nam posuere condimentum orci, id aliquet risus pulvinar eget. In sit amet aliquam mi. Praesent mattis orci in justo lacinia in tempus nulla vulputate. 


Matrix Arithmetic
^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
	sage: A^-1
	[ 1 -1]
	[ 0  1]
				

As usual, we must be careful about matrix dimensions. Notice how we computed the inverse of a matrix. If the matrix is not invertible Sage will complain about a :class:`ZeroDivisionError`.

Vectors are considered both as rows and as columns, so you can
multiply a 3-vector by a 3×n matrix on the right, or by a n×3 matrix
on the left. ::

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
				

We use the :meth:`det` method to calculate the determinant of a square
matrix. ::

	sage: MS=MatrixSpace(QQ,3)
	sage: A=MS.random_element()
	sage: A
	[-1/2    0   -1]
	[   0   -2    2]
	[   1    0 -1/2]
	sage: A.det()
	-5/2
				

To check if a matrix is invertible we may use the :meth:`is_invertible`
method ::

	sage: A=matrix(2,[1,1,0,1])
	sage: A.is_invertible()    
	True
	sage: A.det()
	1
	sage: B=matrix(2,[1,2,3,4])
	sage: B.is_invertible()
	False
	sage: B.det()
	-2
	sage: B^-1
	[  -2    1]
	[ 3/2 -1/2]

				

This example shows us an important, subtle fact. Sage assumes that the
matrix B is defined over the integers not over the rationals. A matrix
is invertible over :math:`\mathbb{Z}` if and only if its determinant
is :math:`\pm 1`. Thus if we think of B as a matrix over the rationals, we should obtain different results. When we ask Sage for the inverse it will automatically treat B as a matrix over the rationals.

.. _special_matrix_forms:

The Jordan Canonical Form
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For every linear transformation :math:`\mathrm{T}:\mathbb{R}^n \longrightarrow \mathbb{R}^{n}` there is a basis of :math:`\mathbb{R}^n` such that the matrix :math:`\left[m\right]_{\mathcal{B}}` is in an *almost* diagonal form. This unique matrix is called the *Jordan Canonical Form* of :math:`\mathrm{T}`. For more information on this please refer to this article_ on Wikipedia. To demonstrate some common tools that we use in Sage we will compute this basis for the linear transformation :math:`\mathrm{T}\left(x,y,z,t \right) = \left(2x+y, 2y+1, 3z, y-z+3t \right)`. First let define :math:`\mathrm{T}` in Sage. ::
      
      sage: T = lambda x,y,z,t: (2*x+y, 2*y+1, 3*z, y - z + 3*t)

Now, let's use the standard ordered basis of :math:`\mathbb{R}^3` to find the matrix form of :math:`\mathrm{T}`. Note that since Sage uses rows to construct a matrix we must use the  :func:`transpose` function to get the matrix we expect. ::

       sage: m = transpose(matrix([[2,1,0,0],[0,2,1,0], [0,0,3,0],[0,1,-1,3]])); m 
       [ 2  1  0  0]
       [ 0  2  1  0]
       [ 0  0  3  0]
       [ 0  1 -1  3]

Once we have the matrix we will compute it's *characteristic polynomial*  and factorization. Note that in order to save a couple of keystrokes we use the `_` special variable. `_` is the variable that always contains the output of the last command. It's a handy variable to know, and we will use it often.  ::

      sage: m.characteristic_polynomial()
      x^4 - 10*x^3 + 37*x^2 - 60*x + 36
      sage: factor(_)
      (x - 3)^2 * (x - 2)^2

Above  we have two eigenvalues :math:`\lambda_1 = 3` and :math:`\lambda_2 = 2` and both are of algebraic multiplicity :math:`2`. Now we need to look at the associated  *eigenvectors*. To do so we will use the :meth:`eigenvectors_right` method. 
 ::

      sage: ev_m = m.eigenvectors_right(); ev_m
      [(3, [
      (1, 1, 1, 0),
      (0, 0, 0, 1)
      ], 2), (2, [
      (1, 0, 0, 0)	
      ], 2)]
      sage: ev_m[1][1][0]
      (1, 0, 0, 0)

What is returned is a :func:`list` of lists. Each list consisting of an eigenvalue and the associated linearly independent eigenvectors. Note that the eigenvalue :math:`2` has algebraic multiplicity of :math:`2` but geometric multiplicity of only :math:`1`. This means that we will have to compute a *generalized eigenvector* for this eigenvalue. We will do this by solving the system :math:`\left(m - 2\mathrm{I}\right) v = x`, where :math:`x` is the eigenvector :math:`\left(1,0,0,0\right)`. I will use the :meth:`echelon_form` of the augmented matrix to solve the system.  ::
 
      sage: (m - 2*identity_matrix(4)).augment(ev_m[1][1][0])
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
    
      sage: S.inverse()*m*S
      [3 0 0 0]
      [0 3 0 0]
      [0 0 2 1]
      [0 0 0 2]

And there it is, the *Jordan Canonical Form* of the linear transformation :math:`\mathrm{T}`. Of course we could have just used Sage's built in :meth:`jordan_form` method to compute this directly.::
   
   sage: m.jordan_form()
   [3|0|0 0]
   [-+-+---]
   [0|3|0 0]
   [-+-+---]
   [0|0|2 1]
   [0|0|0 2]

But that wouldn't be any fun!

.. _article: http://en.wikipedia.org/wiki/Jordan_normal_form 

.. _vector_and_matrix_spaces:

Vector and Matrix Spaces
---------------------------

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

.. _rings:

Rings
=========

.. _polynomial_rings:

Polynomial Rings
--------------------

The construction of polynomial rings is straightforward in Sage. We
must specify the name of the " indeterminate " variable as well as the
coefficient ring. ::

	sage: R.<x>=PolynomialRing(ZZ)
	sage: R
	Univariate Polynomial Ring in x over Integer Ring
				

Notice how we specify the variable which represents the
indeterminate. We first specify the name of our ring, R in this
case. We then type a . followed by the indeterminate's name in
brackets. Though x is the most common choice, we could have used
anything, for example ::

	sage: R.<Y>=PolynomialRing(QQ) 
	sage: R
	Univariate Polynomial Ring in Y over Rational Field
				

We may use any ring R which we can construct in Sage ::

	sage: Z7=Integers(7)
	sage: R.<x>=PolynomialRing(Z7)
	sage: R
	Univariate Polynomial Ring in x over Ring of integers modulo 7
				

Once we have specified a name for the indeterminate in Sage, we may
proceed to construct polynomials. ::

	sage: R.<x>=PolynomialRing(QQ)
	sage: x^2+x+1
	x^2 + x + 1
	sage: 1/2*x-5
	1/2*x - 5
				

Sage understands coercion in polynomial rings as well. Witness, if we
ask for a rational coefficient in a polynomial ring over
:math:`\mathbb{Z}`, Sage will naturally coerce this into a ring over
:math:`\mathbb{Q}` ::

	sage: S.<y>=PolynomialRing(ZZ)
	sage: 1/2*y
	1/2*y
	sage: (1/2*y).parent()
	Univariate Polynomial Ring in y over Rational Field
				
Quite nice.

The basic arithmetic is straightforward ::

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
				

A fundamental attribute of a polynomial is its degree. Not
surprisingly, we use the :meth:`degree` method to calculate the degree of a
polynomial ::

	sage: R.<x>=PolynomialRing(QQ)
	sage: (x^3+3).degree()
	3
	sage: R(0).degree()
	-1
				

Notice that by convention Sage sets the degree of 0 to be -1.

Recall that a polynomial in R[x] is irreducible if it cannot be
written as the product of two polynomials of lesser degree. To check
if a polynomial is irreducible, we use the :meth:`is_irreducible` method ::

	sage: R.<x>=PolynomialRing(Integers(5))
	sage: (x^3+x+1).is_irreducible()
	True
	sage: (x^3+1).is_irreducible()  
	False
				

Please note that this method is only suitable for polynomials defined
over a field. For example, we cannot determine if polynomials over
:math:`\mathbb{Z}_4` are irreducible with the :meth:`is_irreducible`
property. One reason for this is polynomial rings defined over fields
always possess unique factorization into irreducibles. ::

	sage: R.<x>=PolynomialRing(Integers(5))
	sage: (x^3+x+1).factor()        
	x^3 + x + 1
	sage: (x^3+1).factor()        
	(x + 1) * (x^2 + 4*x + 1)
				

Here we see a confirmation that :math:`x^3+x+1` is irreducible in :math:`\mathbb{Z}_5[x]` while :math:`x^3+1` may be factored, hence is reducible.

The division algorithm for :math:`F[x]` states that given
:math:`a(x),b(x) \in F[x]` with :math:`b(x) \neq 0`, there exist
unique :math:`q(x),r(x) \in F[x]` such that :math:`a(x)=b(x)q(x)+r(x)` and :math:`deg(r)<deg(b)`. Similar to the integers, we may use the ``//`` operator to determine the quotient and the ``%`` operator to determine the remainder.::

	sage: R.<x>=PolynomialRing(Integers(7))
	sage: f=x^6+x^2+1
	sage: g=x^3+x+1
	sage: f // g
	x^3 + 6*x + 6
	sage: f % g
	2*x^2 + 2*x + 2
				

Additionally, we may use :func:`divmod` if the coefficients of the
polynomial are in :math:`\mathbb{Z}` or :math:`\mathbb{Q}` ::

	sage: S.<y>=PolynomialRing(QQ)
	sage: a=(y+1)*(y^2+1)
	sage: b=(y+1)*(y+5)
	sage: a // b
	y - 5
	sage: a % b
	26*y + 26
	sage: divmod(a,b)
	(y - 5, 26*y + 26)
				

Since :math:`F[x]` has unique factorization, we have a unique monic great common divisor of polynomials.

The extended Euclidean algorithm is to determine polynomials
:math:`u(x),v(x)` such that
:math:`a(x)u(x)+b(x)v(x)=gcd(a(x),b(x))`. For polynomials defined over
the integers or rationals, we may use the :func:`xgcd` function to
obtain gcd and the pair (u,v). ::

	sage: R.<x>=PolynomialRing(ZZ)
	sage: a=x^4-1
	sage: b=(x+1)*x   
	sage: xgcd(a,b)
	(x + 1, -1, x^2 - x + 1)
	sage: d,u,v=xgcd(a,b)
	sage: a*u+b*v
	x + 1
				

It is common to think of polynomials in :math:`R[x]` as functions from
:math:`R` to :math:`R`. The function is obtained by replacing the
indeterminate x with an element of r of R. We write :math:`f(r)` to
denote this ::

	sage: R.<x>=PolynomialRing(Integers(3))
	sage: f=2*x+1
	sage: f(0)
	1
	sage: f(1)
	0
	sage: f(2)
	2
				

We say :math:`r \in R` is a *root* of :math:`f \in R[x]` if
:math:`f(r)=0 \in R`. In Sage we may calculate the roots of a
polynomial using the :meth:`roots` method. ::

	sage: ((x-1)^2*(x-2)*x^3).roots()
	[(2, 1), (1, 2), (0, 3)]
				

Sage returns a list of pairs :math:`(r,m)` where r is a root of the polynomial
and m is the exponent of :math:`(x-r)` in the polynomial. Of course, a
polynomial need not have any roots ::

	sage: (x^2+1).roots()
	[]

.. _ideals_and_quotients:

Ideals and Quotients
--------------------------

In this section we will discuss how to construct and do common computations with ideals and quotient rings. As of the time of this writing, many of the methods have yet to be implemented uniformly across all types of rings.

.. _ideals:

Ideals
^^^^^^^^^^

We can construct the ideal generated by a list of generating elements by using the ``*`` operator.::

	sage: R.<x> = PolynomialRing(QQ,'x')
	sage: I = [2*x^2 + 8*x - 10, 10*x - 10]*R                             
	sage: I
	Principal ideal (x - 1) of Univariate Polynomial Ring in x over Rational Field
	sage: J = [ x^2 + 1, x^3 + x ]*R
	sage: J
	Principal ideal (x^2 + 1) of Univariate Polynomial Ring in x over Rational Field
	sage: K = [ x^2 + 1, x - 2]
	sage: K = [ x^2 + 1, x - 2]*R
	sage: K
	Principal ideal (1) of Univariate Polynomial Ring in x over Rational Field
					

It should be noted that Sage automatically reduces the set of generators.

Ideal membership can be determined by the ``in`` conditional. ::

	sage: R(x-1) in I
	True
	sage: R(x) in I  
	False
	sage: R(2) in J
	False
	sage: R(2) in K
	True
					

Sage can determine some of the properties of the ideals we just
constructed ::

	sage: J.is_prime()
	True
	sage: K.is_prime()
	False      
	sage: I.is_idempotent()
	False
	sage: K.is_principal()
	True
					
.. note::
        As of the time of this writing, these methods are not
        implemented for all rings. So use with caution. ::

	        sage: J.is_maximal()
		---------------------------------------------------------------------------
		NotImplementedError                       Traceback (most recent call last)
		...

.. _quotient_rings:
					
Quotient Rings
^^^^^^^^^^^^^^^^^^

To construct the quotient ring of a ring R and an ideal I we use the
:meth:`quotient` method ::

	sage: R = ZZ
	sage: I = R*[5]
	sage: I
	Principal ideal (5) of Integer Ring 
	sage: Q = R.quotient(I)
	sage: Q
	Ring of integers modulo 5
					

Much like we have done before when working with rings, we can do
arithmetic by coercing elements into the ring. ::

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
					

We can generate quotient rings of multi-variate polynomial rings. ::

	sage: R.<x,y> = PolynomialRing(QQ, 2, order='lex') 
	sage: I = R*[x^2 + y^2 -1 , x*y - 1]  
	sage: Q.<a, b> = R.quotient(I)
	sage: Q
	Quotient of Multivariate Polynomial Ring in x, y over Rational Field by the ideal (x^2 + y^2 - 1, x*y - 1)
	sage: a^2 + b^2 -1
	0
	sage: a^4 - a^2 + 1
	0

.. _rings_properties_and_tests:

Properties and Tests
-------------------------

In Sage, we may check the structure of rings. ::

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
				

For these structures, the structure is not calculated by Sage, but
instead is built into the definitions of the rings.

Recall if there is a smallest positive integer :math:`n` such that
:math:`n 1_R = 0_R`, then we say that :math:`R` has characteristic
:math:`n`. If no such n exists, we say that R has
characteristic 0. Rings in Sage have built-in a characteristic
function ::

	 sage: QQ.characteristic()
	 0
	 sage: R=Integers(43)
	 sage: R.characteristic()
	 43
	 sage: ZZ.characteristic()
	 0
				
