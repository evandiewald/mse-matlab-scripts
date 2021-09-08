function dq = secondorder(t,q)
% Creates the second order equation for the state space representation of 
% the ode

global m c k

% states equation
% dq(1)=q(2);
% dq(2)=1/m*(-k*q(1)-c*q(2));

A = [ 0 1; -k/m -c/m];
B = [ 0; 1/m];

u = function1(t);

dq = A*q + B*u;


end 