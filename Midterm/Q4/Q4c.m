n = 10;
I = zeros(n,n);
F = fopen('Q4c_m.txt','w'); 
fprintf(F,"The calculated value of log(A) is :\n");
for i = 1:n
    I(i,i) = 1;
end 
A = 1/(n+1)+I/(n+1);
log_A = 0;
for j = 1:200
    log_A = log_A -((I-A)^j)/j;
end
for i = 1:n
    for j = 1:n
        fprintf(F,'%f\t',log_A(i,j));
    end 
    fprintf(F,'\n');
end 
fclose(F);
