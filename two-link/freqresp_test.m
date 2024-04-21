clear all, close all;
init;
##w0 = [2*pi*6, 2*pi*5, 2*pi*7]
w0 = [2*pi, 2*pi*2, 2*pi*3]
##[al, cm, bt, mu] = synth_corr(w0,-10,Kw,Kq,Hw,Hq);
[al, cm, bt, mu] = synth_corr(w0,-6,Kq,Kw,Hq,Hw);
As = [zeros(2) eye(2);
        -Kq -Kw];
Bs = [Hq zeros(2);
      Hw eye(2)];

##Bs = [Hq zeros(2);
##      Hw zeros(2)];

##w = 2*pi*4.5:pi/8:2*pi*8;
w = 0:pi/8:40;
sz = length(w);
afr = zeros(1,sz);
idx = 1;
for wi = w
  s0 = 1i*wi;
  F = cm*inv(eye(12)*s0-al)*bt+mu;
  Ps = (eye(4,4)*s0-As)\Bs;
  P11 = Ps(1:2,1:2);
  P12 = Ps(1:2,3:4);
  P21 = Ps(3:4,1:2);
  P22 = Ps(3:4,3:4);
  T = Kq*P12 + Kw*P22 - eye(2);
  G = -(Kq*P11 + Kw*P21 + T*F);
##    G = -(Kq*P11 + Kw*P21);
  afr(idx) = abs(G(1,1));
  ++idx;
end

plot(w,afr,'b', 'LineWidth',3);
hold on;
plot(w0,zeros(1,3),'r*');
grid on;

Bs = [Hq zeros(2);
      Hw zeros(2)];
idx = 1;
for wi = w
  s0 = 1i*wi;
  Ps = (eye(4,4)*s0-As)\Bs;
  P11 = Ps(1:2,1:2);
  P12 = Ps(1:2,3:4);
  P21 = Ps(3:4,1:2);
  P22 = Ps(3:4,3:4);
  G = -(Kq*P11 + Kw*P21);
  afr(idx) = abs(G(1,1));
  ++idx;
end

plot(w,afr,'k', 'LineWidth',3);
legend({'corrector','w0','no corrector'})
