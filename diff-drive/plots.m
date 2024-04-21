function plots(t, v, x, u)

figure(2);
subplot(2,1,1);
plot(t, v(:,1),'LineWidth',2);
grid on;
title('V');
xlabel('t, s');
ylabel('v_x, m/s');

subplot(2,1,2);
plot(t, v(:,2),'LineWidth',2);
grid on;
title('W');
xlabel('t, s');
ylabel('w, rad/s');

%%%%%%

figure(3);
subplot(3,1,1);
plot(t, x(:,1),'LineWidth',2);
grid on;
title('X');
xlabel('t, s');
ylabel('x, m');

subplot(3,1,2);
plot(t, x(:,2),'LineWidth',2);
grid on;
title('Y');
xlabel('t, s');
ylabel('y, m');

subplot(3,1,3);
plot(t, x(:,3),'LineWidth',2);
grid on;
title('\phi');
xlabel('t, s');
ylabel('\phi, rad');

%%%%%%

figure(4);
subplot(2,1,1);
plot(t, u(:,1),'LineWidth',2);
grid on;
title('Uv');
xlabel('t, s');
ylabel('u_v, N');

subplot(2,1,2);
plot(t, u(:,2),'LineWidth',2);
grid on;
title('Uw');
xlabel('t, s');
ylabel('u_w, N');