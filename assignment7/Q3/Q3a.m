%x'' = -Ex
E = 0.1;

x0 = 0.0;%x(0)
x1 = 1.0;%x'(0)
X = [x0,x1];
tmax = pi;
dt = 0.0001;
niter = tmax/dt +1;
sampleTimes = (1:(niter+1))*dt;
result = x0;
tolerance = 0.001;
t = 0;
b_E =1;
while b_E > tolerance
    param = -E;
for i = 1:niter
%     d = deriv(X,param);
    X = rk4(X,t,dt,'deriv',param);
    result = [result,X(1)];
    t = t+dt;
end
 b_E = X(1); % b(E) = x(pi);
 %------------%
 dE = 0.01;
 result1 = x0;
 param1 =-(E+dE);
 t = 0;
for i = 1:niter
%     d = deriv(X,param);
    X = rk4(X,t,dt,'deriv',param1);
    result1 = [result1,X(1)];
    t = t+dt;
end
b_EdE = X(1);  % b(E+dE) = x(pi)
deriv_b = (b_EdE-b_E)/dE;%b'(E) ≈ (b(E + dE) − b(E))/dE

%-------------%
tol = 10^-10;
%* Set initial guess and parameters
% x0 = input('Enter the initial guess (row vector): ');
% x = x0;  % Copy initial guess
% 
% %* Loop over desired number of steps 
% nStep = 50;   % Number of iterations before stopping
% for i=1:nStep
% 	
%   %* Evaluate function f and its Jacobian matrix D
%   [f,D] = fnewt(x);      % fnewt returns value of f and D
%   %* Find dx by Gaussian elimination
%   dx = f/D; 
%   %* Update the estimate for the root  
%   x1 = x - dx;              % Newton iteration for new x
% %  sqrt((x1(1)-x(1))^2+(x1(2)-x(2))^2)
%   if norm(x1-x)<tol % stop if tolerance is reached
%       disp(x1)
%       break
%   end 
%   x = x1;
% end
% [y,~] = fnewt(x); 
% 

E = E-b_E/deriv_b;
 
 
end
