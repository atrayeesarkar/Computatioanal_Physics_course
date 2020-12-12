#include <iostream> 
#include <fstream> 
#include <math.h>

int main(){
    int n = 10; // initializing n for nxn matrix
    double N = 10.0; // initializing double N fro the equation so that we can divide 
    double I[n][n]; // initializing identity matrix
    double A[n][n]; // initializing matrix A
    double log_A[n][n]; // initializing log(A)
    double x[n][n]; // x = I-A
    double y[n][n]; // y = (I-A)^k/k
    double K; // to divide with k in the series we need float
    double multi[n][n]; // initializing multiplication storage matrix
    std::ofstream cfile("Q4c_cpp.txt");  //cfile is the file we will print bifurcation data
    cfile<<"The calculated value of log(A) is :"<<'\n';
    // --------------defining I------------

    for (int i = 0; i<n; i++){
        for (int j = 0;j<n; j++  ){
            I[i][j] = 0.0;
        }
        I[i][i] = 1.0;
        
    }
    //-------------------defining A---------------
    for(int i = 0;i<n;i++){
        for (int j = 0;j<n;j++ ){
            A[i][j] = 1/(N+1)+I[i][j]/(N+1);
            }
        }
    
    // -----------defining x---------------
    for(int i = 0;i<n;i++){
            for (int j = 0;j<n;j++ ){
                x[i][j] = (I[i][j]-A[i][j]);   
               
            }
           
    }

    double x1[n][n]; // x1= x; need x1 to compute x^k
    //-----------defining x1-------------
    for(int i = 0;i<n;i++){
            for (int j = 0;j<n;j++ ){
                x1[i][j] = x[i][j];    
            }
    }
    //--------- initializing log(A) as 10x 10 0 matrix 
    for(int i = 0;i<n;i++){
            for (int j = 0;j<n;j++ ){
                log_A[i][j] = 0.0;
            }
    }

    K = 1.0;
     for(int k = 1; k <= 200;k++ ){ // main for loop for summation over k in eqn 1
        for(int i = 0;i<n;i++){          // need these 2 loops to divide x^k by k. for k = 1, x = (I-A)^1
            for (int j = 0;j<n;j++ ){
                y[i][j] = (x[i][j]/K);    
            }
            
        } 
        for(int i = 0;i<n;i++){ // these two loops are for adding the series elements 
            for (int j = 0;j<n;j++ ){
            log_A[i][j] = log_A[i][j]-y[i][j];
            }
        }    
    //--------initializing multiplicaton storage matrix---------
        for(int i = 0; i < n; ++i){  
            for(int j = 0; j < n; ++j){
            multi[i][j]=0;
            }
        }
        for(int i = 0;i<n;i++){ // these three loops are for matrix multiplicaion x^k
            for (int j = 0;j<n;j++ ){
                for (int l = 0;l<n;l++){
                    multi[i][j]+= (x[i][l]*x1[l][j]); 
                }  
            }
              } 
        for(int i = 0;i<n;i++){ // these two loops are for updating x
            for (int j = 0;j<n;j++ ){
                x[i][j] = multi[i][j];
                
            }
            
        }
        
       
         K = K+1.0; // increasing K value in accordance to k value
       
     }
    for(int i = 0;i<n;i++){
        for (int j = 0;j<n;j++ ){
            cfile<<log_A[i][j]<<'\t';
            }
            cfile<<'\n';
        }
        cfile<<'\n';

cfile.close();
 return 0;   
}

