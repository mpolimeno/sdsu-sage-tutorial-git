.. _about_this_tutorial:

*********************
 About this tutorial
*********************
.. _about_tutorial_introduction:

Introduction
============

.. _about_tutorial_howto:

How to use this tutorial
------------------------

This tutorial is divided into four main parts. This part, :ref:`about_this_tutorial`,  is intended to introduce readers to the basic structure of the tutorial, how to use Sage's built-in help system, and how they can contribute to this tutorial if they desire.   

The second part, :ref:`sage_as_a_calculator`, will get the reader up to speed with topics such as how to do arithmetic, evaluate functions, create simple graphs, solve equations and  basic calculus. We call this section :ref:`sage_as_a_calculator` because most of the topics covered are those that are commonly done with a standard graphing calculator. The target audience for this section is any motivated pre-calculus or calculus student.   

:ref:`programming_in_sage` begins to introduce the reader to some more *advanced* topics such as:  how Sage handles numbers, how to define and use variables and functions; how to manipulate lists, strings, and sets; and Sage *universes* and *coercion*.

The final part, :ref:`mathematical_structures`, introduces the reader to topics that one finds in college level curriculum: linear algebra, number theory, groups, rings, fields, etc.
 
Since this is a tutorial introduction to Sage, we will be using examples to demonstrate ideas and the reader is encouraged to follow along as we progress by entering the commands into their own copy of Sage. We have tried to include exercises for practice and problems for more extensive exploration of a given topic. The reader is also encouraged to do many of these.

While the tutorial mostly progresses in a linear fashion, we still include at the beginning of each section a list of the most important prerequisite topics. This list follows the text "You should be familiar with." and by clicking one of these links you will be taken to the relevant portion of the tutorial. We have also tried to include links to further information and other on-line references. These will follow the "**See also:**" text. 

Some sections may contain numbered citations such as "[1]_." The list of these citations will be at the bottom of a section with at least one citation. These citations will direct the reader to texts which contain more information about the topic being presented. 

**References:**

.. [1] William A. Stein et al. Sage Mathematics Software (Version x.y.z),
   The Sage Development Team, 2011, http://www.sagemath.org. 

.. _about_sage:


About Sage
----------

Sage is a free open source mathematical software system based on the Python programming language. Originally created for research into mathematics, it has been evolving into a powerful tool for math education. Sage combines numerous other mathematical software packages using a single interface.

As an open source project, Sage invites contributions from all of its users. This tutorial is one of many sources of information for learning about Sage. See the Sage webpage for more information.

.. seealso::
   `Sage on the Web <http://www.sagemath.org>`_ 

 
.. _installing_sage:

Installing Sage
---------------

The Sage web-site already contains detailed instructions for installing Sage on all popular operating systems. So we will not duplicate that effort but rather just point the reader to the sage project's `official installation guide <http://www.sagemath.org/doc/installation/>`_.
 
.. _tips:

Helpful Tips
============

Sage has two common ways to enter commands, the *command line* and a web-based *notebook* which is similar in design and purpose to the interfaces of other computer algebra systems like *Maple*, *Mathematica* and *Matlab*.

.. _help_tabcompletion:

`?` and Tab Completion
-----------------------

An extremely useful feature both in the command-line interface and the notebook is *tab completion* of Sage commands. For long-time UNIX shell users this feature is often taken for granted, but for those of you whose only command line experience is with DOS this feature will seem like magic. To use tab completion, just start by typing the first couple of letters of the command that you would like to use, then hit the tab-key. Foe example, suppose that you wanted to compute :math:`56!` and don't remember the exact command name to do this. Well, you can just type the first three letters ``fac`` and then hit the tab-key. ::

  sage: fac[TAB]
  factor     factorial  
  sage: factor

This tells you that only two Sage commands begin with ``fac``,  :func:`.factor` and :func:`.factorial`. Note that Sage has already changed the command from ``fac`` to ``factor`` because this is the common root of both commands. Since *factorial* looks like the correct command we will select it by typing the next letter, ``i``, and hitting the tab key again. ::

  sage: factorial   

This time no list is returned because the only command that begins with ``factori`` is :func:`factorial`. So to compute :math:`56!` you just complete the command by adding the argument ``(56)``. ::

  sage: factorial(56)
  710998587804863451854045647463724949736497978881168458687447040000000000000

Another good use of tab-completion is to discover what *methods* an *object* has. Don't worry if you have never heard of the term object or method before, their meaning will become clearer as you follow along. The commands presented now are assuming that you are using the command line interface,  the notebook behaves slightly differently, and we will address those differences in the next section.

Say you have the integer :math:`a = 56` and you were wondering which commands Sage offers for working with integers like :math:`56`. In this case the :math:`a` is our object and we can find all of the *methods* associated with integers by typing ``a.`` then hitting the tab-key. ::

  sage: a = 56
  sage: a.[TAB]
  a.N                            a.kronecker
  ... A long list of Commands ...
  a.divisors                     a.parent
  a.dump                         a.popcount
  a.dumps                        a.powermod
  a.exact_log                    a.powermodm_ui
  --More--

Do not be intimidated by the length of this list. Sage is a very powerful program and all this means is that it knows how to do a lot with integers. You should note the ``--More--`` at the bottom of the screen. This little cue is telling us that the list of possible commands is longer than what can fit on a single screen. To scroll through this list a page at a time, just hit any key and Sage will display the next page.

On the second page you see that :meth:`.factor` is an option. To use this method, which *factors* :math:`56` into unique prime factors, you enter ``a.factor()`` and hit return. ::
 
  sage: a.factor()[RET]
  2^3 * 7

What this allows you to do is to *discover* new commands in Sage. 

Once you have identified a command that interests you, the next step is to find out exactly *what* this command does and *how* to use it. Sage has a built-in help system to help you achieve this very goal. 

Let's suppose that you wish to compute the *lowest common multiple* of two integers and are not sure which command does this. A good place to begin the search is by typing ``l`` at the command prompt and then hitting the tab-key.  ::

  sage: l[TAB]
  laguerre                    list_plot3d
  lambda                      lk
  laplace                     ll
  latex                       ln
  lattice_polytope            lngamma
  lazy_attribute              load
  lazy_import                 load_attach_path
  lc                          load_session
  lcalc                       loads
  lcm                         local/LIB
  ldir                        local/bin
  ...
  lisp_console                ls
  list                        lucas_number1	
  list_composition            lucas_number2
  list_plot                   lx


Once again you have quite a long list of commands from which to select. Scanning down the list, you see the :func:`lcm` command listed which seems like what you are trying to compute. To make sure of this type ``lcm?`` and then hit enter. ::

  sage: lcm?

Which outputs: ::

  Base Class:     <type 'function'>
  String Form:    <function lcm at 0x32db6e0>
  Namespace:      Interactive
  File:           /home/ayeq/sage/local/lib/python2.6/site-packages/sage/rings/arith.py
  Definition:     lcm(a, b=None)
  Docstring:
	 The least common multiple of a and b, or if a is a list and b is
	 omitted the least common multiple of all elements of a.

	 Note that LCM is an alias for lcm.

	 INPUT:

	 * ``a,b`` - two elements of a ring with lcm or

	 * ``a`` - a list or tuple of elements of a ring with lcm

	 EXAMPLES:

	    sage: lcm(97,100)
	    9700
	    sage: LCM(97,100)


Again, there will be a whole lot of information, usually more than will fit on one screen.  Navigation is easy; hitting the space bar will take you to the next page, and ``b``, or the up-arrow key, will move backward in the documentation. To exit the help system hit the ``q`` key. Remember, navigation through the help system is slightly different if you are using the notebook. 

When first starting out; the description,  the ``INPUT``, and the ``EXAMPLES`` sections are good sections to read. The description gives a short summary describing what the command does,  ``INPUT`` gives you information on what you should provide as *arguments* to the command, and ``EXAMPLES`` gives concrete examples of the command's usage.

The description in this case is:  ::

  The least common multiple of a and b, or if a is a list and b is
  omitted the least common multiple of all elements of a.
  Note that LCM is an alias for lcm.

From this description, you can be pretty sure that this is the command that you am looking for. Next examine the ``INPUT``: ::

  INPUT:
  * ``a,b`` - two elements of a ring with lcm or
  * ``a`` - a list or tuple of elements of a ring with lcm

Here you see that ``lcm`` can either accept two arguments, for our purposes two integers, or a list of objects. Finally by perusing the ``EXAMPLES`` you can get a good idea on how this command is actually used in practice. ::

       EXAMPLES:
    
          sage: lcm(97,100)
          9700
          sage: LCM(97,100)
          9700
          sage: LCM(0,2)
          0
          sage: LCM(-3,-5)
          15
          sage: LCM([1,2,3,4,5])
          60
          sage: v = LCM(range(1,10000))   # *very* fast!
          sage: len(str(v))
          4349

Having a comprehensive help system built into Sage is one of it's best features and the sooner you get comfortable with using it the faster you will be able to use the full power of this CAS.

.. _notebook_help:

``?`` and the notebook
--------------------------

As noted before, there are small differences between the comand line and the notebook.  The notebook is generally more intuitive for those  who are used to point-and-click interfaces. 

Suppose that instead of the least common multiple, you are looking to compute the *greatest common divisor* of two integers. In the notebook, you begin the search in much the same way as you did on the command line, by typing into an input box ``g`` and then hitting the tab key. 

.. image:: pics/tabcompletion-ex1.png
        :alt: Finding the gcd() command using tab completion. 
	:width: 800px
	:height: 525px

What you see is an overlay of all the completions. You can scroll through this list by using the arrow keys or by using a mouse to highlight the desired options. Like previously, you see the :func:`gcd` function which looks like it is what you are looking for. To confirm this, you type ``gcd?`` and click on the ``evaluate`` link at the bottom of the cell.

.. image:: pics/tabcompletion-ex2.png
        :alt: Using ? to find a description of gcd() 
	:width: 800px
	:height: 525px

To exit the help system overlay just click anywhere on the screen.

.. _contributing: 

Contributing to the Tutorial
============================

Additions to this tutorial are encouraged as are suggestions for additional topics for inclusion.

All of this website's source code can be downloaded from the project's `bitbucket <https://bitbucket.org/ayeq123/sdsu-sage-tutorial/>`_. There you will find a complete copy of the source code for generating this website. To build the site from its source, the reader will need to install the `Sphinx Documentation <http://sphinx.poco.org>`_, which is written in the `Python Programming Language <http://www.python.org>`_.  We are excited to see any changes that you make so please let `us <monarres@rohan.sdsu.edu>`_ know of any new material that you  add. We want for this tutorial to be as comprehensive as possible and any assistance toward this goal is welcomed.

The content of the this tutorial has be written using `reStructured Text <http://sphinx.pocoo.org/rest.html>`_, which is processed by `Sphinx <http://sphinx.pocoo.org/>`_ to produce the HTML and PDF output. Sphinx and reStructured Text are used throughout the official Sage and Python documentation, so it is useful for contribuotrs to either of these projects. 

There are  four parts to the tutorial: "How to use this tutorial" has basic instructions about using and amending the tutorial, and the others have mathematical content. "Sage as a Calculator" is intended, as the title suggests, to cover straightforward computations, plotting graphs, and content that one might find in a high school algebra course, introductory statistics or calculus.  We intend it to be  accessible to an entering college student, or to a bright high school student.

"Programming in Sage" eases the transition to higher level mathematics by treating topics that relate to the interface between mathematical concepts and computational issues. This chapter covers basic structures like: lists, sets and strings; the universe for a number or variable, rational numbers versus real numbers (of specificied precision); programming essentials like booleans, conditionals and iterative computation; file handling and data handling; etc.

"Mathematical Structures" is written at a more sophisticated level than the earlier material, since the intended audience is college students taking upper division math courses.  The emphasis is on learning about specific mathematical structures that have a Sage class associated to them.

.. seealso::
   `reStructured Text Primer <http://sphinx.pocoo.org/rest.html>`_

.. _credits_and_license:

Credits and License
-------------------

The content and code for this tutorial were written by David Monarres and Ryan Rosenbaum under the supervision of Mike O'Sullivan. The work was supported by San Diego State University's Presidential Leadership Fund and is licensed under the `Creative Commons Attribution-ShareAlike 3.0 <http://creativecommons.org/licenses/by-sa/3.0/>`_ License. You are free to share and to remix, but attribution should be given to the original funder and creators.
