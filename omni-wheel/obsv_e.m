function dze = obsv_e(ze, zv, ge, L, ev)
global He L0;

% dze = L0*zv + He*ge;
dze = L*zv + 1*He*ge + 0*L*ev;
