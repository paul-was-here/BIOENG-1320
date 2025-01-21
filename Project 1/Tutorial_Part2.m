%Paul Kullmann & Waleed Sabri

N = 300; %choose number of summations here

%Variable definitions
times = -10:0.001:10;
freqs = (1:N)*(0.4*pi);
amplitudes = ones(N).*(-1).^(1:N) ./ (pi.*(1:N));

%Function call
x = fourierSeries(amplitudes, freqs, times);

%Plotting
plot(times,x);
title(strcat(num2str(N), " Sums"));
xlabel('t');
ylabel('x(t)');

%Function defenition
function [x] = fourierSeries(a, w, t)
    x = a * sin(transpose(w)*t);
end