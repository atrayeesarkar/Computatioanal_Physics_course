n = [10,20,50,100,200,500,1000,2000];
[~,m] = size(n);
time= zeros(1,m);
% F = fopen('Q4d_m.txt','a');
for j = 1:m
    tic
    I = zeros(n(j),n(j));
    for i = 1:n(j)
        I(i,i) = 1;
    end 
    A = 1/(n(j)+1)+I/(n(j)+1);
    log_A = 0;
    for k = 1:200
        log_A = log_A -((I-A)^k)/k;
    end
    time(j)= toc; 
    
end 
% fprintf(F,'%f \t',n);
% fprintf(F, '\n');
% fprintf(F,'%f \t',time);
% F.close()