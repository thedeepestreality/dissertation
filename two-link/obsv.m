##function dz = obsv(z, x, u, u_lin)
function dz = obsv(z, eq, u, u_lin)
global hw hq;
zp = z(1:4);
zq = z(5:6);
zw = z(7:8);

##q = x(1:2);
##w = x(3:4);

Hq = hq*eye(2);
Hw = hw*eye(2);

##dzp = rp(zp, u, 0);
dzp = zeros(4,1);
##dzq = zw + Hq*(q-zq);
##dzw = u_lin + Hw*(q-zq);
dzq = zw + Hq*eq;
dzw = u_lin + Hw*eq;

dz = [dzp; dzq; dzw];
