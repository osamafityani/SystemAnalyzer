function [there_is_multik] = kmultichecker(symk)

a = length(find(symk=='/')) + length(find(symk=='/')) + length(find(symk=='\')) + length(find(symk=='+')) + length(find(symk=='-')) + length(find(symk=='*'));
if a == 0
    there_is_multik = true;
else
    there_is_multik = false;
end
end

