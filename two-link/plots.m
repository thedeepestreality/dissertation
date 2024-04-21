function plots(t, x, u, qd)

figure(1);
subplot(2,2,1);
plot(t, x(:,1),'LineWidth',2);
grid on;
hold on;
plot([t(1),t(end)], [qd(1), qd(1)],'k--','LineWidth',1);
title('Joint1');
xlabel('t, s');
ylabel('\theta_1, \circ');

subplot(2,2,3);
plot(t, x(:,2),'LineWidth',2);
grid on;
hold on;
plot([t(1),t(end)], [qd(2), qd(2)],'k--','LineWidth',1);
title('Joint2');
xlabel('t, s');
ylabel('\theta_2, \circ');

subplot(2,2,2);
plot(t, x(:,3),'LineWidth',2);
grid on;
hold on;
plot([t(1),t(end)], [0, 0],'k--','LineWidth',1);
title('Vel1');
xlabel('t, s');
ylabel('\omega_1, \circ/s');

subplot(2,2,4);
plot(t, x(:,4),'LineWidth',2);
grid on;
hold on;
plot([t(1),t(end)], [0, 0],'k--','LineWidth',1);
title('Vel2');
xlabel('t, s');
ylabel('\omega_2, \circ/s');

figure(2);
subplot(2,1,1);
plot(t, u(:,1),'LineWidth',2);
grid on;
title('\tau_1');
xlabel('t, s');
ylabel('\tau_1, N/m');

subplot(2,1,2);
plot(t, u(:,2),'LineWidth',2);
grid on;
title('\tau_2');
xlabel('t, s');
ylabel('\tau_2, N/m');
