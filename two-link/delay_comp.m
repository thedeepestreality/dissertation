clear all, close all;
global al bt cm;
init;
w0 = [2*pi*6, 2*pi*5, 2*pi*7];
wsz = 2*2*length(w0);
[al, cm, bt, mu] = synth_corr(w0,-20,Kw,Kq,Hw,Hq);
dh = 0.1;
dt = 0.01;
T = 20;
x = [0;0;0;0]';
x = [qd;0;0]';
q0 = x(1:2)';

x_log = [];
u_log = [];
TT = 0:dt:T;
dl_cnt = int32(dh/dt)+1;
d_buf = zeros(2,dl_cnt);

zpq = q0;
zpw = zeros(2,1);
zpq_buf = repmat(zpq,1,dl_cnt);
zpw_buf = repmat(zpw,1,dl_cnt);
int_span = [0,dt];
p = zeros(wsz,1);
eq = zeros(2,1);

w = zeros(2,1);
q = q0;
[D, C, g] = inv_dynamics(q, w);
u_buf = repmat(C+g,1,dl_cnt);
wp = zeros(2,1);
qp = q0;
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

##    [D, C, g] = inv_dynamics(zeros(2,1),zeros(2,1));
    [D, C, g] = inv_dynamics(zq,zw);
##    [D, C, g] = inv_dynamics(qp, wp);
    pc = cm*p + mu*eq;
    [u_curr, u_lin] = ctrl(gm, zc, coef*pc, D, C, g);
    u_buf = [u_buf(:,2:end), u_curr];
    u = u_buf(:,1);
    u_log = [u_log; u'];

    % disturbance
    d_curr = 1*disturbance(w0, t);
##    d_curr = [0.1;0.1];
    d_buf = [d_buf(:,2:end), d_curr];
    d = d_buf(:,1);


    % integrate plant
    [D, C, g] = inv_dynamics(q, w);
    w = lsode(@(xx,tt)(D\(u - C - g + d)), w, int_span);
##    [w,~] = lsode(@(xx,tt)(u_lin + d), w, int_span);
    w = w(end,:)';

    q = lsode(@(xx,tt)(w), q, int_span);
    q = q(end,:)';

    x = [q' w'];

    % observer
    zw = lsode(@(zz,tt)(u_lin + Hw*eq), zw, int_span);
    zw = zw(end,:)';

    zq = lsode(@(zz,tt)(zw + Hq*eq), zq, int_span);
    zq = zq(end,:)';
    zc = [zq;zw];

    % pred_obsv
    [D, C, g] = inv_dynamics(zpq, zpw);
    zpw = lsode(@(xx,tt)(D\(u_curr - C - g + d_curr)), zpw, int_span);
    zpw = zpw(end,:)';
##    zpwd = zpw - zpw_buf(:,1);
    zpw_buf = [zpw_buf(:,2:end), zpw];

    zpq = lsode(@(xx,tt)(zpw), zpq, int_span);
    zpq = zpq(end,:)';
##    zpqd = zpq - zpq_buf(:,1);
    zpq_buf = [zpq_buf(:,2:end), zpq];

##    wp = w + zpw - zpw_buf(:,1);
##    qp = q + zpq - zpq_buf(:,1);
    wp = w + zpw(:,end) - zpw_buf(:,1);
    qp = q + zpq(:,end) - zpq_buf(:,1);
##    wp = w + zpwd;
##    qp = q + zpqd;

     % dyn corr
    [p,~] = lsode(@(pp,tt)(dyn_corr(pp,eq)), p, int_span);
    p = p(end,:)';

    eq = qp - zq;
end
toc()
plots(TT, rad2deg(x_log), u_log, rad2deg(qd));
