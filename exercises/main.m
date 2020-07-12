clear; clc;
%%
%Operating frequency (Hz)
fc = 77.0e9;
%Transmitted power (W)
Pt = 3e-3;
%Antenna Gain (linear)
G =  10000;
%Minimum Detectable Power
Ps = 1e-10;
%RCS of a car
RCS = 100;
%Speed of light
c = 3*10^8;
%TODO: Calculate the wavelength
lambda = c / fc;
fprintf("\nwavelength = %f",lambda);

%TODO : Measure the Maximum Range a Radar can see. 
R = radar_max_range_estimator(Pt, G, lambda,RCS,Ps);
fprintf("\nRange = %f", R);
fprintf("\n")
