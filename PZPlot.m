function [] = PZPlot(TFNumerator,TFDenomerator)

%Shows the poles and zeros plot 

pzmap(tf(TFNumerator,TFDenomerator));

end

