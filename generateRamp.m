function [time, ramp] = generateRamp(slope, sampleTime, finalTime)
%GENERATERAMP Summary of this function goes here
%   Detailed explanation goes here

time = 0:sampleTime:finalTime;
ramp = slope .* time;
end