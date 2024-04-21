function dv = rp(t, v, u, d)
global A B;
dv = A*v + B*u + d;
