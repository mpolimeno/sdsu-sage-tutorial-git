 # Codes:
 #        The Factorization of x^n -  1 over GF(q) 
 #        and the order of q mod n.
 #        Idempotent polynomials and generator polynomials

# // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# //	Cyclic Codes:
# //        The Factorization of x^n -  1 over GF(q) 
# //           and the order of q mod n.
# //        Idempotent polynomials and generator polynomials
# // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# //  *************************************
# //      The smallest field containing GF(q) and containing the roots of x^n - 1
# //        is GF(q^t) where t is the order of q in Z mod n.
# //      The factors of x^n - 1 over GF(q) must all have degree dividing t.
# //  *************************************
n = 19

# // **********
# // Over GF(2)

F = GF(2)
P.<x> = PolynomialRing(F)

A = factor(x^n-1); A

// Compare with 

Integers(19)(2).additive_order()

# // **********
# // Over GF(4)

q = 4
F.<a> = GF(4)
P.<x> = PolynomialRing(F)

A = factor(x^n-1); A

# // **********
# // Exercises
# // 1. Try GF(8).
# // 2. Observe the order of 2, 4, 8 mod 19
# // 3.  Try other values of n and other fields.

# // **************************************
# //		Idempotents
# // **************************************
# // We'll find the idempotent which is 1 modulo the ith factor
# // of x^n-1 and 0 mod the others.

# // Continuing with GF(4), or vary as you wish
# // Here we create the quotient ring.


# R.<y> = P.quotient(x^n -1)   # // y is the equivalence class of x.

# A = [ A[i][1] for i in range(1,len(A)) ]   # //  A is the factorization found above.
# i = len(A)			   # //  Try different values of i in [1..#A].
# a = A[i]			# // The ith factor
# ap = map(prod, [ A[j] for j in range(0,len(A)) if  j != i ])
# d, b, bp = xgcd( a, ap )

# # // Check that b*a is 0 mod A[i] and  1 mod all A[j] for  j ne i (here j=1).

# b*a mod A[i];
# j := 1; b*a mod A[j];

# // Check that bp*ap is 1 mod A[i] and  0 mod all A[j] for  j ne i (here j=1).
# bp*ap mod A[i];
# j := 1; bp*ap mod A[j];

# //  Check idempotent in R
# f := R !(B2*Ap);
# f eq f^2;

# //***********
# // Check generator polynomial
# GCD(b*a, x^n-1); A[i];

# // We know that b*a is idempotent.  
# // It is easy to see that (b*a)^t = b*a for all positive t.
# // Since the coefficients are in F_q we have b*a(x^q) = ( b*a(x) )^q.
# // Thus b*a (x^q) = b*a(x).
# R ! Evaluate(b*a, x^q);
# R ! (b*a) ;

# // Exercises
# // 1. Experiment with other base fields and values of n.


# // For reciprocal polys of idempotents see
# // Theorem 5 MacWilliams and Sloane p. 219
