function [u_out, tau_lin] = ctrl(x,z,p,D,C,g)
global qd kq kw;
q = x(1:2);
w = x(3:4);
zq = z(1:2);
zw = z(3:4);

##[D, C, g] = inv_dynamics(q,w);

Kq = kq*eye(2);
Kw = kw*eye(2);

tau_lin= -Kq*(zq-qd) - Kw*zw + p;
% tau_lin= -Kq*(q-qd) - Kw*w + 0*p;
tau_fb = C + g;
u_out = tau_fb + D*tau_lin;
% u_out = tau_lin;
end
