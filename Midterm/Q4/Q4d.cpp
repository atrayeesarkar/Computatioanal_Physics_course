#include <iostream> 
#include <fstream> 
#include <math.h>
#include<ctime>

int main(){
    int n[8] = {10,20,50,100,120,150,200,220}; // initializing n for nxn matrix I HAVE   USED A DIFFERENT N MATRIX THAN IN QUESTION BECAUESE THE CODE IS GIVING SEGMENTATION ERROR 11 FOR n >= 500
  
    double Time[8] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    time_t tstart, tend; 
    std::ofstream cfile("Q4d_cpp.txt");  //cfile is the file we will print bifurcation data
    for (int p = 0;p<8;p++){
          
        tstart = time(0);
        int N = n[p]; // initializing double N fro the equation so that we can divide 
        double I[N][N]; // initializing identity matrix
        double A[N][N]; // initializing matrix A
        double log_A[N][N]; // initializing log(A)
        double x[N][N]; // x = I-A
        double y[N][N]; // y = (I-A)^k/k
        double K; // to divide with k in the series we need float
        double multi[N][N]; // initializing multiplication storage matrix
        
    //--------------defining I------------

         for (int i = 0; i<N; i++){
             for (int j = 0;j<N; j++  ){
                I[i][j] = 0.0;
             }
             I[i][i] = 1.0;
         }
        
    
    
    //-------------------defining A---------------
        for(int i = 0;i<n[p];i++){
            for (int j = 0;j<n[p];j++ ){
                A[i][j] = 1/(N+1)+I[i][j]/(N+1);
                }
            }
    
    // -----------defining x---------------
    for(int i = 0;i<N;i++){
            for (int j = 0;j<N;j++ ){
                x[i][j] = (I[i][j]-A[i][j]);   
               
            }
           
    }

    double x1[N][N]; // x1= x; need x1 to compute x^k
    //-----------defining x1-------------
    for(int i = 0;i<N;i++){
            for (int j = 0;j<N;j++ ){
                x1[i][j] = x[i][j];    
            }
    }
    //--------- initializing log(A) as 10x 10 0 matrix 
    for(int i = 0;i<N;i++){
            for (int j = 0;j<N;j++ ){
                log_A[i][j] = 0.0;
            }
    }

    K = 1.0;
     for(int k = 1; k <= 200;k++ ){ // main for loop for summation over k in eqn 1
        for(int i = 0;i<N;i++){          // need these 2 loops to divide x^k by k. for k = 1, x = (I-A)^1
            for (int j = 0;j<N;j++ ){
                y[i][j] = (x[i][j]/K);    
            }
    
        } 
     }
        for(int i = 0;i<N;i++){ // these two loops are for adding the series elements 
            for (int j = 0;j<N;j++ ){
            log_A[i][j] = log_A[i][j]-y[i][j];
            }
        }    
    //--------initializing multiplicaton storage matrix---------
        for(int i = 0; i < N; ++i){  
            for(int j = 0; j < N; ++j){
            multi[i][j]=0;
            }
        }
        for(int i = 0;i<N;i++){ // these three loops are for matrix multiplicaion x^k
            for (int j = 0;j<N;j++ ){
                for (int l = 0;l<N;l++){
                    multi[i][j]+= (x[i][l]*x1[l][j]); 
                }  
            }
              } 
        for(int i = 0;i<N;i++){ // these two loops are for updating x
            for (int j = 0;j<N;j++ ){
                x[i][j] = multi[i][j];
                
            }
            
        }
        
       
          K = K+1.0; // increasing K value in accordance to k value
       
    
    tend = time(0);
    Time[p] = difftime(tend,tstart); 
    }
    for(int i = 0;i<8;i++){
        cfile<<Time[i]<<'\t';
         }
    cfile<<'\n';
           

 cfile.close();
 return 0;   
}

