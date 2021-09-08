close all
clear all
clc

%% System parameters
m = 0.79;   % mass [kg] 
k = 400;    % stiffness [N/m]
c = 4;      % damping coefficient [Ns/m]    
 
% Initial conditions
x0 = 0;     % initial displacement   
v0 = 0;     % initial velocity 
 
% Controller parameters
Kp = 3;     % proportional gain
Ki = 8;     % integral gain
Kd = 0.1;     % derivative gain

%%
Tsim = 10; % Simulation Time
sim ('sim_control_old_version'); % call the simulation

% Plot results
figure(1)
subplot(2,1,1)
plot(x.Time,x.Data);
ylabel('Displacement [mm]')
xlabel('Time (s)')
subplot(2,1,2)
plot(c_eff.Time,c_eff.Data);
xlabel('Time(s)')
ylabel('Control Effort (N)')
