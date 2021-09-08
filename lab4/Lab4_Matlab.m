% Lab 4 Matlab Session
% 11/4/2020

close all; clear all; clc;

%% FFT Content - Method 1

% This method uses all of the data

close all; clear all; clc;

[t,disp1,disp2]=readf('L4R_E3_T1.txt');

y1 = disp1;
y2 = disp2;

% CAR 1 FFT
figure(1)
plot(t,y1)

T=30; %seconds
Fs=1000; %Sampling Rate

t_vector= 0:1/Fs:T-1/Fs;
freq_vector= 0:1/T:Fs-1/T;

figure(2)
hold on;
plot(freq_vector,abs(fft(y1)/(length(y1)/2)))
xlim([0 10])


% CAR 2 FFT
figure(3)
plot(t,y2)

T=30; %seconds
Fs=1000; %Sampling Rate

t_vector= 0:1/Fs:T-1/Fs;
freq_vector= 0:1/T:Fs-1/T;

figure(2)
hold on;
plot(freq_vector,abs(fft(y2)/(length(y2)/2)))
xlim([0 6])
legend({'Car 1','Car 2'});
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('Method 1: Frequency Content for Exp 3 - Test 1');

%% FFT Content - Method 2

% This method uses the steady state portion of the data

close all; clear all; clc;

[t,disp1,disp2]=readf('L4R_E3_T1.txt');

y1 = disp1;
y2 = disp2;

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

ff= 0:1/(tt(end)):(length(tt)-1)*1/(tt(end));

figure(2)
hold on;
plot(ff,abs(fft(yy))/(length(yy)/2),'r')
xlim([0 6])

% Car 2 FFT
figure(3)
plot(t,y2,'r')
grid on

% Select 2 points that capture the SS Region
aa=ginput(2);
indx= find(t>aa(1,1) & t<aa(2,1));

yy=y2(indx);
tt=t(indx);
tt=tt-tt(1);

ff= 0:1/(tt(end)):(length(tt)-1)*1/(tt(end));

figure(2)
hold on;
plot(ff,abs(fft(yy))/(length(yy)/2),'b')
xlim([0 6])
legend({'Car 1','Car 2'});
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('Method 2: Frequency Content for Exp 3 - Test 1');

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

%% Drawing Mode Shapes

close all; clear all; clc;

mode1 = 1;      %set the first degree-of-freedom amplitude (generally normalized to 1)
mode2 = -2;     %second degree-of-freedom amplitude

figure(3)
hold on;

%Plot the dash line to show the zero datum
plot([0 2.5],[0 0],'--k');

%Plot the amplitudes as circles (x values [1 2] are arbitrary and can be anything)
plot([1 2],[mode1 mode2],'o','Linewidth',2);

% Connect the circles with a line by basically plotting the same
plot([1 2],[mode1 mode2],'r','Linewidth',2);

% set the x limits accordingly so all of the points are seen
set(gca,'xlim',[0.5 2.5]) 

% set y limits
set(gca,'ylim',[min(min([mode1 mode2])-0.5,-0.5) max(max([mode1 mode2])+0.5,0.5)]) 

%% 2-DOF Simulation - ODE45

[time, disp1, disp2] = readf('L4R_E3_T2.txt');

global m1 c1 k1 m2 c2 k2 k3 

freq = 2;
amp = 1;

m1 = 2.51;    %[kg] Mass of Blocks + Mass of Car 1
m2 = 2.546;     %[kg] Mass of Blocks + Mass of Car 2

k1 = 411.3183;
k2 = 212.5320;
k3 = 385.3173;

c1 = 2.0471;   
c2 = 0.7780;

A1 = [0 1 0 0
     -(k1+k2)/m1 -c1/m1 k2/m1 0
     0 0 0 1
     k2/m2 0 -(k2+k3)/m2 -c2/m2];
B1 = [0; 1/m1; 0; 0];

tspan = [0 30];
y0 = [0 0 0 0];

[T,Y] = ode45(@(t,q) mdof_secondorder(t,q,A1,B1,freq,amp),tspan,y0);

figure(1)
subplot(2,1,1);
hold on;
plot(T,Y(:,1))
plot(time,disp1);
xlabel('Time [s]');
ylabel('X1(t) Displacement Response');
legend({'Simulation','Experiment'});
grid on

subplot(2,1,2);
hold on;
plot(T,Y(:,3))
plot(time,disp2);
xlabel('Time [s]');
ylabel('X2(t) Displacement Response');
legend({'Simulation','Experiment'});
grid on; 


%% 2-DOF Simulation - Simulink

close all; clear all; clc;

[time, disp1, disp2] = readf('L4R_E3_T2.txt');

freq = 2;
amp = 1;

m1 = 2.51;    %[kg] Mass of Blocks + Mass of Car 1
m2 = 2.546;     %[kg] Mass of Blocks + Mass of Car 2

k1 = 411.3183;
k2 = 212.5320;
k3 = 385.3173;

c1 = 2.0471;   
c2 = 0.7780;

A2 = [0 1 0 0
     -(k1+k2)/m1 -c1/m1 k2/m1 0
     0 0 0 1
     k2/m2 0 -(k2+k3)/m2 -c2/m2];
B2 = [0; 1/m1; 0; 0];
C2 = [1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
D2 = [0; 0; 0; 0];

y0 = [0 0 0 0];
Tspan = 30;

amp = 1;
freq = 2;

sim('mdof_sim');

figure(5);
subplot(2,1,1);
hold on;
plot(x1,'b','Linewidth',2);
plot(time,disp1,'r--','Linewidth',2);
xlabel('Time [s]');
ylabel('X1 Displacement [m]');
title('Exp 3 - Test 2: X1 Response Simulink vs. Exp');
legend('Simulation','Experiment');

subplot(2,1,2)
hold on; 
plot(x2,'b','Linewidth',2);
plot(time,disp2,'r--','Linewidth',2);
xlabel('Time [s]');
ylabel('X2 Displacement [m]');
title('Exp 3 - Test 2: X2 Response Simulink vs. Exp');
legend('Simulation','Experiment');
