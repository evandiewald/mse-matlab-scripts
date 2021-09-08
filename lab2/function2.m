function u = function2(t)

if t < 0.1
    u = [0];
elseif t >= 0.1 && t <= 0.15
    u = [10*sin(10*2*pi*t)];
else
    u = [0];
end 
    
end 