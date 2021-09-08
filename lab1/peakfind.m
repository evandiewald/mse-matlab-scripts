clear all
close all
clc

%% Importing data

data = textread('Torsional/exp3_test1.txt','','headerlines',22);     %reads text file
time = data(:,1);                                 %time vector
disp = data(:,3);                                     %displacement data

%plot data
figure(1)
plot(time,disp)
xlabel('Time (s)')
ylabel('Amplitude (rad)')
%xlim([7.5 9.5])   %sets axis limits for viewing options xmin, xmax
grid on

%% Finding the peak

[x,y] = ginput(2);

indx = find(time>x(1) & time<x(2));
t = time(indx);
y = disp(indx);

%plot the selected region
figure(2)
plot(time,disp)
xlabel('Time (s)')
ylabel('Amplitude (rad)')
hold on
plot(t,y,'r')


[p1,ind] = max(y);
t_value = t(ind);

figure(3)
plot(time,disp)
xlabel('Time (s)')
ylabel('Amplitude (rad)')
%xlim([7.5 9.5])
hold on
plot(t,y,'r')
plot(t_value,p1,'k*')



