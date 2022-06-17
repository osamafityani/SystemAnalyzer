function symSys = sysFromSym(symNum, symDen)
symSys = poly2sym(symNum)/ poly2sym(symDen);
end

