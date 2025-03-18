%% MATLAB Project 2
% Paul Kullmann, Jessica Wong, Adam Almoukamal


% Function calls for Q2 and Q3
YoungAdult()
OlderAdult()

% Function call for Q5
InputResponse()

% Function call for Q6
SinusoidInput()

% Function call for Q7
VariedParameters()


% All Functions
function YoungAdult()
    % For Q2: plots freq reseponse, bode, and impulse for younder adult

    % Frequency Response
    denominatorCoeffs = [66.7, 288, 898, 50];
    numeratorCoeffs = [288, 898, 50];

    figure()
    freqs(numeratorCoeffs,denominatorCoeffs)
    title("Frequency Response - Young Adult")
    subplot(2,1,1)
    xscale('linear')
    yscale('linear')
    subplot(2,1,2)
    xscale('linear')
    yscale('linear')

    % Bode Plot
    figure()
    sys = tf(numeratorCoeffs,denominatorCoeffs);
    bode(sys)
    title("Bode Plot - Young Adult")

    % Impulse Response
    %[Y,T] = impulse(sys,[0,10]);
    figure()
    impulse(sys,[0,5])
    title("Impulse Response - Young Adult")
end

function OlderAdult()
    % For Q3: plots freq reseponse, bode, and impulse for older adult

    % Frequency Response
    denominatorCoeffs = [66.7, 144, 1221, 50];
    numeratorCoeffs = [144, 1221, 50];

    figure()
    freqs(numeratorCoeffs,denominatorCoeffs)
    title("Frequency Response - Older Adult")
    subplot(2,1,1)
    xscale('linear')
    yscale('linear')
    subplot(2,1,2)
    xscale('linear')
    yscale('linear')

    % Bode Plot
    figure()
    sys = tf(numeratorCoeffs,denominatorCoeffs);
    bode(sys)
    title("Bode Plot - Older Adult")

    % Impulse Response
    %[Y,T] = impulse(sys,[0,10]);
    figure()
    impulse(sys,[0,10])
    title("Impulse Response - Older Adult")
end

function InputResponse()
    % For Q5: Plots the responses to x1(t) and x2(t)
    [x1t,x2t] = VectorConstruction();
    
    YA_denominatorCoeffs = [66.7, 288, 898, 50];
    YA_numeratorCoeffs = [288, 898, 50];
    YA_sys = tf(YA_numeratorCoeffs,YA_denominatorCoeffs);

    OA_denominatorCoeffs = [66.7, 144, 1221, 50];
    OA_numeratorCoeffs = [144, 1221, 50];
    OA_sys = tf(OA_numeratorCoeffs,OA_denominatorCoeffs);

    % Plot responses for each group to each input
    figure()
    subplot(2,2,1)
    t = linspace(0,5,500);
    lsim(YA_sys,x1t,t)
    title("Young Adult Response - abrupt input x1(t)")

    subplot(2,2,2)
    t = linspace(0,15,1500);
    lsim(YA_sys,x2t,t)
    title("Young Adult Response - slower input x2(t)")

    subplot(2,2,3)
    t = linspace(0,5,500);
    lsim(OA_sys,x1t,t)
    title("Older Adult Reseponse - abrupt input x1(t)")

    subplot(2,2,4)
    t = linspace(0,15,1500);
    lsim(OA_sys,x2t,t)
    title("Older Adult Reseponse - slower input x2(t)")

end

function [x1t, x2t] = VectorConstruction()
    % Returns constructed input x1(t) and x2(t)
    displayInputPlots = false;
    
    % Creating x1(t) for sampling rate of 100Hz
    p1 = zeros(1,100);
    p2 = ones(1,50);
    p3 = (-1).*ones(1,50);
    p4 = zeros(1,300);
    x1t = horzcat(p1,p2,p3,p4);
    
    % Creating x2(t) for sampling rate of 100Hz
    p1 = zeros(1,100);
    t = linspace(0,1250,1250);
    p2 = sin(2*pi*t/1250);
    p3 = zeros(1,150);
    x2t = horzcat(p1,p2,p3);

    % Only shows the plots of the constructed inputs if needed to avoid
    % clutter
    if displayInputPlots == true
        figure()
        subplot(1,2,1)
        t = linspace(0,5,500);
        plot(t,x1t)
        title("Constructed input - x1(t)")
        
        subplot(1,2,2)
        t = linspace(0,15,1500);
        plot(t,x2t)
        title("Constructed input - x2(t)")
    end

end

function SinusoidInput()
    % For Q6: plots the response to sinusoidal inouts of different
    % frequencies for the older adult model
    t = linspace(0,10,1000);

    OA_denominatorCoeffs = [66.7, 144, 1221, 50];
    OA_numeratorCoeffs = [144, 1221, 50];
    OA_sys = tf(OA_numeratorCoeffs,OA_denominatorCoeffs);

    figure()
    subplot(3,1,1)
    frequency1 = 2;
    sinInput1 = sin(frequency1*t);
    lsim(OA_sys,sinInput1,t)
    title("Older Adult Sin Input - w = "+frequency1)

    subplot(3,1,2)
    frequency2 = 4;
    sinInput2 = sin(frequency2*t);
    lsim(OA_sys,sinInput2,t)
    title("Older Adult Sin Input - w = "+frequency2)

    subplot(3,1,3)
    frequency3 = 6;
    sinInput3 = sin(frequency3*t);
    lsim(OA_sys,sinInput3,t)
    title("Older Adult Sin Input - w = "+frequency3)

end

function VariedParameters()
    % For Q7: creates plots of the YA response to x1(t) for varied
    % parameters kD and kP
    [x1t,~] = VectorConstruction();
    t = linspace(0,5,500);

    % Response to abrupt input - normal
    figure()
    subplot(3,2,1)
    sys1 = YASystem(288, 898);
    lsim(sys1,x1t,t)
    title("Response to abrupt input x1(t) - normal parameters")

    % Varied kD
    subplot(3,2,3)
    sys2 = YASystem(500,898);
    lsim(sys2,x1t,t)
    title("Response to abrupt input x1(t) - increased kD")
    subplot(3,2,5)
    sys3 = YASystem(100,898);
    lsim(sys3,x1t,t)
    title("Response to abrupt input x1(t) - decreased kD")

    % Varied kP
    subplot(3,2,4)
    sys4 = YASystem(288, 1300);
    lsim(sys4,x1t,t)
    title("Response to abrupt input x1(t) - increased kP")
    subplot(3,2,6)
    sys5 = YASystem(288,500);
    lsim(sys5,x1t,t)
    title("Response to abrupt input x1(t) - decreased kP")

end

function [sys] = YASystem(kD,kP)
    % Returns the system transfer function for inputs kD and kP
    denominatorCoeffs = [66.7, kD, kP, 50];
    numeratorCoeffs = [kD, kP, 50];
    sys = tf(numeratorCoeffs,denominatorCoeffs);
end
