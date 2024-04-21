clear all;
syms g L1 m1 t1(t) L2 m2 t2(t) th1 th2 dth1 dth2 ddth1 ddth2
dt1 = diff(t1(t),t);
dt2 = diff(t2(t),t);
ddt1 = diff(dt1,t);
ddt2 = diff(dt2,t);
x1 = L1*sin(t1);
y1 = L1*cos(t1);
x2 = x1 + L2*sin(t1 + t2);
y2 = y1 + L2*cos(t1 + t2);
dx1 = diff(x1,t);
dy1 = diff(y1,t);
dx2 = diff(x2,t);
dy2 = diff(y2,t);
K1 = simplify(m1*(dx1^2+dy1^2)/2);
K2 = simplify(m2*(dx2^2+dy2^2)/2);
P1 = m1*g*y1;
P2 = m2*g*y2;
L = simplify((K1-P1)+(K2-P2));
tau1 = simplify(diff(diff(L,dt1),t) - diff(L, t1(t)));
tau2 = simplify(diff(diff(L,dt2),t) - diff(L, t2(t)));
M11 = diff(tau1, ddt1);
M12 = diff(tau1, ddt2);
tmp1 = subs(simplify(tau1 - M11*ddt1 - M12*ddt2),{dt1,dt2}, {dth1,dth2});
subs(tmp1,{t1,t2}, {th1,th2})

M21 = diff(tau2, ddt1);
M22 = diff(tau2, ddt2);
tmp2 = subs(simplify(tau2 - M21*ddt1 - M22*ddt2),{dt1,dt2}, {dth1,dth2});
subs(tmp2,{t1,t2}, {th1,th2})
D = subs([M11, M12;M21, M22],{t1,t2}, {th1,th2})
