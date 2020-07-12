% Implement 1D CFAR using lagging cells on the given noise and target scenario.

% Close and delete all currently open figures
close all;

% Data_points
Ns = 1000;
% Generate random noise
s = abs(randn(Ns,1));
% Target location. Assigning bin 100, 200, 300, 700 as targets with the 
% amplitude of 8,9, 4,11.
s([100, 200, 300, 700]) = [8,9, 4,11];

% plot the output
plot(s)

% TODO: Apply CFAR to detect the targets by filtering the noise.
% 1. Define the following:
% 1a. Training Cells
% 1b. Guard Cells
T = 20;
G = 10;

% Offset : Adding room above noise threshold for desired SNR 
offset=4;

% Vector to hold threshold values 
threshold_cfar = [];
%Vector to hold final signal after thresholding
signal_cfar = [];

% 2. Slide window across the signal length
for i = 1:(Ns-(G+T))
    noise = sum(s(i:i+T-1));
    threshold = offset * noise/T;
    threshold_cfar = [threshold_cfar, threshold];
    if s(i+T+G) > threshold
        signal_cfar = [signal_cfar, s(i+T+G)];
    else
        signal_cfar = [signal_cfar, 0];
    end
end

% plot the filtered signal
%plot ((signal_cfar),'g--');

% plot original sig, threshold and filtered signal within the same figure.
figure,plot(s);
hold on,plot((circshift(threshold_cfar,G)),'r')%,'LineWidth',2)
hold on, plot ((circshift(signal_cfar,(T+G))),'g--','LineWidth',4);
legend('Signal','CFAR Threshold','detection')