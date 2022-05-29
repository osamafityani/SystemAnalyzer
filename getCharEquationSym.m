function charEquationSym = getCharEquationSym(symSys)
%GETCHAREQUATIONSYM Summary of this function goes here
%   Detailed explanation goes here
symSys = simplify(symSys);
[~, den] = numden(symSys);
charEquationSym = coeffs(den, x);
end

