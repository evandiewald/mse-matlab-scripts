function [time,force,disp1,disp2] = readf2(file_name)
% Reads in the data from a text file
% input: file_name - name of the file
% output: data vectors of time, force, displacement, and velocity

temp = textread(file_name,'','headerlines',22);

time = temp(:,1);
force = temp(:,2);
disp1 = temp(:,3);
disp2 = temp(:,4);


end 