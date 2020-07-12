function [R] = radar_max_range_estimator(Ps, G, lambda, RCS, PE)
% function [R] = radar_range_estimator(Ps, G, lambda, RCS,PE)
% ==========================================================
% Inputs
% Ps = Transmitted Power from radar(dBm)
% G = Gain of the Transmit/Receive Antenna (dBi)
% lambda = Wavelength of the signal (mm)
% RCS = radar cross section (m^2)
% PE = Minimum received power radar can detect
% ==========================================================
% Output
% R = range of Radar
result = Ps * G*G * lambda*lambda * RCS/(PE * (4*pi)^3);
R=nthroot(result,4);
end