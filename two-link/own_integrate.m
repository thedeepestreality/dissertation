clear all, close all;
global al bt cm;
init;
[al, cm, bt, mu] = synth_corr(w0,-3,Kw,Kq,Hw,Hq);
DELAY_COMP = false;
dh = 0.0;
##dt = 0.001;
dt = 0.01;
T = 10;
x = [0;0;0;0]';
xc = [0;0;0;0]';
z = [x, x];
zc = x';

x_log = [];
u_log = [];
TT = 0:dt:T;
dl_cnt = int32(dh/0.01)+1;
u_buf = zeros(2,dl_cnt);
zp_buf = repmat(x',1,dl_cnt);
int_span = [0,dt];
##p = zeros(6,1);
p = zeros(4,1);
eq = zeros(2,1);
tic();
for t = TT
    x_log = [x_log;x];

    % state
    gm = x';
##    if (DELAY_COMP)
##        gm = gm + zp_buf(:,end) - zp_buf(:,1);
##    end

    % dyn corr
    [p,~] = lsode(@(pp,tt)(dyn_corr(pp,eq,zc)), p, int_span);
    p = p(end,:)';
    pc = cm*p + mu*eq;
##    p1 = cm*p(1:3);
##    p2 = cm*p(4:6);

    % get control
    coef = 0;
    if (t > (5+0.4))
        coef = 1;
    end
##    [u, u_lin] = ctrl(gm,zc,coef*[p1;p2]);
    q = gm(1:2);
    w = gm(3:4);
    [D, C, g] = inv_dynamics(q,w);
    [u, u_lin] = ctrl(gm, zc, coef*pc, D, C, g);
    u_log = [u_log; u'];

    % integrate plant
    d = 1*sin(w0*t);
##    d = 0.1;
    [x,~] = lsode(@(xx,tt)(rp(xx,u,d, D, C, g, w)), gm, int_span);
    x = x(end,:);

    %integrate without dist
    [xc,~] = lsode(@(xx,tt)(rp(xx,u,0, D, C, g, w)), xc, int_span);
    xc = xc(end,:)';

    % observer
##    [z,~] = lsode(@(zz,tt)(obsv(zz,gm,u,u_lin)), z, int_span);
    [z,~] = lsode(@(zz,tt)(obsv(zz,eq,u,u_lin)), z, int_span);
    z = z(end,:);

    % prediction observer
    zp = z(1:4)';
    zc = z(5:8)';
    zp_buf = [zp_buf(:,2:end), zp];
##    eq = xc(1:2) - zc(1:2);
    eq = x(1:2)' - zc(1:2);
end
toc()
plots(TT, rad2deg(x_log), u_log);
