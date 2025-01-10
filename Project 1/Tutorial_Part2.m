N = 300; %choose number of summations here

times = -10:0.001:10;
freqs = (1:N)*(0.4*pi);
amplitudes = ones(N).*(-1).^(1:N) ./ (pi.*(1:N));

x = amplitudes * sin(transpose(freqs)*times);

plot(times,x);
title(strcat(num2str(N), " Sums"));
xlabel('t');
ylabel('x(t)');