% MATLAB Project 1 - Part 1
% Paul Kullmann & Ani Kulkarni

% Defining time
x = linspace(0,100,100/0.5);

% Choose a function to call:
NormalPlotting(x)
HomogeneityProofPlotting(x) % Used for proof of 1(a)
Error = LinearityProofPlotting(x); % Used for proof of 1(a)


function NormalPlotting(x)
    figure()
    %Normal visualization  of 3 different input frequencies
    subplot(3,1,1)
    [artpress, time] = StandardSystem(x,0.01);
    plot(time,artpress)
    xlabel("Time (s)")
    ylabel("Arterial Pressure")
    title("Freq: 0.01 Hz")
    
    subplot(3,1,2)
    [artpress, time] = StandardSystem(x,0.05);
    plot(time,artpress)
    xlabel("Time (s)")
    ylabel("Arterial Pressure")
    title("Freq: 0.05 Hz")
    
    subplot(3,1,3)
    [artpress, time] = StandardSystem(x,0.2);
    plot(time,artpress)
    xlabel("Time (s)")
    ylabel("Arterial Pressure")
    title("Freq: 0.2 Hz")
end

function [Error] = LinearityProofPlotting(x)
    figure()
    % First plot two individual inputs, i.e. x1 and x2
    subplot(1,4,1)
    [artpress1, time] = StandardSystem(x,0.1);
    plot(time, artpress1)
    title("Frequency: 0.1 Hz")
    
    subplot(1,4,2)
    [artpress2,time] = StandardSystem(x,0.2);
    plot(time,artpress2)
    title("Frequency: 0.2 Hz")
    
    % Next, sum their distinct outputs, i.e. simply y1+y2
    subplot(1,4,3)
    plot(time,(artpress1+artpress2))
    title("Sum of outputs: y1+y2");
    
    % Then, plot the sum of their inputs, i.e. y(x1+x2)
    subplot(1,4,4)
    [artpress,time] = LinearityProof(x,0.1);
    plot(time,artpress)
    title("Sum of inputs: y(x1+x2)")
    
    % To obey the superposition principle, expect x1+x2 -> y1+y2
    % We compute the difference between y(x1+x2) and y1+y2 below:
    Error = artpress-(artpress1+artpress2);
    % View the Error array and notice the difference is not 0- i.e.
    % superposition is not obeyed
end

function HomogeneityProofPlotting(x)
    figure()
    % Here we show the plot of kx
    subplot(1,2,1)
    [artpress,time] = TenxInput(x,0.1);
    plot(time,artpress);
    title("10x(t) - 10* the input")

    % And here we show the plot of ky
    subplot(1,2,2)
    [artpress,time] = StandardSystem(x,0.1);
    plot(time,10*artpress);
    title("10y(t) - 10* the output")

    % To obey the homogeneity principle, the plots should be the same.
    % i.e. kx -> ky     Notice this is not the case.
end

% Recurring function
function [artpress, time] = StandardSystem(x,frequency)
    % Standard plotting function
    csp = sin(frequency .* x);
    [artpress, time] = TotalBaroreflexArc(csp, "n");
end

function [artpress,time] = TenxInput(x,frequency)
    % This function is used to scale the input
    csp = 10 * sin(frequency .* x);
    [artpress,time] = TotalBaroreflexArc(csp,"n");
end

function [artpress, time] = LinearityProof(x,frequency)
    % This function is used to obtain the output of summing 2 inputs
    csp = sin(frequency .* x);
    csp2 = sin(2*frequency .* x);
    [artpress, time] = TotalBaroreflexArc((csp+csp2),"n");
end