######################
Sage as a Calculator
######################

.. _arithmetic_and_functions:

In this chapter we will examine all of the commands that will allow for you to use Sage like a graphing calculator. This involves working with standard arithmetic, polynomials, trigonometric functions, and some basic work with graphics and solving equations.

.. _basic_arithmetic:

Basic Arithmetic
==================

The basic operators are ``+``, ``-``, ``*``, and ``/`` for addition, subtraction, multiplication and division and ``^`` is used for exponents. ::

	sage: 1+1
	2
	sage: 103-101
	2
	sage: 7*9
	63
	sage: 7337/11
	667
	sage: 11/4
	11/4
	sage: 2^5
	32
				
We place the ``-`` symbol in front of a number to indicate it is
negative ::

	sage: -6
	-6
	sage: -11+9
	-2
				
As we would expect, Sage adheres to the standard order of operations,
PEMDAS (parenthesis, exponents, multiplication, division, addition,
subtraction). ::

	sage: 2*4^2+1  
	33
	sage: (2*4)^2+1
	65
	sage: 2*4^(2+1)
	128
	sage: -3^2
	-9
	sage: (-3)^2
	9
				
There is one subtlety to deal with when dividing two integers; whether we use fractions or a decimal approximation. Sage attempts to be as *exact* as possible and will return a fraction unless you tell it otherwise. If we wish for Sage to return a decimal, then the expression must contain a decimal. ::

	sage: 11/4.0 
	2.75000000000000
	sage: 11/4.
	2.75000000000000
	sage: 11.0/4
	2.75000000000000
	sage: 11/4*1.
	2.75000000000000

**Exercises:**

   #. Divide :math:`28` by :math:`3` raised to the 5th power.
   #. Using exponentiation, find a decimal approximation of :math:`\sqrt{2}`. 
   #. Describes what happens when you compute `(-9)^(1/2)`. 

Now that we have all of the basic arithmetic established we are ready move onto the next section.


.. _division_and_factoring:

Division and Factoring
======================

|		 You should be familiar with ":ref:`basic_arithmetic`"

Sometimes, like when we divide :math:`4` into :math:`14` the division operator doesn't give us all of the information that we need. Sometimes we would like to not just know what the reduced fraction is, or even the decimal approximation, but the unique *quotient* and the *remainder* of the division. To calculate the quotient we use the ``//`` operator and to calculate the remainder we use the ``%`` operator. ::

	sage: 14 // 4
	3
	sage: 14 % 4
	2
				
Note that the quotient operator ``//`` is two backslashes. If we wish to obtain both the quotient and the remainder all at once, we may use the :func:`.divmod` command ::

	sage: divmod(14,4)
	(3, 2)
				
We say that :math:`b` *divides* :math:`a` if we get a remainder of 0 when we divide :math:`a` by :math:`b`. Integers in Sage have a built-in function ( or 'method' ) which allows us to check if an integer divides another: ::

	sage: 3.divides(15)
	True
	sage: 5.divides(17)
	False
				
Along these lines, given an integer we can compute the list of all of it's divisors using the :meth:`.divisors` method. ::

	sage: 12.divisors()
	[1, 2, 3, 4, 6, 12]
	sage: 101.divisors()
	[1,101]
				
When the divisors of an integer are 1 and itself we say it is a prime number. To check if a number is prime in sage, we use the :meth:`.is_prime` method. ::

	sage: (2^19-1).is_prime()
	True
	sage: 153.is_prime()
	False
				
We should take note of the parentheses around the number in the first example, which are important to the order of operations in Sage. Try evaluating ``2^19-1.is_prime()`` and see what happens. 

Related to the divisors of an integer are its prime factors. We use the :meth:`.factor` method to obtain the prime factorization of an integer. ::

	sage: 62.factor()
	2 * 31
	sage: 63.factor()
	3^2 * 7
				
If we are interested in simply knowing which prime numbers divide an integer, we may use the :meth:`.prime_divisors` (or :meth:`.prime_factors`) method. ::

	sage: 24.prime_divisors() 
	[2, 3]
	sage: 63.prime_factors()
	[3, 7]
				
The final fundamental idea in factoring is that of the greatest common
divisor. A common divisor of two integers :math:`a` and :math:`b` is
any integer which is a divisor of each. The greatest common divisor
(gcd), not too surprisingly, is then the greatest integer which
divides each integer. We use the :func:`.gcd` command to calculate the greatest common divisor ::

	sage: gcd(14,63)									
	7
	sage: gcd(15,19)  
	1
				
Notice that if two integers share no common prime factor, then their gcd will be 1. 

Related to the gcd is the least common multiple (lcm) of two
integers. The least common multiple of :math:`a` and :math:`b` is the
smallest integer which is divisible by :math:`a` and :math:`b`. We use
:func:`.lcm` command in Sage to calculate the least common multiple ::

	sage: lcm(4,5)
	20
	sage: lcm(14,21)
	42

**Exercises:**

  #. Find the quotient and remainder when diving :math:`98` into :math:`956`.
  #. Use Sage to verify that the quotient and remainder computed above are correct.  
  #. Use Sage to determine if :math:`3` divides :math:`234878`.
  #. Compute the list of divisors for each of the integers :math:`134,\ 491,\ 422` and :math:`1002`. 
  #. Which of the integers above are *prime*? 
  #. Calculate :math:`\mathrm{gcd}(a,b)`,  :math:`\mathrm{lcm}(a,b)` and :math:`a \cdot b` for the pairs of integers :math:`\left(2,5\right),\ \left(4,10\right)` and :math:`\left(18,51\right)`. How do the gcd, lcm and the product of the numbers relate?


.. _basic_functions_and_constants:

Standard Functions and Constants
================================

|	 You should be familiar with ":ref:`basic_arithmetic`"

Nearly all standard functions that we run into in mathematics are included in Sage. In this section, we shall cover some of the more fundamental functions and constants, including the maximum, minimum, floor, ceiling, trigonometric, exponential, and logarithm functions and the :math:`e`, :math:`\pi` and the golden ratio :math:`\phi` constants. 

The :func:`.max` and :func:`.min` commands return the maximum and minimum of a set of numbers.::

	sage: max(1,5,8)
	8
	sage: min(1/2,1/3)
	1/3
				
We may input any number of arguments into the max and min functions. 

In Sage we use the :func:`abs` command to obtain the absolute value of
a real number ::

	sage: abs(-10)
	10
	sage: abs(4)
	4
				
The :func:`.floor` command rounds down to the nearest integer, while :func:`.ceil` rounds up. Typically we denote the floor function with :math:`\lfloor x \rfloor` and the ceiling by :math:`\lceil x \rceil`.::

	sage: floor(2.1)
	2
	sage: ceil(2.1)
	3
				
We need to be very careful with decimals while using :func:`.floor` and :func:`.ceil`. ::

	sage: floor(1/(2.1-2))
	9
				
This is clearly not correct: :math:`\lfloor 1/(2.1-2)\rfloor = \lfloor 1/.1 \rfloor = \lfloor 10 \rfloor = 10`. So what happened?::

	sage: 1/(2.1-2)
	9.99999999999999
				
Computers use binary notation, while we are accustomed to decimal
notation. The number 2.1 in decimal notation is quite simple and
short, but when converted to binary it is :math:`10.0001\overline{1}=10.0001100110011\ldots`
Since computers cannot store an infinite number of digits, this gets
rounded off somewhere. Resulting in the slight error we saw. In Sage,
however, rational numbers (fractions) have perfect precision, so we
will never see this error. ::

	sage: floor(1/(21/10-2))
	10
				
Due to this, it is a good idea to use rational numbers whenever possible instead of decimals. 

The :func:`.sqrt` command calculates the square root of a real number. As we have seen earlier with fractions, if we want a decimal expression we need to give a decimal input.::

	sage: sqrt(3)
	sqrt(3)
	sage: sqrt(3.0)
	1.73205080756888
	sage: sqrt(8,3)

To compute other roots, we use a rational exponent. Sage can compute any rational power. If either the exponent or the base is a decimal then the output will be a decimal. ::

	sage: 3^(1/2)
	sqrt(3)
	sage: (3.0)^(1/2)
	1.73205080756888
	sage: 8^(1/2)
	2*sqrt(2)
	sage: 8^(1/3)
	2
				
Sage also has available all of the standard trigonometric functions: for sine and cosine we use the familiar :func:`.sin` and :func:`.cos` ::

	sage: sin(1)
	sin(1)
	sage: sin(1.0)
	0.841470984807897
	sage: cos(3/2)
	cos(3/2)
	sage: cos(3/2.0)
	0.0707372016677029
				
Again we see the same behavior that we saw with :func:`sqrt`. Essentially, Sage wants to give us an exact answer; there is, however, no way to simplify ``sin(1)``. So why bother? Well, some expressions involving sine can indeed be simplified. For example, an important identity from geometry is :math:`\sin(\pi/3 ) = 3/2`. Sage has a built-in symbolic :math:`\pi`, and understands this identity::

	sage: pi
	pi
	sage: sin(pi/3)
	1/2*sqrt(3)
				
When we type :obj:`.pi` in Sage we are dealing exactly with :math:`\pi`, not some numerical approximation. However, we can call for a numerical approximation using the :meth:`.n` method::

	sage: pi.n()
	3.14159265358979
	sage: sin(pi)
	0
	sage: sin(pi.n())
	1.22464679914735e-16
				
We see that when using the symbolic `pi` Sage understands the identity
:math:`\sin(\pi ) = 0`. When we use the approximation, however, we get
an approximation back. The ``e-15`` is the shorthand for
:math:`10^{-15}`. Basically 1.22464679914735e-16 should be zero, but
there are errors due to the approximations. Here are a few commonly
known examples of using the symbolic, precise :math:`\pi` vs the numerical
approximation ::

	sage: sin(pi/6)															
	1/2
	sage: sin(pi.n()/6)
	0.500000000000000
	sage: sin(pi/4)
	1/2*sqrt(2)
	sage: sin(pi.n()/4)
	0.707106781186547
				
There are in fact some special angles for which the value of sine or
cosine can be cleverly simplified. ::

	sage: sin(pi/10)					
	1/4*sqrt(5) - 1/4
	sage: cos(pi/5)
	1/4*sqrt(5) + 1/4
	sage: sin(5*pi/12)
	1/12*(sqrt(3) + 3)*sqrt(6)
				
Other trigonometric functions, the inverse trigonometric functions and
hyperbolic functions are also available. ::

	sage: arctan(1.0)
	0.785398163397448
	sage: sinh(9.0)
	4051.54190208279
				
Similar to ``pi`` Sage has a built-in symbolic constant for the number :math:`e`,
the base of the natural logarithm. This constant is named, not surprisingly, ``e`` ::

	sage: e
	e
	sage: e.n()
	2.71828182845905
				
While some might be familiar with using ``ln(x)`` for natural log and
``log(x)`` to represent logarithm base :math:`10`, these both represent logarithms
base :math:`e` written as such. However, with the log function we may specify
a different base as a second argument. Hence to compute :math:`\log_{b}(x)` in
Sage we use the command ``log(x,b)`` ::

	sage: ln(e)
	1
	sage: log(e)
	1
	sage: log(e^2)
	2
	sage: log(10)
	log(10)
	sage: log(10.0)
	2.30258509299405
	sage: log(100,10)
	2
				
Exponentiation base :math:`e` can done using both the :func:`.exp` function and by raising the constant ``e`` to a specified power. ::

	sage: exp(2)
	e^2
	sage: exp(2.0)
	7.38905609893065
	sage: exp(log(pi))
	pi
	sage: e^(log(2))
	2

				
**Exercises:**
  #. Compute the floor and ceiling of :math:`2.75`.
  #. Compute the logarithm base 10 of  :math:`1/1000000`
  #. Compute the logarithm base 2 of :math:`64`
  #. Compare :math:`e^{i \pi}` with a numerical approximation of it using ``pi.n()``. 
  #. Compute :math:`\sin(\pi/2)`, :math:`\cot(0)` and :math:`\csc(\pi/16)`.



.. _variables_equations_inequalities:

Variables, Equations and Inequalities
=====================================

|  You should be familiar with ":ref:`basic_arithmetic`" and ":ref:`basic_functions_and_constants`"

When we use the term 'variable', we can be referring to a couple of
different things. In computer programming, a 'variable' is a space in
memory used to store and retrieve a certain piece of information. In
mathematics we use the term to describe a indeterminate placeholder,
or symbol, which we can manipulate in order to gain insight on a
problem. This is the type of 'variable' in which we are writing in
this section. Sage has special facilities for dealing with these
'variables' which we will often call 'symbolic variables'.	

In Sage we must first declare a symbolic variable before we use
them. This is done by using the :func:`.var` command, which allows for us
to use both simple letters and full words to identify our variables::

	sage: x,y,z,t = var("x y z t")
	sage: phi, theta, rho = var("phi theta rho") 

.. note::
	Variable names cannot contain spaces, for example "square root"
	would not be a valid variable name, but "square_root" would be. 
				
Attempting to use a symbolic variable before it has been declared will
cause Sage to complain about a :exc:`.NameError`. ::

	sage: u
	sage: u
	...
	NameError: name 'u' is not defined
				
We can un-declare a symbolic variable by using the :func:`.restore`
command.::

	sage: restore('phi')
	sage: phi
	...
	NameError: name 'phi' is not defined
				
In Sage, equations and inequalities are defined using the conditional
operators ``==``, ``<=``, and ``>=`` and will return either ``True``, ``False``, or just the equation/inequality. ::

	sage: 9 == 9
	True
	sage: 9 <= 10
	True
	sage: 3*x - 10 == 5
	3*x - 10 == 5
				
We can solve symbolic equations and inequalities by using the, aptly
named, :func:`.solve` command. ::

	sage: solve(3*x - 2 == 5,x)
	[x == (7/3)]
	sage: solve( 2*theta -5 == 1, theta)
	[theta == 3]
	sage: solve( 2*t - 5 >= 17,t)
	[[t >= 11]]
	sage: solve( 3*x -2 > 5, x) 
	[[x > (7/3)]]
				
Equations can have multiple solutions, Sage just returns all solutions found as a list. ::

	sage: solve( x^2 + x  == 6, x)
	[x == -3, x == 2]
	sage: solve(2*x^2 - x + 1 == 0, x)
	[x == -1/4*I*sqrt(7) + 1/4, x == 1/4*I*sqrt(7) + 1/4]
	sage: solve( exp(x) == -1, x)
	[x == I*pi]
				

The solution set of certain inequalities consist of the union and
intersection of open intervals ::

	sage: solve( x^2 - 6 >= 3, x )
	[[x <= -3], [x >= 3]]
	sage: solve( x^2 - 6 <= 3, x )
	[[x >= -3, x <= 3]]
				
Small systems of equations can be solved also and can result in either
a unique solution, infinitely many solutions, or no solutions at all. ::

	sage: solve( [3*x - y == 2, -2*x -y == 1 ], x,y)
	[[x == (1/5), y == (-7/5)]]
	sage: solve( [	2*x + y == -1 , -4*x - 2*y == 2],x,y)
	[[x == -1/2*r1 - 1/2, y == r1]]
	sage: solve( [	2*x - y == -1 , 2*x - y == 2],x,y)	 
	[]
				
In the second equation above, ``r1`` signifies that there is a free
variable which parametrizes the solution set. When there is more than
one free variable, Sage enumerates them ::

	sage: solve([ 2*x + 3*y + 5*z == 1, 4*x + 6*y + 10*z == 2, 6*x + 9*y + 15*z == 3], x,y,z)
	[[x == -5/2*r1 - 3/2*r2 + 1/2, y == r2, z == r1]]
				
Using :func:`.solve` can be very slow for large systems of equations. For these systems, it is best to use the linear algebra functions as they are quite efficient. 

The :func:`.solve` command will attempt to express the solution of an
equation without the use of floating point numbers. If this cannot be
done, it will return the solution in a symbolic form ::
 
	sage: solve( sin(x) == x, x)
	[x == sin(x)]
	sage: solve( exp(x) - x == 0 , x)
	[x == e^x]
	sage: solve( cos(x) - sin(x) == 0 , x)
	[sin(x) == cos(x)]
	sage: solve( cos(x) - exp(x) == 0 , x)
	[cos(x) == e^x]
				
To find a numeric approximation of the solution we can use the
:func:`.find_root` command. Which requires both the expression and a closed
interval on which to search for a solution	::

	sage: find_root(sin(x) == x, -pi/2 , pi/2)
	0.0
	sage: find_root(sin(x) == cos(x), pi, 3*pi/2) 
	3.9269908169872414

This command will only return one solution on the specified interval, if one exists. It will not find the complete solution set over the entire real numbers. 
To find a complete set of solutions, the reader must use ``find_root()`` repeatedly over cleverly selected intervals. Sadly, at this point, Sage cannot do all of the thinking for us. This feature is not planned until Sage 10. :-) 


**Exercises:**

#. Find all of the solutions to the equation :math:`x^3 - x = 7x^2 - 7`.
#. Find the complete solution set for the inequality :math:`\left\vert t - 7 \right\vert \geq 3`.
#. Find all :math:`x` and :math:`y` that satisfy both :math:`2x + y = 17` and :math:`x - 3y = -16`.
#. Use :func:`find_root` to find a solution of the equation :math:`e^{x} = \cos(x)` on the interval :math:`\left[-\pi/2, 0\right]`. 
#. Change the command above so that :func:`find_root` finds the other solution in the same interval.
  

.. _basic_stats:

Basic Statistics
================

|  You should be familiar with :ref:`basic_arithmetic`

In this section we will discuss the use of some of the basic descriptive statistic functions availble for use in Sage. 

To demonstrate their usage we will first generate a psudo-random list
of integers to describe. The :func:`.random` function generates a random
number from :math:`[0,1)`, so we will use a trick. Note, by the nature
of random number generation your list of numbers will be different. ::

	sage: data = [	floor(tan( pi* random() - pi/2.1 )) for i in [ 1 .. 20 ] ] 
	sage: data																   
	[1, -1, -7, 0, -4, -1, -2, 1, 3, 5, -1, 
	25, -5, 1, 2, 0, 1, -1, -1, -1]
					
We can compute the mean, median, mode, variance, and standard
deviation of this data. ::

	sage: mean(data)
	3/4
	sage: median(data)
	-1/2
	sage: mode(data)  
	[-1]
	sage: variance(data)
	3023/76
	sage: std(data)		
	1/2*sqrt(3023/19)
					
Note that both the standard deviation and variance are computed in their unbiased forms. It we want to bias these measures then you can use the ``bias=True`` option. 

We can also compute a rolling, or moving, average of the data with the :func:`.moving_average`. ::

	sage: moving_average(data,4)
	[-7/4, -3, -3, -7/4, -3/2, 1/4, 7/4, 2, 8, 6, 5, 23/4, 
	-1/2, 1, 1/2, -1/4, -1/2]
	sage: moving_average(data,10)
	[-1/2, -7/10, 19/10, 21/10, 11/5, 14/5, 29/10, 16/5, 3, 13/5, 2]
	sage: moving_average(data,20)
	[3/4]

**Exercises:**

  #. Use Sage to generate a list of 20 random integers. 
  #. The heights of eight students, measured in inches, are :math:`71,\ 73,\  59,\ 62,\ 65,\ 61,\ 73,\ 61`. Find the *average*, *median* and *mode* of the heights of these students. 
  #. Using the same data, compute the *standard deviation* and *variance* of the sampled heights.
  #. Find the *range* of the heights. (*Hint: use the* :func:`max` *and* :func:`min` *commands*) 
  

.. _basic_plotting:

Plotting
========

.. _2d_plotting_and_graphics:

2D Graphics
-----------

|  You should be familiar with :ref:`basic_functions`

Sage has many ways for us to visualize the mathematics with which we are working. In this section we will quickly get the reader up to speed with some of the basic commands used when plotting functions and working with graphics.

To produce a basic plot of :math:`\sin(x)` from :math:`x=-\frac{\pi}{2}` to :math:`x=\frac{\pi}{2}` we will use the :func:`.plot()` command.::

	sage: f(x) = sin(x)
	sage: p = plot(f(x), (x, -pi/2, pi/2))
	sage: p.show()
				
.. image:: pics/sin_plot.png
        :alt: Plot of sin(x) from x = -pi/2 to pi/2 
	:width: 400px
	:height: 300px
 
By default, the plot created will be quite plain. To add axis labels
and make our plotted line purple, we can alter the plot attribute by
adding the ``axes_labels`` and ``color`` options ::

	sage: p = plot(f(x), (x,-pi/2, pi/2), axes_labels=['x','sin(x)'], color='purple') 
	sage: p.show()

.. image:: pics/sin_plot_purple_labels.png
        :alt: Plot of sin with purple line and basic axis labels
	:width: 400px
	:height: 300px

The ``color`` option accepts string color designations ( 'purple', 'green', 'red', 'black', etc...), an RGB triple such as (.25,.10,1), or an HTML-style hex triple such as #ff00aa.

We can change the style of line, whether it is solid, dashed, and it's thickness by using the ``linestyle`` and the ``thickness`` options.::

	sage: p = plot(f(x), (x,-pi/2, pi/2), linestyle='--', thickness=3) 
	sage: p.show()
				
.. image:: pics/sin_plot_dashed_thick.png 
	:alt: Plot of sin(x) using a thick dashed blue line
	:width: 400px
	:height: 300px

We can display the graphs of two functions on the same axes by adding the plots together.::

	sage: f(x) = sin(x)
	sage: g(x) = cos(x)
	sage: p = plot(f(x),(x,-pi/2,pi/2), color='black')
	sage: q = plot(g(x), (x,-pi/2, pi/2), color='red')
	sage: r = p + q 
	sage: r.show()
				
.. image:: pics/sin_cos_plot.png
	:alt: Plot of sin(x) and cos(x) on the same axes
	:height: 300px
	:width: 400px

To tie together our plotting commands with some material we have
learned earlier, let's use the ``find_root()`` command to find the
point where :math:`\sin(x)` and :math:`\cos(x)` intersect. We will then add this point to the graph and label it. ::

	sage: find_root( sin(x) == cos(x),-pi/2, pi/2 )
	0.78539816339744839
	sage: P = point( [(0.78539816339744839, sin(0.78539816339744839))] )
	sage: T = text("(0.79,0.71)", (0.78539816339744839, sin(0.78539816339744839) + .10))
	sage: s = P + r + T						
	sage: s.show()
				
.. image:: pics/sin_cos_point_plot.png
	:alt: sin(x) and cos(x) on same axes with point of intersection labeled
	:height: 300px
	:width: 400px

Sage handles many of the details of producing "nice" looking plots in
a way that is transparent to the user. However there are times in
which Sage will produce a plot which isn't quite what we were
expecting. ::

	sage: f(x) = (x^3 + x^2 + x)/(x^2 - x -2 )
	sage: p = plot(f(x), (x, -5,5))
	sage: p.show()
				
.. image:: pics/rat_func_with_asymptotes.png
	:alt: Plot of rational function with asymptotes
	:width: 400px
	:height: 300px

The vertical asymptotes of this rational functions cause Sage to
adjust the aspect ratio of the plot to display the rather large y
values near :math:`x=-1` and :math:`x=2`. This however obfuscates most of the features
of this function in a way that we may have not intended. To remedy
this we can explicitly adjust the vertical and horizontal limits of
our plot ::

	sage: p.show(xmin=-2, xmax=4, ymin=-20, ymax=20)

.. image:: pics/rat_func_with_asymptotes_adj.png
	:alt: Plot of rational function with asymptote with vertical limits adjusted
	:width: 400px
	:height: 300px

Which, in the author's opinion, displays the features of this particular function in a much more pleasing fashion.

Sage can handle parametric plots with the :func:`.parametric_plot` command. The following is a simple circle of radius 3::

	sage: t = var('t')
	sage: p = parametric_plot( [3*cos(t), 3*sin(t)], (t, 0, 2*pi) )
	sage: p.show()
				
.. image:: pics/parametric_circle.png
	:alt: Circle of radius 3 centered at the origin
	:width: 400px
	:height: 300px

The default choice of aspect ratio makes the plot above decidedly
"un-circle like". We can adjust this by using the ``aspect_ratio``
option ::

	sage: p.show(aspect_ratio=1)
				

.. image:: pics/parametric_circle_fixed.png
	:alt: Circle of radius 3 with 1/1 aspect ratio
	:width: 400px
	:height: 300px

The different plotting commands accept many of the same options as
plot. The following generates the Lissajous Curve :math:`L(3,2)` with
a thick red dashed line. ::

	sage: p = parametric_plot( [sin(3*t), sin(2*t)], (t, 0, 3*pi), thickness=2, color='red', linestyle="--") 
	sage: p.show()
				
.. image:: pics/L3,2-red.png
	:alt: Lissajous Curve L(3,2)
	:width: 400px
	:height: 300px

Polar plots can be done using the :func:`.polar_plot` command ::

	sage: theta = var("theta")						 
	sage: r(theta) = sin(4*theta)					 
	sage: p = polar_plot((r(theta)), (theta, 0, 2*pi) )
	sage: p.show()
				
.. image:: pics/8petal-polar.png
	:alt: Eight Petal 'folium' curve
	:width: 400px
	:height: 300px

**Exercises:**

  #. Plot the graph of :math:`y = \sin\left(\pi x - \pi  \right)` for :math:`-1 \leq x \leq 1` using a thick red line.
  #. Plot the graph of :math:\cos\left(\pi x - \pi \right)` on the same interval using a thick blue line. 
  #. Plot the two graphs above on the same set of axes. 
  #. Plot the graph of :math:`y = 1/x` for :math:`-1 \leq x \leq 1` adjusting the range so that only :math:`-10 \leq y \leq 10`. 
  #. Use the commands in this section to produce the following image:

  .. image:: pics/circles.png 
     :alt: Two circles of radius 3. 
     :width: 400px
     :height: 300px

.. _3d_plotting:

3D Plotting
-----------

Producing 3D plots can be done using the :func:`.plot3d` command ::

	sage: x,y = var("x y")
	sage: f(x,y) = x^2 - y^2
	sage: p = plot3d(f(x,y), (x,-10,10), (y,-10,10))				 
	sage: p.show()
				
.. image:: pics/3d-plot-1.png
	:alt: Snapshot of 3D plot
	:width: 400px
	:height: 300px

Sage handles 3d plotting a bit differently than what we have seen thus far. It uses a program named jmol to generate interactive plots. So instead of just a static picture we will see either a window like pictured above or, if you are using Sage's notebook interface, a java applet in your browser's window.

One nice thing about the way that Sage does this is that you can rotate your plot by just clicking on the surface and dragging it in the direction in which you would like for it to rotate. Zooming in/out can also be done by using your mouse's wheel button (or two-finger vertical swipe on a mac). Once you have rotated and zoomed the plot to your liking, you can save the plot as a file. Do this by right-clicking anywhere in the window/applet and selecting save, then png-image as pictured below

.. image:: pics/3d-plot-2.png
	:alt: Saving a 3d plot to a file in Jmol
	:width: 400px
	:height: 300px

.. note:: 
		If you are running Sage on windows or on sagenb.org that your file will be saved either in your VMware virtual machine or on sagenb.org.


