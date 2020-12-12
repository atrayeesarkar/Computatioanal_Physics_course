delta_t = 0.01;% time increment 
t_f = 50; % ending time 
t = 0:delta_t:t_f; %time array 
[~,N] = size(t); % N  = no of elements in t array = no of x values to be calculated
%----------- Start Verlet----------------%
r1 = zeros(2,N);% initialixing position array
r2 = zeros(2,N);% initialixing position array
r3 = zeros(2,N);% initialixing position array

v1 = zeros(2,N);%initializing velocity array
v2 = zeros(2,N);%initializing velocity array
v3 = zeros(2,N);%initializing velocity array


r1(1,1) = 0.01; r1(2,1) = 0.0; % initial position
r2(1,1) = 0.0; r2(2,1) = 1.0; % initial position
r3(1,1) = 0.0; r3(2,1) = -1.0; % initial position

v1(1,1) = 0.0; v1(2,1) = 0.0; % initial velocity
v2(1,1) = 1.0; v2(2,1) = 0.0; % initial velocity
v3(1,1) = -1.0; v3(2,1) = 0.0; % initial velocity

%acceleration ai(n) = sum_j (-(ri(n)-rj(n))/(ri(n)-rj(n))^3)

%Verlet method: 
%r0 = r1 - tau*v1 - tau^2*a(r1)/2
% rn+1 = 2rn - rn-1 + tau^2 an
%vn = (rn+1 - rn-1)/2

r10(:,1) = r1(:,1)-delta_t*v1(:,1)-((delta_t)^2/2)* (-((r1(:,1)-r2(:,1))/(norm(r1(:,1)-r2(:,1)))^3)-((r1(:,1)-r3(:,1))/(norm(r1(:,1)-r3(:,1)))^3)); % this is needed to find x_2. x0 here denotes x(t<0). 
r1(:,2) = 2*r1(:,1)-r10(:,1)+(delta_t)^2*(-(r1(:,1)-r2(:,1))/(norm(r1(:,1)-r2(:,1)))^3-(r1(:,1)-r3(:,1))/(norm(r1(:,1)-r3(:,1)))^3); % writing this outside for loop because we need x0 value for only this case.

r20(:,1) = r2(:,1)-delta_t*v2(:,1)-((delta_t)^2/2)* (-(r2(:,1)-r1(:,1))/(norm(r1(:,1)-r2(:,1)))^3-(r2(:,1)-r3(:,1))/(norm(r2(:,1)-r3(:,1)))^3); % this is needed to find x_2. x0 here denotes x(t<0). 
r2(:,2) = 2*r2(:,1)-r20(:,1)+(delta_t)^2*(-(r2(:,1)-r1(:,1))/(norm(r1(:,1)-r2(:,1)))^3-(r2(:,1)-r3(:,1))/(norm(r2(:,1)-r3(:,1)))^3); % writing this outside for loop because we need x0 value for only this case.

r30(:,1) = r3(:,1)-delta_t*v3(:,1)-(delta_t)^2/2* (-(r3(:,1)-r2(:,1))/(norm(r2(:,1)-r3(:,1)))^3-(r3(:,1)-r1(:,1))/(norm(r1(:,1)-r3(:,1)))^3); % this is needed to find x_2. x0 here denotes x(t<0). 
r3(:,2) = 2*r3(:,1)-r30(:,1)+(delta_t)^2*(-(r3(:,1)-r2(:,1))/(norm(r2(:,1)-r3(:,1)))^3-(r3(:,1)-r1(:,1))/(norm(r1(:,1)-r3(:,1)))^3); % writing this outside for loop because we need x0 value for only this case.



 for i=3:N
 r1(:,i) = 2*r1(:,i-1)-r1(:,i-2)+(delta_t)^2*(-(r1(:,i-1)-r2(:,i-1))/(norm(r1(:,i-1)-r2(:,i-1)))^3-(r1(:,i-1)-r3(:,i-1))/(norm(r1(:,i-1)-r3(:,i-1)))^3);
 r2(:,i) = 2*r2(:,i-1)-r2(:,i-2)+(delta_t)^2*(-(r2(:,i-1)-r1(:,i-1))/(norm(r1(:,i-1)-r2(:,i-1)))^3-(r2(:,i-1)-r3(:,i-1))/(norm(r2(:,i-1)-r3(:,i-1)))^3);
 r3(:,i) = 2*r3(:,i-1)-r3(:,i-2)+(delta_t)^2*(-(r3(:,i-1)-r2(:,i-1))/(norm(r2(:,i-1)-r3(:,i-1)))^3-(r3(:,i-1)-r1(:,i-1))/(norm(r1(:,i-1)-r3(:,i-1)))^3);
 
 v1(:,i-1) = (r1(:,i)-r1(:,i-2))/(2*delta_t); 
 v2(:,i-1) = (r2(:,i)-r2(:,i-2))/(2*delta_t);
 v3(:,i-1) = (r3(:,i)-r3(:,i-2))/(2*delta_t);
 end
r1_Nplus1(:,1) = 2*r1(:,N)-r1(:,N-1)+(delta_t)^2*(-(r1(:,N)-r2(:,N))/(norm(r1(:,N)-r2(:,N)))^3-(r1(:,N)-r3(:,N))/(norm(r1(:,N)-r3(:,N)))^3);
r2_Nplus1(:,1) = 2*r2(:,N)-r2(:,N-1)+(delta_t)^2*(-(r2(:,N)-r1(:,N))/(norm(r1(:,N)-r2(:,N)))^3-(r2(:,N)-r3(:,N))/(norm(r2(:,N)-r3(:,N)))^3);
r3_Nplus1(:,1) = 2*r3(:,N)-r3(:,N-1)+(delta_t)^2*(-(r3(:,N)-r2(:,N))/(norm(r2(:,N)-r3(:,N)))^3-(r3(:,N)-r1(:,N))/(norm(r1(:,N)-r3(:,N)))^3);
 
v1(:,N) = (r1_Nplus1-r1(:,N-1))/(2*delta_t); % since v(N) is not set by the for loop
v2(:,N) = (r2_Nplus1-r2(:,N-1))/(2*delta_t);
v3(:,N) = (r3_Nplus1-r3(:,N-1))/(2*delta_t);


T1 = 1/2*v1.^2;
T2 = 1/2*v2.^2;
T3 =  1/2*v3.^2;
ke = T1+T2+T3;
T = zeros(1,N);
U = zeros(1,N);
for i = 1:N
    T(i) = sum(ke(:,i));
    U(i) = -(1/norm(r1(:,i)-r2(:,i))+1/norm(r2(:,i)-r3(:,i))+1/norm(r1(:,i)-r3(:,i)));
end

E = U+T;

figure 
hold on
grid on 
 
plot(t,T,'b.')
plot(t,U,'k.')
plot(t,E,'r.')
legend('Kinetic Energy','Potential Energy', 'Total Energy')
 
 xlabel('t ')
  ylabel('energy(t)')
% grid on 
figure 
hold on   
grid on
xlabel('x1(t),x2(t),x3(t) ')
ylabel('y1(t),y2(t),y3(t)')
plot(r1(1,:), r1(2,:), 'k.')
plot(r2(1,:), r2(2,:), 'b.')
plot(r3(1,:), r3(2,:), 'r.') 
 
 
