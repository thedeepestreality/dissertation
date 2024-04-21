function [al, gm, btv, muv, bte, mue] = synth_corr_m(w, lm, A, B, Kv, Ke, Hv, He, L0)
  global F_v F_e;
	sz = length(w);
  As = [A-B*Kv -B*Ke; L0 zeros(8,8)];
  Bs = [Hv zeros(2,8) B; zeros(8,2) He zeros(8,2)];

	Ai = [];
	Biv1 = [];
  Biv2 = [];
  Biv3 = [];
	Bie1 = [];
  Bie2 = [];
  Bie3 = [];

	al = frobenius(lm, sz*2);
	al_inv = inv(al);
	gm = [zeros(1,2*sz-1), 1];
	for w0 = w
		s0 = 1i*w0;
		Ps = (eye(10,10)*s0-As)\Bs;
    P11 = Ps(1:2,1:2);
    P12 = Ps(1:2,3:10);
    P13 = Ps(1:2,11:12);
    P21 = Ps(3:10,1:2);
    P22 = Ps(3:10,3:10);
    P23 = Ps(3:10,11:12);
    F = -Kv*P13 - Ke*P23 + eye(2);
    Fv = F\(Kv*P11 + Ke*P21);
    Fe = F\(Kv*P12 + Ke*P22);

		en = eye(2*sz);
		aa = inv(en*s0-al);
		a_r = real(aa);
		a_i = imag(aa);
		a1 = gm*(a_r+al_inv);
		a2 = gm*a_i;
		Ai = [Ai;a1;a2];
    
    Biv1 = [Biv1; real(Fv(1,:)) - F_v(1,:); imag(Fv(1,:))];
    Biv2 = [Biv2; real(Fv(2,:)) - F_v(2,:); imag(Fv(2,:))];
    
    Bie1 = [Bie1; real(Fe(1,:)) - F_e(1,:); imag(Fe(1,:))];
    Bie2 = [Bie2; real(Fe(2,:)) - F_e(2,:); imag(Fe(2,:))];
  end
  al = blkdiag(al, al);
  al_inv = blkdiag(al_inv, al_inv);
	btv = [ Ai\Biv1;
          Ai\Biv2];
  gm = blkdiag(gm,gm);
	muv = F_v + gm*al_inv*btv;

  bte = [ Ai\Bie1;
          Ai\Bie2];
	mue = F_e + gm*al_inv*bte;
