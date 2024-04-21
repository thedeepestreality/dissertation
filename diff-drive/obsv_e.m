function dze = obsv_e(ze, zv, ge, L)
global He L0;

%dze = L0*zv + He*ge;
dze = L*zv + He*ge;
