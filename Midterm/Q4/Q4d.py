import numpy as np
import math
import time
from numpy.linalg import matrix_power
n = [10,20,50,100,200,500,1000,2000]
Time = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
# N = 10.0


f = open('Q4d_py.txt','w')

for p in range(8):
    I = np.zeros([n[p],n[p]],dtype = float)
    tic = time.time()
    for i in range(n[p]):
        I[i,i] = 1.0
    A = 1/(n[p]+1)+I/(n[p]+1)
    log_A = 0

    for j in range(1,201):
        log_A = log_A - matrix_power((I-A),j)/j

    # for i in range(0,n[p]):
    #     for j in range(0,n[p]):
    #         f.write("%f\t" % (log_A[i,j]))
    #     f.write('\n')
    toc = time.time()
    Time[p] = toc-tic
for i in range(0,8):
        f.write("%f\t" % (Time[i]))
f.close()
