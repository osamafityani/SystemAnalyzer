function [tf] = txtToTFConvertor(txt)

newStr = split(txt,',');
tf = transpose(str2double(newStr));
end