function dzvp = pred_obsv_v(zvp, tau, d)
global A B;

dzvp = A*zvp + B*tau + d;
