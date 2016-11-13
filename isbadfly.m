function [goodbad] = isbadfly(times. crossing_data)
%ISBADFLY determines whether a trail with a fly is usable
%   [GOODBAD] = ISBADFLY(TIMES,CROSSINGS)
%
% Takes the input from a fly_*.txt file. 
% of this file column 1 = times(hrs) and 2 = crossing detected by break in
% LED beam. Sampling is 1/60 Hertz ~ 0.0166667. If there are more than 5
% min wihout a crossing the animal is considered asleep until it crosses
% again.
%
% INPUTS
%   times- continuous course of 96 hours
%   crossings - either a 0 for no or a 1 for yes
%
% OUTPUTS
%   goodbad - returns a 0 is the trial is ok and 1 if something is wrong. 
%   A trail is considered bad if the fly does not cross the beam for the
%   entire day or if the fly has tricked the sensor for every min of the
%   experiment. Also creates two plots to make sure the data is ok!

data = load('fly_001.txt','-ascii'); %from the code Steve gave us
times = data(:,1);
crossings = data(:,2);
figure;
plot(times,crossings);
ylabel('Crossing 0/1');
xlabel('Time(hr)');

a = crossings.'; 
N = length(a);
window = 5;
rollingsum = cumsum(a)-[zeros(1,window), cumsum(a(1:N-window))]; %sliding 
%window sums 5 points used to determine when a fly sleeps.
rollingsum.';

sleep = rollingsum < 1;
s = sleep.';
cell = mat2cell(s,repmat(30,192,1),1);%split matrix that is 5760x1 into 192 matrices that are 30x1.
minasleep = cellfun(@sum,cell); %number of minutes asleep out of 30.
halfhour = 0.5:0.5:96;
minasleep.';

figure;
plot(halfhour,minasleep);
xlabel('Time (hour)');
ylabel('Number of min asleep');
title('The sleeping pattern of a fly');

count_crossings = sum(crossings);
n = numel(crossings)
ratio = count_crossings/n 
if ratio == 1 
    goodbad = 1 %something is wrong
elseif ratio < 1
        goodbad = 0 % trail is ok   
end;
