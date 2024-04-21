function [D, C, g] = inv_dynamics(q, w)

th1 = q(1);
th2 = q(2);

dth1 = w(1);
dth2 = w(2);

m1 = 1;
m2 = 1;
L1 = 1;
L2 = 1;
g = 9.8;
D = [(m1+m2)*L1*L1+m2*L2*L2+2*m2*L1*L2*cos(th2), m2*L2*L2+m2*L1*L2*cos(th2)
	    m2*L2*L2+m2*L1*L2*cos(th2), m2*L2*L2];
##D = eye(2);

C = [-m2*L1*L2*sin(th2)*dth2*(2*dth1+dth2);
     m2*L1*L2*sin(th2)*dth1*dth1];

##g = -1*[(m1+m2)*g*L1*sin(th1)+m2*g*L2*sin(th1+th2);
##	    m2*g*L2*sin(th1+th2)];

g = 1*[(m1+m2)*g*L1*cos(th1)+m2*g*L2*cos(th1+th2);
	    m2*g*L2*cos(th1+th2)];
