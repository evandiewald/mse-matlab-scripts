clc
clear all
close all

data = textread('Rectilinear/exp1_test1.txt','','headerlines',22);

time = data(:,1);
force=data(:,2);
disp = data(:,3);
%%
subplot(1,2,1)
plot(time,disp,'LineWidth',3)
grid on
xlabel('Time [s]')
ylabel('Displacement [mm]')

subplot(1,2,2)
plot(time,force,'LineWidth',3)
grid on
xlabel('Time [s]')
ylabel('Force [N]')
%%
figure(2)
plot(disp,force,'LineWidth',3)
grid on
ylabel('Force [N]')
xlabel('Displacement [mm]')
%% Curve Fitting Toolbox (GUI)
cftool;

%% Polyfit (API)
p = polyfit(disp, force, 1); % first-order fit
fprintf("Spring constant: %0.1f N/m\n", p(1)*1000)  