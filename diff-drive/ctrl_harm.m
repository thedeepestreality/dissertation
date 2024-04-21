function ctrl = ctrl_harm(t, z, v, xx, ev, ei, L, e)
global Kv L0 gm muv mui wsz h nu;

ze = z(1:8);
zv = z(9:10);
pv = z(11:11+wsz-1);
pe = z(11+wsz:11+2*wsz-1);

pv = gm*pv+muv*ev;
pe = gm*pe+mui*ei;

Ke = nu*L';
% Ke = nu*L0';
% ctrl = -Ke*e - Kv*v;

ctrl = -Ke*ze - Kv*zv;

% if (t >= 5)
%   ctrl = ctrl + pv + pe;
% end
