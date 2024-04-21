function dx = kin(t, x, v)
  phi = x(3);
%  R = [cos(phi), -sin(phi), 0;
%       sin(phi), cos(phi), 0;
%       0,0,1];
dx = rot_matr_kin(phi)*v;