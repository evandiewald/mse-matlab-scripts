% Lab 2 Matlab Session
% 9/23/2020

close all; clear all; clc;

%% Finding the Time Constant and Interpolating for a Step Response for Rect.

close all; clear all; clc;

% Read in the Data
[time11,force11,disp11,vel11] = readf('rect_exp1_test1.txt');

% Plot figure 
figure(1);
hold on; 
plot(time11,vel11,'b');
xlim([0.1 time11(end)]);      % Start at 0.1 since there was a delay of 0.1 sec

xlabel('Time [s]');
ylabel('Amplitude')
title('Rect Experiment 1 Test 1: Find Time Constant from Step Response')

% Calculate final asymptotic value and target value
[x1,y1] = ginput(2);
indx = find(time11 > x1(1) & time11 < x1(2));

% Plot on existing Figure 1
plot(time11(indx(1):indx(end)),vel11(indx(1):indx(end)),'color','r','Linewidth',4);

% Find Final Value
amplitude1 = mean(vel11(indx));

% Value at time constant
target_value1 = 0.632*amplitude1;

% Find index greater than target_value1 and plot
t_indx = find(vel11 > target_value1);
plot(time11(t_indx),vel11(t_indx),'color','k','Linewidth',2)

% 1D Interpolation and plot
time_cst1 = interp1([vel11(t_indx(1)-1) vel11(t_indx(1))],[time11(t_indx(1)-1) time11(t_indx(1))],target_value1);

plot(time_cst1, target_value1,'*','Linewidth',10);


%% Finding the Time Constant and Interpolating for a Step Response for Tor

close all; clear all; clc;

% Read in the Data
[time14,force14,disp14,vel14] = readf('tor_exp1_test4.txt');

% Plot figure 
figure(2);
hold on; 
plot(time14,vel14,'b');
xlim([0.1 time14(end)]);      %Start at 0.1 since there was a delay of 0.1 sec

xlabel('Time [s]');
ylabel('Amplitude')
title('Tor Experiment 1 Test 4: Find Time Constant from Step Response')

% Calculate final asymptotic value and target value
[x4,y4] = ginput(2);
indx = find(time14 > x4(1) & time14 < x4(2));

% Plot on existing Figure 1
plot(time14(indx(1):indx(end)),vel14(indx(1):indx(end)),'color','r','Linewidth',4);

% Find Final Value
amplitude4 = mean(vel14(indx));

% Value at time constant
target_value4 = 0.632*amplitude4;

% Find index greater than target_value1 and plot
t_indx = find(vel14 > target_value4);
plot(time14(t_indx),vel14(t_indx),'color','k','Linewidth',2)

% 1D Interpolation and plot
time_cst4 = interp1([vel14(t_indx(1)-1) vel14(t_indx(1))],[time14(t_indx(1)-1) time14(t_indx(1))],target_value4);
plot(time_cst4, target_value4,'*','Linewidth',10);

%% SDOF Simulation with ODE45 - Rectilinear Step Response

close all; clear all; clc;

[time11,force11,disp11,vel11] = readf('rect_exp2_step_test1.txt');

global m c k

m = 2.4869;      % Mass of System (Cart + Additional Masses) [kg]
c = 12;          % Damping Coefficient (Simulated + Cart Damping) [Ns/m]
k = 677.0326;    % Spring Constant (Simulates + Medium Spring) [N/m]

tspan = time11;  % Time vector [s]
y0 = [0 0];      % Initial values [m m/s]

% Calling the ODE Solver
[T1,Y1] = ode45(@secondorder,tspan,y0);

% Plot the Simulation vs. the Experimental Results and Compare
% Do this for both Displacement and Velocity
figure(3);
hold on;
plot(T1,Y1(:,1),'Linewidth',2);
plot(time11,disp11,'r--','Linewidth',2);
xlabel('Time [s]');
ylabel('Displacement [m]');
title('Exp 2: Step Response Test 1 ODE45 vs. Exp - Displacement');
legend('Simulation','Experiment');

figure(4);
hold on;
plot(T1,Y1(:,2),'Linewidth',2);
plot(time11,vel11,'r--','Linewidth',2);
xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Exp 2: Step Response Test 1 ODE45 vs. Exp - Velocity');
legend('Simulation','Experiment');


%% SDOF Simulation with Simulink

close all; clear all; clc;

[time11,force11,disp11,vel11] = readf('rect_exp2_step_test1.txt');

m = 2.4869;      % Mass of System (Cart + Additional Masses) [kg]
c = 12;          % Damping Coefficient (Simulated + Cart Damping) [Ns/m]
k = 677.0326;    % Spring Constant (Simulates + Medium Spring) [N/m]

tspan = 5;
q0 = [ 0; 0];

A1 = [ 0 1; -k/m -c/m];
B1 = [ 0; 1/m];
C1 = [1 0; 0 1];
D1 = [0; 0];

sim('exp2test1step');

figure(5);
hold on;
plot(T1_Disp,'b','Linewidth',2);
plot(time11,disp11,'r--','Linewidth',2);
xlabel('Time [s]');
ylabel('Displacement [m]');
title('Exp 2: Step Response Test 1 Simulink vs. Exp - Displacement');
legend('Simulation','Experiment');

figure(6);
hold on; 
plot(T1_Vel,'b','Linewidth',2);
plot(time11,vel11,'r--','Linewidth',2);
xlabel('Time [s]');
ylabel('Velocity [m/s]');
title('Exp 2: Step Response Test 1 Simulink vs. Exp - Velocity');
legend('Simulation','Experiment');
