close all
clear
clc

nat_frequencies = [];
damping_ratios = [];

% loop through all tests in exp3
for i = 1:10
    fp = strcat('Rectilinear/exp3_test', num2str(i), '.txt');
    data=textread(fp,'','headerlines',22);     %reads text file
    time=data(:,1);                                 %time vector
    disp=data(:,5);                                     %displacement data
    
    figure(1)
    plot(time,disp)
    xlabel('Time (s)')
    ylabel('Amplitude (rad)')
    title('Select boundaries of peak 1, then peak 2 (4 points)')
    %xlim([7.5 9.5])   %sets axis limits for viewing options xmin, xmax
    grid on
    
    [x,y] = ginput(4);

    indx1 = find(time>x(1) & time<x(2));
    t1 = time(indx1);
    y1 = disp(indx1);

    [p1,ind1]=max(y1);
    t_peak1 = t1(ind1);
    
    indx2 = find(time>x(3) & time<x(4));
    t2 = time(indx2);
    y2 = disp(indx2);

    [p2,ind2]=max(y2);
    t_peak2 = t2(ind2);

    figure(2)
    plot(time, disp)
    xlabel('Time (s)')
    ylabel('Amplitude (rad)')
    hold on
    plot(t1,y1,'r')
    plot(t_peak1,p1,'k*')
    plot(t_peak2,p2,'k*')
    legend('Displacement', 'Peak 1', 'Peak 2')
    
    N = input('What is N?\n....>>');
    
    delta = (1 / N)*log(p1 / (p2));
    damping_ratio = 1 / sqrt(1 + (2*pi / delta).^2);
    damping_ratios = [damping_ratios; damping_ratio];
    period = (t_peak2 - t_peak1) / N;
    damped_freq = 2*pi / period;
    nat_frequencies = [nat_frequencies; damped_freq / sqrt(1 - damping_ratio^2)];
    
    close all;
end

nat_freq_mean = mean(nat_frequencies);
nat_freq_std = std(nat_frequencies);

damping_ratio_mean = mean(damping_ratios);
damping_ratio_std = std(damping_ratios);

fprintf('Damping ratios: %0.4f +/- %0.4f\n', damping_ratio_mean, damping_ratio_std);
fprintf('Natural frequencies: %0.3f rad/s +/- %0.3f rad/s\n', nat_freq_mean, nat_freq_std);