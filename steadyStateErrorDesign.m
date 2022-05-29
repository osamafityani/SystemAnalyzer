function [step, ramp, parabolic, kRange] = steadyStateErrorDesign(forwardNum, forwardDen,backwardNum, backwardDen)
% find the steady state error with respect to K
syms k real
syms x
% find the characterstic equation

symG = sysFromSym(forwardNum, forwardDen);
symH = sysFromSym(backwardNum, backwardDen);
symSys = (symG)/(1 + symG * symH);
charEquation = getCharEquationSym(symSys);

kRange = rhcDesign(charEquation);

k = 1;
forwardNum = subs(forwardNum);
forwardNum = double(forwardNum);

syms k real
    
G = tf(forwardNum, forwardDen);
H = tf(backwardNum, backwardDen);

if length(kRange) == 1
    unityFeedbackSys = G / (1 + G *(H - 1));
    unityFeedbackSys = minreal(unityFeedbackSys);
    [unityNum, unityDen] = tfdata(unityFeedbackSys);    
    systemType = sum(roots(unityDen{1}) == 0) - sum(roots(unityNum{1}) == 0);
    errorConstant = unityNum{1}(end) / unityDen{1}(length(unityDen{1}) - systemType) * k;

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
    disp("System is either marginally stable or unstable for all values of K!");
    step = inf;
    ramp = inf;
    parabolic = inf;
end
end