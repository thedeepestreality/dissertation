function subplots(t, v, x, u, e_log, zi_log, zv)
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
subplot(3,1,1);
plot(t, u(:,1),'LineWidth',2);
grid on;
title('Ux');
xlabel('t, s');
ylabel('u_x, N');

subplot(3,1,2);
plot(t, u(:,2),'LineWidth',2);
grid on;
title('Uy');
xlabel('t, s');
ylabel('u_y, N');

subplot(3,1,3);
plot(t, u(:,3),'LineWidth',2);
grid on;
title('Uw');
xlabel('t, s');
ylabel('u_w, N');

figure(3);
for i=1:4
    for j=1:2
        ind = (i-1)*2+j;
        subplot(4,2,ind);
        plot(t,e_log(:,ind),'r*','LineWidth',2);
        hold on;
        grid on;
        plot(t,zi_log(:,ind),'k*','LineWidth',2);
    end
end

% figure(4)
% for i=1:3
%         subplot(3,1,i);
%         plot(t,v(:,i),'r','LineWidth',3);
%         hold on;
%         grid on;
%         plot(t,zv(:,i),'k','LineWidth',1);
% end