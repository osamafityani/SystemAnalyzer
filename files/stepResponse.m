function [t, response] = stepResponse(sys, k, finalTime)
   [t, u] =  generateStep(k, 0.01, 0, finalTime);
   response = getResponse(sys, u, t);
end

