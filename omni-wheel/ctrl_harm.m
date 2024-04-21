function ctrl = ctrl_harm(t, z, v, xx, ev, ei, L, e)
global Kv L0 gm muv mui wsz h nu;

ze = z(1:8);
zv = z(9:11);
pv = z(12:12+wsz-1);
pe = z(12+wsz:12+2*wsz-1);

pv = gm*pv+muv*ev;
pe = gm*pe+mui*ei;

Ke = nu*L';
% Ke = nu*L0';
% ctrl = -Ke*e - Kv*v;

ctrl = -Ke*ze - Kv*zv;
% ctrl = [0.0;0.0;0.01];

% if (t >= 5.02)
%    ctrl = ctrl + pv + pe;
% end
