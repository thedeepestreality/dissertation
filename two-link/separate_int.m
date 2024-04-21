clear all, close all;
global al bt cm;
init;
##w0 = [2*pi*6, 2*pi*5, 2*pi*7];
w0 = [2*pi, 2*pi*2, 2*pi*3]
wsz = 2*2*length(w0);
##[al, cm, bt, mu] = synth_corr(w0,-3,Kw,Kq,Hw,Hq);
[al, cm, bt, mu] = synth_corr(w0,-2,Kq,Kw,Hq,Hw);

dt = 0.005;
T = 20;
x = [0;0;0;0]';
x = [qd;0;0]';
q0 = x(1:2)';

x_log = [];
u_log = [];
TT = 0:dt:T;

int_span = [0,dt];

p = zeros(wsz,1);
eq = zeros(2,1);

w = zeros(2,1);
q = q0;
zw = zeros(2,1);
zq = q0;
zc = [zq;zw];
pc = zeros(2,1);

tic();
for t = TT
    x_log = [x_log;x];
    % state
    gm = x';

    % get control
    coef = 0;
    if (t > 10)
        coef = 1;
    end

##    [D, C, g] = inv_dynamics(qd,zeros(2,1));
    [D, C, g] = inv_dynamics(zq,zw);
##    [D, C, g] = inv_dynamics(q,w);
    pc = cm*p + mu*eq;
    [u, u_lin] = ctrl(gm, zc, coef*pc, D, C, g);
##    u_log = [u_log; u_lin'];
    u_log = [u_log; u'];

    % integrate plant
    d = 1*disturbance(w0, t);
##    d = 0.1;
    [D, C, g] = inv_dynamics(q,w);
    [w,~] = lsode(@(xx,tt)(D\(u - C - g + d)), w, int_span);
##    [w,~] = lsode(@(xx,tt)(u_lin + d), w, int_span);
    w = w(end,:)';

    [q,~] = lsode(@(xx,tt)(w), q, int_span);
    q = q(end,:)';

    x = [q' w'];

    % observer
    [zw,~] = lsode(@(zz,tt)(u_lin + Hw*eq), zw, int_span);
    zw = zw(end,:)';

    [zq,~] = lsode(@(zz,tt)(zw + Hq*eq), zq, int_span);
    zq = zq(end,:)';
    zc = [zq;zw];

     % dyn corr
    [p,~] = lsode(@(pp,tt)(dyn_corr(pp,eq)), p, int_span);
    p = p(end,:)';

    eq = x(1:2)' - zc(1:2);
end
toc()
plots(TT, rad2deg(x_log), u_log, rad2deg(qd));
