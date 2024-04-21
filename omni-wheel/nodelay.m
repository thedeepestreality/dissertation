clear all, close all;
start;
dt = 0.01;

T = 20;
v = [0;0;0]';
x = [0;0;0]';

TT = 0:dt:T;
sz = length(TT);
v_log = zeros(sz,3);
x_log = zeros(sz,3);
u_log = zeros(sz,3);
img_log = zeros(sz,8);
img = x0;

u = zeros(3,1);

int_span = [0,dt];
count = 0;

ev = zeros(3,1);
ei = zeros(8,1);
zv = zeros(3,1);
zv_log = zeros(sz,3);

e_log = zeros(sz,8);
zi_log = zeros(sz,8);

pv = zeros(wsz,1);
ppi = zeros(wsz,1);

[e, L] = compute_img_err(x);
zi = e;
% zi = x0';

tic();
for t = TT
    count = count + 1;
    v_log(count,:) = v;
    x_log(count,:) = x;
    u_log(count,:) = u';
    zv_log(count,:) = zv;
    e_log(count,:) = e;
    zi_log(count,:) = zi;
    img_log(count,:) = img;
    
    % velocity
    v = v';
    x = x';
    z = [zi; zv; pv; ppi];
    
    u = ctrl_harm(t, z, v, x, ev, ei, L, e);

    d = disturbance(t);
%     [v,~] = lsode(@(xx,tt)(rp(tt,xx,u, d)), v, t+int_span);
    [~, v] = ode45(@(tt,xx)(rp(tt,xx,u, d)), t+int_span, v);
    v = v(end,:);
    
    % integrate kinematics
%     [x,~] = lsode(@(xx,tt)(kin(tt,xx,v')), x, int_span);
    [~,x] = ode45(@(tt,xx)(kin(tt,xx,v')), int_span, x);
    x = x(end,:);
        
    % observer
%     [zv,~] = lsode(@(zz,tt)(obsv_v(zz, u, ev)), zv, int_span);
    [~,zv] = ode45(@(tt,zz)(obsv_v(zz, u, ev)), int_span, zv);  
    zv = zv(end,:)';
    
    [e, L, img, Le] = compute_img_err(x);
    
    
    
%     [zi,~] = lsode(@(zz,tt)(obsv_e(zz, zv, ei, L)), zi, int_span);
    [~,zi] = ode45(@(tt,zz)(obsv_e(zz, zv, ei, L, ev)), int_span, zi);
    zi = zi(end,:)';
    
    
    % corrector
%     [pv,~] = lsode(@(pp,tt)(dyn_corr_v(pp, ev)), pv, int_span);
    [~,pv] = ode45(@(tt,pp)(dyn_corr_v(pp, ev)), int_span, pv);  
    pv = pv(end,:)';
    
%     [ppi,~] = lsode(@(pp,tt)(dyn_corr_i(pp, ei)), ppi, int_span);
    [~,ppi] = ode45(@(tt,pp)(dyn_corr_i(pp, ei)), int_span, ppi);  
    ppi = ppi(end,:)';
    
    ev = v' - zv;
    ei = e - zi;
end
toc()

f = figure(1);
subplot(3,2,[1,3,5]);
x0r = reshape(x0,2,4);
plot([x0r(1,:) x0r(1,1)],[x0r(2,:) x0r(2,1)],'--*','LineWidth',2,'Color','b');
grid on;
axis(2*[-1 1 -1 1]);
hold on;
x1r = reshape(x1,2,4);
plot([x1r(1,:) x1r(1,1)],[x1r(2,:) x1r(2,1)],'r-*','LineWidth',2);
traj_color = [0,0.4470,0.7410];
traj_lw = 4;
traj_mark = '-';
plot(img_log(:,1),img_log(:,2),traj_mark,'LineWidth',traj_lw,'Color',traj_color);

plot([img_log(end,1),img_log(end,3),img_log(end,5),img_log(end,7),img_log(end,1)], ...
     [img_log(end,2),img_log(end,4),img_log(end,6),img_log(end,8),img_log(end,2)], ...
     '--*','LineWidth',2,'Color',[0.8500    0.4250    0.1980]);
 
plot(img_log(:,3),img_log(:,4),traj_mark,'LineWidth',traj_lw,'Color',traj_color);
plot(img_log(:,5),img_log(:,6),traj_mark,'LineWidth',traj_lw,'Color',traj_color);
plot(img_log(:,7),img_log(:,8),traj_mark,'LineWidth',traj_lw,'Color',traj_color);

hold off;
legend('init','target','traj','final');
xlabel('imgX');
ylabel('imgY');

subplots(TT, v_log, x_log, u_log, e_log, zi_log, zv_log);
f.Position = [100 100 1100 450];

disp('fin1 = ');
disp(x(end,:)');
