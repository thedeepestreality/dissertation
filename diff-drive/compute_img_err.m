function [e, L, x0] = compute_img_err(xx)
  global x1 X0r L0;
  X0 = X0r;
  x = xx(1);
  y = xx(2);
  phi = xx(3);
  a = phi;
  M = [cos(a) -sin(a);
      sin(a) cos(a)];
  L = zeros(8,2);
  x0 = zeros(1,8);
  for i=1:4  
      X0([1 2],i) = M*(X0([1 2],i) - [x;y]);
      z = X0(1,i);
      
      x0(2*i-1) = -X0(2,i)/z;
      x0(2*i)   = X0(3,i)/z;
      
      L(2*i-1:2*i,:) = ComputeLi(x0(2*i-1), x0(2*i), z);
  end

  e = (x0 - x1)';
