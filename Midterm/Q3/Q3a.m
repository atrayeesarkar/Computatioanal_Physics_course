x = load('data.csv');% given data series
n = length(x); % length of the data
fs = 100; % sample frequence = 100Hz 
trans = fft(x); %discrete fourier transform
mag = abs(trans); 
power = mag.^2/n;% power spectrum 
f = (0:n-1)*(fs/n); % frequency range, x axis 
figure
hold on
plot(f,power)
xlabel('Frequency')
ylabel('Power')
grid on 
