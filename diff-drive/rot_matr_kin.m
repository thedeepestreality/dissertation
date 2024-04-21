function R = rot_matr_kin(phi)
  R = [cos(phi), 0;
       -sin(phi), 0;
       0,1];
