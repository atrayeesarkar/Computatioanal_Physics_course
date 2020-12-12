x = load('data.csv');% given data series
n = length(x); % length of the data
y = zeros(1,n);% initializing new dataset y
for i =1:n-1 
    y(i)= (x(i)+x(i+1))/2;
end 
y(n) = (x(n)+x(1))/2;%pbc

fs = 50; % sample frequence = 100Hz 
trans = fft(y); %discrete fourier transform
mag = abs(trans); 
power = mag.^2/n;% power spectrum 
f = (0:n-1)*(fs/n); % frequency range, x axis 
figure
hold on
plot(f,power)
xlabel('Frequency')
ylabel('Power')
grid on 
