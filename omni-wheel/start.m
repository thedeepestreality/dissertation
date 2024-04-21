close all;
clear;
global X0r X1r x1 He Hv Kv T B A F_v h L0 F_e w wsz;
global al gm btv muv bti mui nu fin0;
nu = 4;
He = 10*eye(8);
Hv = 10*eye(3);

% Kv = 2*eye(3);
Kv = diag([1 2 4]);
%A = -eye(3);
%B = eye(3);
%A = -diag([0.48, 0.53, 0.023]);

%A = -diag([0.546, 0.552, 1.356]);
M = 1.944;
J = 0.015;
Bv = 0.503;
Bvn = 0.516;
Bw = 0.011;
A = -diag([Bv/M Bvn/M Bw/J]);
B = diag([0.514, 0.514, 66.7]);
      
Kv = lqr(A,B,diag([1e0 1e-1 5e-1]),5e-2*eye(3));
Kv = lqr(A,B,diag([50,0.1,1]),diag([1e-1,1e-1,1]));
Kv = lqr(A,B,diag([400,1,1]),diag([1e-1,1e-1,1]));
% Kv = lqr(A,B,diag([20,0.05,4]),diag([1e-1,1e-1,1]));
%Kv = lqr(A,B,diag([1e0 1e-1 5e-1]),5e-2*eye(3));

psi = 1*pi/6;
% psi = 0.2;
% psi = -0.1;
% psi = 0;
R = rot_matr(-psi);
%R = [cos(psi) sin(psi) 0;
%     -sin(psi) cos(psi) 0;
%     0 0 1];

% T = [0.5; 0; 0];
% T = [0; 0; 0];
T = [0; 0; 0];
% T = [1; 0; 0];
X0r(:,1) = R*[2;  1; -1] - T;
X0r(:,2) = R*[2;  1;  1] - T;
X0r(:,3) = R*[2; -1;  1] - T;
X0r(:,4) = R*[2; -1; -1] - T;

X1r(:,1) = [1;  1; -1];
X1r(:,2) = [1;  1;  1];
X1r(:,3) = [1; -1;  1];
X1r(:,4) = [1; -1; -1];

X0 = X0r;
X1 = X1r;
x0=zeros(1,8);
x1=zeros(1,8);
L0  = zeros(8,3);
for i=1:4
    zz0 = X0(1,i);
    xx0 = X0(2,i); 
    yy0 = X0(3,i);
    x0(2*i-1) = -xx0/zz0;
    x0(2*i)   = yy0/zz0;
    
    zz1 = X1(1,i); xx1 = X1(2,i); yy1 = X1(3,i);
    x1(2*i-1) = -xx1/zz1;
    x1(2*i)   = yy1/zz1;
    
    L0(2*i-1:2*i,:) = ComputeLi(x1(2*i-1), x1(2*i), zz1);
end
% T = -inv(L0'*L0)*(L0'*He);
T = -pinv(L0)*He;
Ke = nu*L0';
F_e =  (Kv-B\A)*T - Ke;

F_v = -inv(B)*Hv;

%%synth_corr_test;
w = [2*pi*6, 2*pi*5, 2*pi*7];
wsz = 2*3*length(w);
lm = -6;
[al, gm, btv, muv, bti, mui] = synth_corr_m(w, lm, A, B, Kv, Ke, Hv, He, L0);

fin0 = sum(X0r,2)/4-[cos(psi);-sin(psi);-psi];
disp('start0 = ');
disp(sum(X0r,2)/4);
disp('fin0 = ');
disp(fin0);
