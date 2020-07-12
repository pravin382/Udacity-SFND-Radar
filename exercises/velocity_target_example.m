%Using the following MATLAB code sample, complete the TODOs to calculate the 
% velocity in m/s of four targets with following doppler frequency shifts: 
% [3 KHz, 4.5 KHz, 11 KHz, -3 KHz].

% You can use the following parameter values:

% The radar's operating frequency = 77 GHz
% The speed of light c = 3*10^8
%%
c = 3e8;   %speed of light
f0 = 77e9; %frequency in Hz

% TODO : Calculate the wavelength
lam = c/f0;

% TODO : Define the doppler shifts in Hz using the information from above 
fD = [3000, -4.5e3, 11e3, -3e3];

% TODO : Calculate the velocity of the targets  fd = 2*vr/lambda
vr = lam * fD/2;
% TODO: Display results
disp(vr)
