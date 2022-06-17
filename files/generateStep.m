function [time, step] = generateStep(k, sampleTime, stepTime, finalTime)
%GENERATESTEP Summary of this function goes here
%   Detailed explanation goes here
timeseries = frest.createStep('Ts',sampleTime, 'StepTime',stepTime,'StepSize',k,'FinalTime',finalTime);
time = timeseries.Time';
step = timeseries.Data';
end

