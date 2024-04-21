function d = disturbance(t)
  global w;
%   coef = [0.2;0.1;0.05];
    coef = [0.1;0.2;-0.05];
 d = 2*coef;
  d = 0*d;
%   for w0=w
%     d = d + coef*sin(w0*t);
%   end
