function [al, gm, bt, mu] = synth_corr(w, lm, Kq, Kw, Hq, Hw)
  global F0;
	sz = length(w);
  As = [zeros(2) eye(2);
        -Kq -Kw];
  Bs = [Hq zeros(2);
        Hw eye(2)];

	Ai = [];
	Biv1 = [];
  Biv2 = [];

	al = frobenius(lm, sz*2);
	al_inv = inv(al);
	gm = [zeros(1,2*sz-1), 1];
	for w0 = w
		s0 = 1i*w0;
		Ps = (eye(4,4)*s0-As)\Bs;
    P11 = Ps(1:2,1:2);
    P12 = Ps(1:2,3:4);
    P21 = Ps(3:4,1:2);
    P22 = Ps(3:4,3:4);
    T = Kq*P12 + Kw*P22 - eye(2);
    F = -T\(Kq*P11 + Kw*P21);

		en = eye(2*sz);
		aa = inv(en*s0-al);
		a_r = real(aa);
		a_i = imag(aa);
		a1 = gm*(a_r + al_inv);
		a2 = gm*a_i;
		Ai = [Ai;a1;a2];

    Biv1 = [Biv1;
            real(F(1,:)) - F0(1,:);
            imag(F(1,:))];
    Biv2 = [Biv2;
            real(F(2,:)) - F0(2,:);
            imag(F(2,:))];

  end
  al = blkdiag(al, al);
  al_inv = blkdiag(al_inv, al_inv);
	bt = [ Ai\Biv1;
         Ai\Biv2];
  gm = blkdiag(gm,gm);
	mu = F0 + gm*al_inv*bt;

