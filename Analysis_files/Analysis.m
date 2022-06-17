function varargout = Analysis(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @Analysis_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function Analysis_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);


function varargout = Analysis_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function InsertNumAnalysis_Callback(hObject, eventdata, handles)


function InsertNumAnalysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InsertNumAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function InsertDenAnalysis_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function InsertDenAnalysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InsertDenAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in WhatToApply.
function WhatToApply_Callback(hObject, eventdata, handles)

Numstr=get(handles.InsertNumAnalysis,"string");
Numtf=txtToTFConvertor(Numstr);

Denstr=get(handles.InsertDenAnalysis,"string");
Dentf=txtToTFConvertor(Denstr);

tfsys = tf(Numtf,Dentf);

Numfeedbackstr = get(handles.NumFeedBackFunction,"string");
Numfeedbacktf = txtToTFConvertor(Numfeedbackstr);
Denfeedbackstr = get(handles.DenFeedBackFunction,"string");
Denfeedbacktf = txtToTFConvertor(Denfeedbackstr);
feedbacktf = tf(Numfeedbacktf,Denfeedbacktf);
sys = feedback(tfsys,feedbacktf,-1);

charEquation = tfsys / (1 + tfsys * feedbacktf);
CharEquationSimplified = minreal(charEquation);
finalCharEquation = getCharEquation(CharEquationSimplified);

operation = get(hObject,'Value');

switch operation
    case 2
        [stable, RHTable, sysRoots] = rhc(finalCharEquation);
        [rhs, jw, lhs] = polesPositions(finalCharEquation);
        save('rhcData.mat','-v7.3')
        save rhcData.mat stable RHTable sysRoots Numtf Dentf rhs lhs jw
        run("rhcGui.m")
    case 3
        [stable, step, ramp, parabolic] = steadyStateError(tfsys,feedbacktf);
        save('steadyStateErrorData.mat','-v7.3')
        save steadyStateErrorData.mat stable step ramp parabolic sys
        run("steadyStateErrorGui.m")
    case 4
        RLocusGui(charEquation)
end

% --- Executes during object creation, after setting all properties.
function WhatToApply_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WhatToApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumFeedBackFunction_Callback(hObject, eventdata, handles)
% hObject    handle to NumFeedBackFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumFeedBackFunction as text
%        str2double(get(hObject,'String')) returns contents of NumFeedBackFunction as a double


% --- Executes during object creation, after setting all properties.
function NumFeedBackFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumFeedBackFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DenFeedBackFunction_Callback(hObject, eventdata, handles)
% hObject    handle to DenFeedBackFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DenFeedBackFunction as text
%        str2double(get(hObject,'String')) returns contents of DenFeedBackFunction as a double


% --- Executes during object creation, after setting all properties.
function DenFeedBackFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DenFeedBackFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open("Control_Processes.fig")     %Open the new GUI 
closereq;       %Close the previous GUI
