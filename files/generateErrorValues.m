function errors = generateErrorValues()

data = load('steadyStateErrorDesignData.mat');

krange = data.kRange;


errorExpression = data.error;

errors = zeros(len(kvalues));
for i = 1:len(kValues)
    errors(i) = evaluateError(errorExpression,kValues(i));
end

