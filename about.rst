.. _about_tutorial:

***********************************
 About this tutorial
***********************************

.. _about_tutorial_introduction:

Introduction
============

.. _about_tutorial_howto:

How to use this tutorial
------------------------

This tutorial is divided into four parts, which contain chapters, which further contain links to the tutorial's sections.

This part is "About this tutorial," with information about using, and amending the tutorial. "Sage as a Calculator" shows how to do arithmetic, evaluate functions, plot graphs, compute derivatives and integrals (eventually) and do other things that involve fairly simple commands. This material is similar to computations one would do with a calculator, and the chapter is intended to be understandable by a motivated pre-calculus or calculus student. The chapter "Programming in Sage" teaches some of the more subtle issues about how sage computes: the different ways that Sage handles numbers, how to use variables, lists, strings, and sets. The chapter also shows how to save and restore your work, and how to program with iterative loops, conditional statements, and user created functions. The chapter "Mathematical Structures" introduces the topics that one finds in college level curriculum: number theory, groups, rings, fields, etc. 

Throughout this tutorial we will explore how to use Sage to perform calculations. In each section we have tried to include exercises for practice and problems for more extensive exploration. 

At the beginning of each section is a list of things which you should understand before proceeding. This list follows the text "You should be familiar with." Clicking one of these links will take you to the relevant portion of the tutorial. We have also tried to include links to further information and other on-line references, these will follow the "**See also:**" text. 

Some sections may contain numbered citations such as "[1]_." At the bottom of a section with at least one citation will be a bibliography section, with the entries correspondingly numbered.

**Bibliography**

.. [1] example citation: Alfred P. Nobody

.. _about_sage:

About Sage
----------------

Sage is a free open source mathematical software system. Originally created for research into mathematics, it has been evolving into a powerful tool for math education. Sage combines numerous other mathematical software packages using a single interface.

As an open source project, Sage invites contributions from all of its users. This tutorial is one of many sources of information for learning about Sage. See the Sage webpage for more information.

.. seealso::
		`Sage on the Web <http://www.sagemath.org>`_ 

 
.. _installing_sage:

Installing Sage
-----------------

The Sage web site already contains detailed instructions for installing sage on all popular operating systems. So we will not duplicate that effort but rather just point the reader to the sage project's `official installation guide <http://www.sagemath.org/doc/installation/>`_
 
.. _helpful_tips:

Helpful Tips
-----------------

.. todo::
   1. Tab completion
   2. Getting help using '?' at the prompt.
   3. The Notebook

.. _contributing: 

Contributing to the Tutorial 
==================================

Additions to this tutorial are very welcome.

All of this website's source code can be downloaded from the project's `bitbucket <https://bitbucket.org/ayeq123/sdsu-sage-tutorial/>`_. From there you will find all that you need to download. To build the site from source the reader will need to install the `Sphinx Documentation <http://sphinx.poco.org>`_ which is written in the `Python Programming Language <http://www.python.org>`_ Please let `us <monarres@rohan.sdsu.edu>`_ know of any new material so that we may incorporate it into our version.

The content of the this tutorial has be written using `reStructured Text <http://sphinx.pocoo.org/rest.html>`_ which is then processed by `Sphinx <http://sphinx.pocoo.org/>`_ to produce the HTML and PDF output. Sphinx and reStructured Text are used throughout the official Sage and Python documentation and is useful to know if the reader is interested in making contributions to either of these projects. Also, selfishly perhaps, the authors felt that by using these tools our project can be integrated with the official documentation at some point. 

We have four parts to the tutorial: "How to use this tutorial" has basic instructions about using and amending the tutorial, and the others have mathematical content. "Sage as a Calculator" is intended, as the title suggests, to cover straightforward computations, and we have designed it to be fairly accessible to an entering college student, or to a bright high school student.

"Programming in Sage" eases the transition to higher level mathematics by treating topics that relate to the interface between mathematical concepts and computational issues. This chapter covers basic structures like: Lists, sets and strings; The universe for a number or variable, rational numbers versus real numbers (of specificied precision); Programming essentials like conditionals and iterative computation; File handling, data handling etc.

In "Mathematical Structures" the emphasis is on learning about specific mathematical structures, which have a Sage class associated to them.

.. seealso::

   #. `reStructured Text Primer <http://sphinx.pocoo.org/rest.html>`_


.. _credits_and_license:

Credits and License
---------------------

The content and code for this tutorial were written by Ryan Rosenbaum and David Monarres under the supervision of Mike O'Sullivan. The work was supported by San Diego State University's Presidential Leadership Fund. This work is licensed under the `Creative Commons Attribution-ShareAlike 3.0 <http://creativecommons.org/licenses/by-sa/3.0/>`_ License. You are free to share and to remix, but attribution should be given to the original funder and creators.
