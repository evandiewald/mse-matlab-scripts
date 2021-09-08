function dq = mdof_secondorder(t,q,A,B,freq,amp)

u = function3(amp,freq,t);

dq = A*q + B*u;

end 