function [stable, step, ramp, parabolic] = steadyStateError(G,H)
%{
find the steady state error of any closed loop system due to step, ramp,
and parablic input
%}



% find the characterstic equation
sys = G / (1 + G * H);
sys = minreal(sys);
charEquation = getCharEquation(sys);
stable = rhc(charEquation);

if stable == 1
    unityFeedbackSys = G / (1 + G *(H - 1));
    unityFeedbackSys = minreal(unityFeedbackSys);
    [unityNum, unityDen] = tfdata(unityFeedbackSys);    
    systemType = sum(roots(unityDen{1}) == 0) - sum(roots(unityNum{1}) == 0);
    errorConstant = unityNum{1}(end) / unityDen{1}(length(unityDen{1}) - systemType);

    switch systemType
        case 0
            step = 1 / (1 + errorConstant);
            ramp = inf;
            parabolic = inf;
        case 1
            step = 0;
            ramp = 1 / errorConstant;
            parabolic = inf;
        case 2
            step = 0;
            ramp = 0;
            parabolic = 1 / errorConstant;
        otherwise
            step = 0;
            ramp = 0;
            parabolic = 0;
    end
    
else
    disp("System is either marginally stable or unstable!");
    step = inf;
    ramp = inf;
    parabolic = inf;
end
end

