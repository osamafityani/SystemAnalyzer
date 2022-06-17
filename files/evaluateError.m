function error = evaluateError(errorExpression,value)
syms k real
error = subs(errorExpression, k, value);
end

