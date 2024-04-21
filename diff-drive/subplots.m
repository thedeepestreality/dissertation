function subplots(t, v, x, u)
global fin0;

subplot(3,2,2);
plot(t, x(:,1),'LineWidth',2);
grid on;
hold on;
plot([t(1),t(end)],[fin0(1),fin0(1)],'k--','LineWidth',2);
title('X');
xlabel('t, s');
ylabel('x, m');

subplot(3,2,4);
plot(t, x(:,2),'LineWidth',2);
grid on;
hold on;
plot([t(1),t(end)],[fin0(2),fin0(2)],'k--','LineWidth',2);
title('Y');
xlabel('t, s');
ylabel('y, m');

subplot(3,2,6);
plot(t, x(:,3),'LineWidth',2);
grid on;
hold on;
plot([t(1),t(end)],[fin0(3),fin0(3)],'k--','LineWidth',2);
title('\phi');
xlabel('t, s');
ylabel('\phi, rad');

figure(2);
subplot(2,1,1);
plot(t, u(:,1),'LineWidth',2);
grid on;
title('Ux');
xlabel('t, s');
ylabel('u_v, N');

subplot(2,1,2);
plot(t, u(:,2),'LineWidth',2);
grid on;
title('Uy');
xlabel('t, s');
ylabel('u_w, N');
