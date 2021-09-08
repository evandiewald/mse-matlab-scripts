% Tutorial for determining the gain margin of the system
clear all
close all
clc

% System parameters
m = 0.8775;     % mass [kg]
c = 2.9123+8;   % damping coefficient [Ns/m]
k = 451.39;     % stiffness [N/m]

% Controller parameters
Kp = 2000;         % proportional gain
Ki = 0;         % integral gain
Kd = 0;         % derivative gain

% Plant transfer function
G=tf(1,[m c k]);
% Controller transfer function
C=tf([Kd Kp Ki],[1 0]);

% Multiply plant and controller trasfer functions to obtain open loop transfer function
OL=G*C; 

% Plot the bode diagram and determine the phase and gain margins for the open loop transfer function
figure(1)
margin(OL) 

w = (0.1*2*pi:0.04*2*pi:20*2*pi)'; 
[amp,pha] = bode(OL,w); 

% Plotting the bode plot
figure(2)
% Converting the freq to Hz here so that you 
% directly plot your experimental bode on top of it also, be careful 
% with the dB conversion of the amplitude  
subplot(2,1,1)     
semilogx(w/2/pi,20*log10(amp(1,:)))
ylabel('Magnitude (dB)');
grid on 
% Plot the bode phase.                                                        
subplot(2,1,2)  
semilogx(w/2/pi,pha(1,:))%plot the bode phase in degrees
xlabel('Freq (Hz)');
ylabel('Phase (deg)');
grid on