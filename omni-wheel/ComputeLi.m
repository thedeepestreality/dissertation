function Li = ComputeLi(x, y, Z)

Li = [ x/Z, 1/Z, -(1+x^2) ;
       y/Z,   0,   -x*y ];
% 
% Li = [ x/Z, -1/Z,     y ;
%        y/Z,    0,    -x ];

% Li = [ 0, -1/Z,  y ;
%     -1/Z,    0, -x ];