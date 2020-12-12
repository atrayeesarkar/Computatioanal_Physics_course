import numpy as np
from numpy.linalg import matrix_power
n = 10
N = 10.0
I = np.zeros([n,n],dtype = float)
f = open('Q4c_py.txt','w')
f.write("The calculated value of log(A) is :\n")
for i in range(n):
    I[i,i] = 1.0
A = 1/(n+1)+I/(n+1)
log_A = 0

for j in range(1,201):
    log_A = log_A - matrix_power((I-A),j)/j

for i in range(0,n):
    for j in range(0,n):
        f.write("%f\t" % (log_A[i,j]))
    f.write('\n')
    
f.close()
