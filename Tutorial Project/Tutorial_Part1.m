% Part 1
t = linspace(-10,10,20/0.001);
x3 = zeros(1,20/0.001);
x30 = zeros(1,20/0.001);
x300 = zeros(1,20/0.001);

for n = 1:3
    x3 = x3 + (-1)^n / (pi * n) * sin(0.4*pi*t*n);
end

for n = 1:30
    x30 = x30 + (-1)^n / (pi * n) * sin(0.4*pi*t*n);
end

for n = 1:300
    x300 = x300 + (-1)^n / (pi * n) * sin(0.4*pi*t*n);
end

figure
subplot(3,1,1)
plot(t,x3)
title('3 Terms')
xlabel('t')
ylabel('x(t)')

subplot(3,1,2)
plot(t,x30)
title('30 Terms')
xlabel('t')
ylabel('x(t)')

subplot(3,1,3)
plot(t,x300)
title('300 Terms')
xlabel('t')
ylabel('x(t)')

% x(t) is a sawtooth wave
% We see that with additional terms, the function becomes more defined and
% closer to the sawtooth wave expected.