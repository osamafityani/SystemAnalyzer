function [rhs, lhs, jw] = polesPositions(charEquation)
    r = roots(charEquation);
    rhs = length(r(real(r) > 0));
    jw = length(r(real(r) == 0));
    lhs = length(r(real(r) < 0));
end

