function R = rot_matr(phi)
  R = [cos(phi), -sin(phi), 0;
       sin(phi), cos(phi), 0;
       0,0,1];
