function [t, response] = rampResponse(sys, finalTime)
    [t, u] = generateRamp(1, 0.01, finalTime);
    response = getResponse(sys, u, t);
end

