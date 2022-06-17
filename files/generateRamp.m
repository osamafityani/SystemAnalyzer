function [time, ramp] = generateRamp(slope, sampleTime, finalTime)
time = 0:sampleTime:finalTime;
ramp = slope .* time;
end