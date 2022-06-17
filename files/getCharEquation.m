function charEquation = getCharEquation(sys)
%GETCHAREQUATION Returns the characteristic equation of a system
%   sys: transfer function
%   charEquation: coefficients vector
sys = minreal(sys);
[~, den] = tfdata(sys);
charEquation = den{1};
end

