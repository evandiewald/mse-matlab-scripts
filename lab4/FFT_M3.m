%% FFR Content - Method 3

% This method uses three full cycles of the data

close all; clear all; clc;

[t,disp1,disp2]=readf('L4R_E3_T1.txt');

y1 = disp1;
y2 = disp2;

F=4; %Hz
full_cycle= 1/F; %seconds

% Car 1 FFT
figure(1)
plot(t,y1,'r')
grid on

% Select 2 points that capture the SS Region
aa=ginput(2);
indx= find(t>aa(1,1) & t<aa(2,1));

yy=y1(indx);
tt=t(indx);
tt=tt-tt(1);

num_cycles= round(tt(end)/full_cycle);

indx2 = find(tt<num_cycles*full_cycle);

yyy= yy(indx2);
ttt= tt(indx2);

fff= 0:1/(ttt(end)):(length(ttt)-1)*1/(ttt(end));

figure(2)
hold on;
plot(fff,abs(fft(yyy))/(length(yyy)/2),'r')
xlim([0 6])

% Car 2 FFT
figure(1)
plot(t,y2,'r')
grid on

% Select 2 points that capture the SS Region
aa=ginput(2);
indx= find(t>aa(1,1) & t<aa(2,1));

yy=y2(indx);
tt=t(indx);
tt=tt-tt(1);

num_cycles= round(tt(end)/full_cycle);

indx2 = find(tt<num_cycles*full_cycle);

yyy= yy(indx2);
ttt= tt(indx2);

fff= 0:1/(ttt(end)):(length(ttt)-1)*1/(ttt(end));

figure(2)
hold on;
plot(fff,abs(fft(yyy))/(length(yyy)/2),'b')
xlim([0 6])
legend({'Car 1','Car 2'});
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('Method 3: Frequency Content for Exp 3 - Test 1');