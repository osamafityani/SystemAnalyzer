function [ksyms_sorted] = txtToTFConvertorDesign(txt)


Str = txt;
commas = false(size(Str));
commas( regexp(txt,',')) = true;
commas = commas *5;

have_k = false( size( Str ) );
have_k( regexp(Str,'k')) = true;

strList = commas + have_k;
strListstr = transpose(split(num2str(strList),'5'));
doubleStrList = str2double(strListstr);
index_have_k_str = isnan(doubleStrList);
w_have_k_str = find(index_have_k_str);
index_not_have_k_str = not(index_have_k_str);
w_not_have_k_str = find(index_not_have_k_str);
split_txt = split(txt,',');
symsStr = transpose(split_txt(index_have_k_str));
symslength = length(split_txt(index_have_k_str));

ksyms = sym(zeros(symslength,1))';
for i = 1: symslength
    if kmultichecker(symsStr{i}) == true
        ksym = symsStr{i};
        newksym = insertBefore(ksym,'k','*');
        ksyms(i) = str2sym(newksym);
    else
        kex = symsStr{i};
        ksyms(i) = str2sym(kex);
    end
end

numvals = transpose(split_txt(index_not_have_k_str));
numvs = zeros(1,length(numvals));

for i = 1:length(numvals)
    numvs(i) = str2double(numvals{i});
end

numsarr = [w_not_have_k_str w_have_k_str];
dfarr = [numvs ksyms];

[~,I] = sort(numsarr);
ksyms_sorted = dfarr(I);

end