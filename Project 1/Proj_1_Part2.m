% MATLAB Project 1 - Part 2
% Paul Kullmann & Ani Kulkarni

% Importing data
data = load('ecg.mat');
h = load('ecgfilter.mat');
clean = data.clean;
noisy = data.noisy;
filter = h.h;

% Plotting prior to filtering
subplot(2,2,1)
plot(clean(:,1), clean(:,2));
title("Subject at rest (clean)")

subplot(2,2,2)
plot(noisy(:,1), noisy(:,2));
title("Subject moving (noisy)")

% Convolution filtering
cleanf = conv(clean(:,2),filter(:));
noisyf = conv(noisy(:,2),filter(:));

% Plotting after filtering
subplot(2,2,3)
plot(cleanf);
title("Filtered clean signal")

subplot(2,2,4)
plot(noisyf);
title("Filtered noisy signal")
