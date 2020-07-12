%angle of arrival
c = 3e8;
f=77e9;
phi=45; % in degrees
lam = c/f;
d = lam/2;
%% phi = 360 * d * sin(theta)/lambda
% phi = increment phase shift
% d = spacing between antenna shift
% theta = steering direction from the normal of the antenna surface
% lambda = wavelength of the signal
theta = asin(phi*lam/(360*d));
disp(theta * 180/pi)