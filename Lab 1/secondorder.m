function dq = secondorder(t,q)

global m c k                                        % global variables
  
% states equation
% dq(1)=q(2);
% dq(2)=1/m*(-k*q(1)-c*q(2));
 
A = [0 1; -k/m -c/m];
B = [0;1/m];

u=0;
dq = A*q+B*u;


end