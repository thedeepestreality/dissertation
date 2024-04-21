global kw kq hw hq qd F0;

% kw = 0.8;
% kq = 0.4;
% hw = 10;
% hq = 10;

kw = 8;
kq = 8;
hw = 8;
hq = 2;

##kw = 1;
##kq = 2;
hw = 32;
hq = 16;

qd = 1*[45*pi/180; 60*pi/180];

Kw = eye(2)*kw;
Kq = eye(2)*kq;
Hw = eye(2)*hw;
Hq = eye(2)*hq;
F0 = -Kq - Kw*Hq - Hw;
