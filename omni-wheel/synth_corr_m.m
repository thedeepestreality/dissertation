function [al, gm, btv, muv, bte, mue] = synth_corr_m(w, lm, A, B, Kv, Ke, Hv, He, L0)
  global F_v F_e;
	sz = length(w);
  As = [A-B*Kv -B*Ke; L0 zeros(8,8)];
  Bs = [Hv zeros(3,8) B; zeros(8,3) He zeros(8,3)];

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
		Ps = (eye(11,11)*s0-As)\Bs;
    P11 = Ps(1:3,1:3);
    P12 = Ps(1:3,4:11);
    P13 = Ps(1:3,12:14);
    P21 = Ps(4:11,1:3);
    P22 = Ps(4:11,4:11);
    P23 = Ps(4:11,12:14);
    F = -Kv*P13 - Ke*P23 + eye(3);
    Fv = F\(Kv*P11 + Ke*P21);
    Fe = F\(Kv*P12 + Ke*P22);

		en = eye(2*sz);
		aa = inv(en*s0-al);
		a_r = real(aa);
		a_i = imag(aa);
		a1 = gm*(a_r+al_inv);
		a2 = gm*a_i;
		Ai = [Ai;a1;a2];
%    Biv1 = [Biv1; real(Fv(1,:)); imag(Fv(1,:))];
%    Biv2 = [Biv2; real(Fv(2,:)); imag(Fv(2,:))];
%    Biv3 = [Biv3; real(Fv(3,:)); imag(Fv(3,:))];
%    
%    Bie1 = [Bie1; real(Fe(1,:)); imag(Fe(1,:))];
%    Bie2 = [Bie2; real(Fe(2,:)); imag(Fe(2,:))];
%    Bie3 = [Bie3; real(Fe(3,:)); imag(Fe(3,:))];
    Biv1 = [Biv1; real(Fv(1,:)) - F_v(1,:); imag(Fv(1,:))];
    Biv2 = [Biv2; real(Fv(2,:)) - F_v(2,:); imag(Fv(2,:))];
    Biv3 = [Biv3; real(Fv(3,:)) - F_v(3,:); imag(Fv(3,:))];
    
    Bie1 = [Bie1; real(Fe(1,:)) - F_e(1,:); imag(Fe(1,:))];
    Bie2 = [Bie2; real(Fe(2,:)) - F_e(2,:); imag(Fe(2,:))];
    Bie3 = [Bie3; real(Fe(3,:)) - F_e(3,:); imag(Fe(3,:))];
%		Biv = [Biv; real(Fv(1,:)); imag(Fv(1,:));real(Fv(2,:)); imag(Fv(2,:));real(Fv(3,:)); imag(Fv(3,:))];
%		Bie = [Bie; real(Fe(1,:)); imag(Fe(1,:));real(Fe(2,:)); imag(Fe(2,:));real(Fe(3,:)); imag(Fe(3,:))];
  end
  al = blkdiag(al, al, al);
  al_inv = blkdiag(al_inv, al_inv, al_inv);
	btv = [ Ai\Biv1;
          Ai\Biv2;
          Ai\Biv3];
  gm = blkdiag(gm,gm,gm);
	muv = F_v + gm*al_inv*btv;

  bte = [ Ai\Bie1;
          Ai\Bie2;
          Ai\Bie3];
	mue = F_e + gm*al_inv*bte;
