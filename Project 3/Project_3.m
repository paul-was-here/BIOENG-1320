% Paul Kullmann & Ben Kaminski

%Function call for the plots used for Q7
Hd = Filter;



%The other function calls below are used for the other questions, but we used
%Ben's code & plots instead.

%Analytical_FT
%DFT_Varied_n
%clean_dft = Clean_DFT;
%noisy_dft = Noisy_DFT;



function Hd = Filter
    % Creates the filter, applies it to the signal, and plots the results

    [ecg_clean,ecg_noisy] = ECGdataRetrieval;

    % Code from Filter Designer:
    Fs = 150;  % Sampling Frequency
    
    N    = 50;       % Order
    Fc1  = 5;        % First Cutoff Frequency
    Fc2  = 10;       % Second Cutoff Frequency
    flag = 'scale';  % Sampling Flag
    % Create the window vector for the design algorithm.
    win = triang(N+1);
    
    % Calculate the coefficients using the FIR1 function.
    b  = fir1(N, [Fc1 Fc2]/(Fs/2), 'bandpass', win, flag);
    Hd = dfilt.dffir(b);

    % Convolve filter with signal:
    filtered_noisy = conv(ecg_noisy(:,2),b);
    filtered_clean = conv(ecg_clean(:,2),b);

    % Plots signals (clean, noisy) before & after filtering
    x = linspace(0,10,length(ecg_clean(:,2)));
    figure()
    subplot(2,2,1)
    plot(x,ecg_clean(:,2))
    title("Original Clean Signal")
    subplot(2,2,2)
    plot(x,ecg_noisy(:,2))
    title("Original Noisy Signal")

    x = linspace(0,10,length(filtered_clean));
    subplot(2,2,3)
    plot(x,filtered_clean)
    title("Filtered Clean Signal")
    subplot(2,2,4)
    plot(x,filtered_noisy)
    title("Filtered Noisy Signal")

    for i = 1:4
        subplot(2,2,i)
        xlabel("Time (s)")
        ylabel("Signal Magnitude")
    end

    % Plots the impulse response
    figure()
    plot(Hd.Numerator)
    title("Filter impulse response")
    xlabel("t")
    ylabel("Magnitude  of Response")

    % unused:
    % cleaned_fft = fft(filtered_noisy,1024);
    % figure()
    % subplot(1,2,1)
    % plot(abs(cleaned_fft))
    % subplot(1,2,2)
    % plot(angle(cleaned_fft))

    % Plots each signal (clean, noisy) before & after filtering: magnitude
    % and phase
    fft_clean = fft(ecg_clean(:,2),1024);
    fft_noisy = fft(ecg_noisy(:,2),1024);

    x = linspace(0,250,1024); %For a sampling rate of 250Hz, this adjusts the x-axis to be in Hz

    figure()
    subplot(2,4,1)
    plot(x,abs(fft_clean))
    title("Magnitude: Original Clean Signal")
    subplot(2,4,2)
    plot(x,angle(fft_clean))
    title("Phase: Original Clean Signal")

    subplot(2,4,3)
    plot(x,abs(fft_noisy))
    title("Magnitude: Original Noisy Signal")
    subplot(2,4,4)
    plot(x,angle(fft_noisy))
    title("Phase: Original Noisy Signal")

    fft_filt_clean = fft(filtered_clean,1024);
    fft_filt_noisy = fft(filtered_noisy,1024);

    subplot(2,4,5)
    plot(x,abs(fft_filt_clean))
    title("Magnitude: Filtered Clean Signal")
    subplot(2,4,6)
    plot(x,angle(fft_filt_clean))
    title("Phase: Filtered Clean Signal")

    subplot(2,4,7)
    plot(x,abs(fft_filt_noisy))
    title("Magnitude: Filtered Noisy Signal")
    subplot(2,4,8)
    plot(x,angle(fft_filt_noisy))
    title("Phase: Filtered Noisy Signal")

    for i = 1:8
        subplot(2,4,i)
        xlabel("Frequency (Hz)")
    end

end


function Analytical_FT
    % Plots the analytical FT of the triangle pulse signal.

    w = linspace(0,pi,1000);
    X = 50.*(sin(25.*w)./(25.*w)).^2 .* exp(-j.*w.*50);

    Magnitude = abs(X);
    Phase = angle(X);

    figure()
    subplot(1,2,1)
    plot(w,Magnitude)
    subplot(1,2,2)
    plot(w,Phase)
end

function DFT_Varied_n
    % Computes and plots the DFTs with varying n-values

    x_n = x_t_build;
    w = linspace(0,2*pi,1024);

    figure()
    fft_1024 = fft(x_n,1024);
    mag_1024 = abs(fft_1024);
    phase_1024 = angle(fft_1024);
    subplot(4,2,1)
    plot(w,mag_1024)
    title("Magnitude, n=1024")
    subplot(4,2,2)
    plot(w,phase_1024)
    title("Phase, n=1024")

    w = linspace(0,2*pi,512);

    fft_512 = fft(x_n,512);
    mag_512 = abs(fft_512);
    phase_512 = angle(fft_512);
    subplot(4,2,3)
    plot(w,mag_512)
    title("Magnitude, n=512")
    subplot(4,2,4)
    plot(w,phase_512)
    title("Phase, n=512")

    w = linspace(0,2*pi,128);

    fft_128 = fft(x_n,128);
    mag_128 = abs(fft_128);
    phase_128 = angle(fft_128);
    subplot(4,2,5)
    plot(w,mag_128)
    title("Magnitude, n=128")
    subplot(4,2,6)
    plot(w,phase_128)
    title("Phase, n=128")

    w = linspace(0,2*pi,64);

    fft_64 = fft(x_n,64);
    mag_64 = abs(fft_64);
    phase_64 = angle(fft_64);
    subplot(4,2,7)
    plot(w,mag_64)
    title("Magnitude, n=64")
    subplot(4,2,8)
    plot(w,phase_64)
    title("Phase, n=64")


end

function [ecg_fft] = Clean_DFT
    % Plots and computes the DFT of the clean ECG
    
    [ecg_clean,~] = ECGdataRetrieval;
    
    ecg_fft = fft(ecg_clean(:,2),250);
    magnitude = abs(ecg_fft);
    phase = angle(ecg_fft);

    w = linspace(0,125,250);

    figure()
    subplot(1,2,1)
    plot(w,magnitude)
    title("Clean ECG DFT: Magnitude")
    subplot(1,2,2)
    plot(w,phase)
    title("Clean ECG DFT: Phase")
end

function [ecg_fft] = Noisy_DFT
    % Plots and computes the DFT of the noisy ECG

    [~,ecg_noisy] = ECGdataRetrieval;

    ecg_fft = fft(ecg_noisy(:,2),250);
    magnitude = abs(ecg_fft);
    phase = angle(ecg_fft);

    w = linspace(0,125,250);

    figure()
    subplot(1,2,1)
    plot(w,magnitude)
    title("Noisy ECG DFT: Magnitude")
    subplot(1,2,2)
    plot(w,phase)
    title("Noisy ECG DFT: Phase")
end

function [c,n] = ECGdataRetrieval
    % Retrieves and returns the ECG signal data from the .m file.

    data = load('ecg.mat');
    c = data.clean;
    n = data.noisy;
end

function [x_n] = x_t_build
    % Builds and returns the triangle pulse as a discrete function.

    t1 = linspace(0,1,50);
    t2 = 1-linspace(0,1,50);
    x_n = horzcat(t1,t2);
end