function [time, power] = generatePower(degree, sampleTime, finalTime)
%GENERATEPARABOLIC Summary of this function goes here
%   Detailed explanation goes here
time = 0:sampleTime:finalTime;
power = time .^ degree;
end

