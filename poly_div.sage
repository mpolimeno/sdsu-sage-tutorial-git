# Define the field which the polynomial ring is defined over 
# and the number of variables. 

K = GF(2)
n = 2
# Define the polynomial ring
# options for term orderings are 
# ``order`` -- string or ``TermOrder`` object, e.g.,
#    
#         * ``'degrevlex'`` (default) -- degree reverse lexicographic
#    
#         * ``'lex'``  -- lexicographic
#    
#         * ``'deglex'`` -- degree lexicographic
#    
#         * ``TermOrder('deglex',3) + TermOrder('deglex',3)`` -- block
#          ordering

P.<x,y> = PolynomialRing(F,2,order="lex")

#determines if one monomial divides the other
def does_divide(m1,m2):
    for c in (vector(ZZ, m1.degrees()) - vector(ZZ,m2.degrees())):
        if c < 0:
            return False
    return True

# Input: sequence of polynomials f_i.
F  = [x^2 + x,  y^2 + y]

# Input: the polynomial we reduce modulo the f_i.
f = x^3* y^2

# Output:  The quotients a_i and remainder r so that 
# f = sum a_i f_i + r, and no terms of r are divisible 
# by any of the LT(f_i). 

# Here we initialize to 0.

A =  [P(0) for  i in range(0,len(F)) ]
r  = P(0)


# A local copy of f that we be will altered until it is 0.
p = f


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
        

