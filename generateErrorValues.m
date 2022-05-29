function errors = generateErrorValues(errorExpression,kValues)
%GENERATEERRORVALUES Summary of this function goes here
%   Detailed explanation goes here
errors = zeros(len(kvalues));
for i = 1:len(kValues)
    errors(i) = evaluateError(errorExpression,kValues(i));
end

