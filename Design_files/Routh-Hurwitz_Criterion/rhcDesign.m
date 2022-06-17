function [conditions,RHTable] = rhcDesign(coeffVector)

syms k real
% Coefficients vector & organizing the first two rows
ceoffLength = length(coeffVector);
RHTableColumn = round(ceoffLength/2);

%nitialize Routh-Hurwitz table with empty zero array
%RHTable = zeros (ceoffLength,RHTableColumn);
%  Compute first row of the table
RHTable(1,:) = coeffVector(1,1:2:ceoffLength);
RHTable(2:ceoffLength,:) = zeros (ceoffLength-1,RHTableColumn);

%  Check if length of coefficients vector is even or odd
if (rem(ceoffLength,2) ~= 0 )
    % if odd, second row of table will be
    RHTable(2,1:RHTableColumn - 1) = coeffVector(1,2:2:ceoffLength);
else
    % if even, second row of table will be
    RHTable(2,:) = coeffVector(1,2:2:ceoffLength);
end

%Calculate Routh-Hurwitz table's rows

epss = 0.01;

%  Calculate other elements of the table
for i = 3:ceoffLength

    
    % Second special case: row of all zeros
    if RHTable (i-1,:) == 0 
        order = (ceoffLength - i) + 2;
        cnt1 = 0;
        cnt2 = 1;
        for j = 1:RHTableColumn - 1
            RHTable(i-1,j) = (order - cnt1) * RHTable(i-2,cnt2);
            cnt2 = cnt2 + 1;
            cnt1 = cnt1 + 2;
        end
    end
    
    for j = 1:RHTableColumn - 1
        %  first element of upper row
        firstElemUpperRow = RHTable(i-1,1);
        
        %  compute each element of the table
        RHTable(i,j) = ((RHTable(i-1,1) * RHTable(i-2,j+1)) - (RHTable(i-2,1) * RHTable(i-1,j+1))) / firstElemUpperRow;
    end
    
    % First special Case: zero in the first column
    if RHTable (i,1) == 0
        RHTable (i,1) = epss;
    end
end

ksol = solve(RHTable(:,1)>0,k,'ReturnConditions',true);

digits(5)
conditions = vpa(ksol.conditions);
end
