function [Sys] = ShowAs(TFNumerator,TFDenomerator,showAs)

% A function to determine the final type of the function

switch showAs
    case 1  %Transfer-function
        Sys = tf(TFNumerator,TFDenomerator);
    case 2  %Transfer-function to state-space conversion
        Sys = tf2ss(TFNumerator,TFDenomerator); %sys = [A ,B ,C ,D] 
    case 3  %Transfer function to zero-pole conversion
        Sys = tf2zp(TFNumerator,TFDenomerator); %sys = [zeros,poles,gain]       
        
end