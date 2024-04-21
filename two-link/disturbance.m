function d = disturbance(w, t)
  coef = [1; 1];
  d = 2*coef;
  d = 0*d;
  for w0=w
    d = d + coef*sin(w0*t);
  end

