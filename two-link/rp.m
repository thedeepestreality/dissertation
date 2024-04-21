function dx = rp(x, tau, d, D, C, g, w)
q = x(1:2);
##w = x(3:4);

##[D, C, g] = inv_dynamics(q,w);

dx = [w;
      D\(tau - C - g + [d;d])];
##inv(D)*(tau - C - g) + [d;d]];

% dx = [w; tau+[d;d]];
