%1 
clc;
clear;
close all;

omega=linspace(0,pi,1000);

%FT of x(t)
X_w=50*((sin(25*omega))./(25*omega)).^2.*exp(-1j*omega*50);

%Calculating the spectra
magnitude=abs(X_w);
phase=angle(X_w);

%plotting the figures 
figure;
subplot(2,1,1);
plot(omega,magnitude,'b');
title('Magnitude Spectrum |X(w)|');
xlabel('\omega (rad/s)');
ylabel('|X(w)|');
grid on,

subplot(2,1,2);
plot(omega,phase,'r');
title('Phase Spectrum |X(w)|');
xlabel('\omega (rad/s)');
ylabel('\angleX(w) (rad)');
grid on,

sgtitle('Magnitude and Phase Spectra of X(w)');


%2
%sampling parameters
Ts=1;
n = 0:100;
x_n = triang(length(n));
varying_n = [1024, 64, 128, 512];   %change value N to 64,128,512 for problem 3


% X_k=fft(x_n,N);
% 
% omega_Ts=linspace(0,2*pi,N);
% 
% magnitude_DFT=abs(X_k);
% phase_DFT=angle(X_k);
% 
% figure;
% subplot(2,1,1);
% plot(omega_Ts,magnitude_DFT,'b', 'linewidth', 1);
% title('FFT Magnitude Spectrum |X[k]|');
% xlabel('\omegaT_s (rad/s)');
% ylabel('|X[w]|');
% grid on,
% 
% subplot(2,1,2);
% plot(omega_Ts,phase_DFT,'r','linewidth', 1);
% title('FFT Phase Spectrum |X[k]|');
% xlabel('\omegaT_s (rad/s)');
% ylabel('\angleX[k] (rad)');
% grid on,
% 
% sgtitle(['FFT Magnitude and Phase Spectra of x[n] (n = 'num2str(1024)'] );

for i = 1:length(varying_n)

    X_k = fft(x_n,varying_n(i));
    omega_Ts = linspace(0,2*pi,varying_n(i));

    magnitude_DFT=abs(X_k);
    phase_DFT=angle(X_k);

    figure;
    subplot(2,1,1);
    plot(omega_Ts,magnitude_DFT,'b');
    title('DFT Magnitude Spectrum X[k]');
    xlabel('\omegaT_s (rad/s)');
    ylabel('|X[w]|');
    grid on,

    hold on;

    subplot(2,1,2);
    plot(omega_Ts,phase_DFT,'r');
    title('DFT Phase Spectrum X[k]');
    xlabel('\omegaT_s (rad/s)');
    ylabel('\angleX[k] (rad)');
    grid on,

    sgtitle(['DFT Magnitude and Phase Spectra of x[n] (n = ' num2str(varying_n(i)) ' Hz)']);

end

%Problem 5
%Load data from Project 1
load('ecg.mat');

clean_data=clean(:,2);
noisy_data=noisy(:,2);

X = double(clean_data);
Y = double(noisy_data);

%creating sampling interval
Ts=1;
Fs=125; %sampling frequency in Hz (converting msec to sec)
f_max=Fs/2; %(6.2814 kHz)

%Compute the DFT of the clean signal
N=length(X);
X_clean=fft(X);
frequencies=linspace(0,f_max,N/2); %frequency vector (zero to 6.2814 kHz)

%Magnitude and phase spectra
magnitude_clean=abs(X_clean(1:N/2)); %only first half of fft
phase_clean=angle(X_clean(1:N/2));   %only first half of fft

%Plot the magnitude spectrum 
figure;
subplot(2,1,1);
plot(frequencies,magnitude_clean,'b');
title('Magnitude Spectrum');
xlabel('Frequancy (kHz)');
ylabel('|X(f)|');
grid on;

%Plot the phase spectrum 
subplot(2,1,2);
plot(frequencies,phase_clean,'r');
title('Phase Spectrum');
xlabel('Frequancy (kHz)');
ylabel('\angleX(f)');
grid on;

sgtitle('DFT Magnitude and Phase Spectra of clean AP Signal');


%Problem 6 - plotting magnitude and phase of noisy AP signal

%Compute the DFT of the clean signal
M=length(Y);
X_noise=fft(Y);
frequencies=linspace(0,f_max,N/2); %frequency vector (zero to 6.2814 kHz)

%Magnitude and phase spectra
magnitude_noise=abs(X_noise(1:M/2)); %only first half of fft
phase_noise=angle(X_noise(1:M/2));   %only first half of fft

%Plot the magnitude spectrum 
figure;
subplot(2,1,1);
plot(frequencies,magnitude_noise,'b','linewidth',1);
title('Magnitude Spectrum');
xlabel('Frequancy (kHz)');
ylabel('|X(f)|');
grid on;

%Plot the phase spectrum 
subplot(2,1,2);
plot(frequencies,phase_noise,'r','linewidth',1);
title('Phase Spectrum');
xlabel('Frequancy (kHz)');
ylabel('\angleX(f)');
grid on;

sgtitle('DFT Magnitude and Phase Spectra of noisy AP Signal');

%Problem 7 - Creating a filter for noisy AP signal


%Filter Parameters
filter_order = 50;
cutoff_freqs = [15, 30, 45];

for i = 1:length(cutoff_freqs)
    Wn = cutoff_freqs(i) / f_max;
    b = fir1(filter_order, Wn, 'low');

    %apply filter
    filtered_ecg_clean = filter(b, 1, X);
    filtered_ecg_noisy = filter(b, 1, Y);

    %plot impulse response of the filter
    figure;
    subplot(2,1,1);
    stem(b);
    title(['Impulse Response of FIR Filter (Cutoff = ' num2str(cutoff_freqs(i)) ' Hz)']);
    xlabel('Samples');
    ylabel('amplitude');

    hold on;

    %plot filtered ecg
    subplot(2,1,2);
    plot(filtered_ecg_clean);
    title(['Filtered of ECG Signal (Cutoff = ' num2str(cutoff_freqs(i)) ' Hz)']);
    xlabel('Samples');
    ylabel('amplitude');
end

%Problem 7
%Plot original and filtered signal
figure;
subplot(2,1,1);
plot(X,'r','Linewidth',1);
title('Original Clean Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(filtered_ecg_clean,'b','Linewidth',1);
title('Filtered Clean Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

sgtitle('Comparison of Noisy AP Signal Unfiltered v. Filtered');

figure;
subplot(2,1,1);
plot(Y,'r','Linewidth',1);
title('Original Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;


subplot(2,1,2);
plot(filtered_ecg_noisy,'b','Linewidth',1);
title('Filtered Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

sgtitle('Comparison of Clean AP Signal Unfiltered v. Filtered');










