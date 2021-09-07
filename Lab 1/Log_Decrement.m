clc
clear all
close all

data = textread('TACA_exp2.1_test1.txt','','headerlines',21);

%%
time = data(:,1);
disp = data(:,3);
%%
figure(1)
plot(time,disp,'LineWidth',3)
grid on
xlabel('Time [s]')
ylabel('Displacement [mm]')


%%
[x,y] = ginput(2)
%%
index=find(time>x(1) & time<x(2));
%%
t = time(index);
d = disp(index);
%%

[peak_disp, peak_index] = max(d)

peak_time=t(peak_index)
%%
% final plot of max values
figure(2)
plot(time,disp)
grid on
xlabel('Time [s]')
ylabel('Displacement [mm]')

hold on

plot(t,d,'r')

plot(peak_time,peak_disp,'*')
