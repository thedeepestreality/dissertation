function d = disturbance(t)
  global w;
  coef = [2;1];
  d = coef;
  d = 0*coef;
%   for w0=w
%     d = d + coef*sin(w0*t);
%   end
