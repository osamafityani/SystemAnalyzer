function [t, response] = parabolicResponse(sys, finalTime)
    [t, u] = generatePower(2, 0.01, finalTime);
    response = getResponse(sys, u, t);
end

