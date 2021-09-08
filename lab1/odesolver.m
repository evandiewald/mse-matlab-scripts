close all
clear all
clc

global m c k 

m = 2.07 ; % kg 
c = 2.08; % N*s/m
k = 760; % N/m

tspan=0:0.001:5;
y0=[0.02 0]; %[m m/s]

[T,Y] = ode45(@secondorder,tspan,y0);
%%
figure(1)
plot(T,Y(:,1),'LineWidth',2)
grid on
xlabel('Time [s]')
ylabel('Displacement Amplitude [m]')

%%
figure(2)
plot(T,Y(:,2),'LineWidth',2,'color','r') 		% velocity
grid on
xlabel('Time [s]')
ylabel('Velocity Amplitude [m/s]')
