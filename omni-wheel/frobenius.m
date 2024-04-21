function res = frobenius(lm, n)
	res = zeros(n);
	lm_deg = lm;
%     res(1:n-1,2:n) = eye(n-1);
%     res = res + lm*eye(n);
  for row = 1:n-1
		res(row, row+1) = 1;
  end
	for col = n:-1:1
		res(n,col) = nchoosek(n,col-1)*lm_deg;
		lm_deg = lm_deg*(-lm);
  end
