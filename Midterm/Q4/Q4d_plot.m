t1 = load('Q4d_m.txt');
t2 = load('Q4d_py.txt');
t3 = load('Q4d_cpp.txt');

figure
hold on
grid on

loglog(t1(1,:),t1(2,:),'b.')
loglog(t1(1,:),t2(1,:),'r.')
loglog(t1(1,:),t3(1,:),'k.')
comp = 201.*t1(1,:).^2.*(1-t1(1,:))+t1(1,:).^301;
loglog(t1(1,:),comp,'y.')

legend('matlab','pyhton','c++','complexity');
xlabel('n');
ylabel('run time in secs');