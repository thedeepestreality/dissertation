function dzv = obsv_v(zv, tau, gv)
global Hv A B;

dzv = A*zv + B*tau + Hv*gv;
