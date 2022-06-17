function varargout = Design(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Design_OpeningFcn, ...
                   'gui_OutputFcn',  @Design_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Design is made visible.
function Design_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Design (see VARARGIN)

% Choose default command line output for Design
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Design wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Design_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Numtf_Callback(hObject, eventdata, handles)
% hObject    handle to Numtf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Numtf as text
%        str2double(get(hObject,'String')) returns contents of Numtf as a double


% --- Executes during object creation, after setting all properties.
function Numtf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Numtf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dentf_Callback(hObject, eventdata, handles)
% hObject    handle to Dentf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dentf as text
%        str2double(get(hObject,'String')) returns contents of Dentf as a double


% --- Executes during object creation, after setting all properties.
function Dentf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dentf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in WhatToApply.
function WhatToApply_Callback(hObject, eventdata, handles)
syms k

Numstr=get(handles.Numtf,"string");
Numtf=txtToTFConvertorDesign(Numstr);

Denstr=get(handles.Dentf,"string");
Dentf=txtToTFConvertorDesign(Denstr);


Numfeedbackstr = get(handles.Numfeedback,"string");
Numfeedbacktf = txtToTFConvertorDesign(Numfeedbackstr);

Denfeedbackstr = get(handles.Denfeedback,"string");
Denfeedbacktf = txtToTFConvertorDesign(Denfeedbackstr);


symG = sysFromSym(Numtf, Dentf);
symH = sysFromSym(Numfeedbacktf, Denfeedbacktf);
symSys = (symG)/(1 + symG * symH);
charEquation = getCharEquationSym(symSys);

operation = get(hObject,'Value');

switch operation
    case 2
        [conditions,RHTable] = rhcDesign(charEquation);
        save('rhcDesignData.mat','-v7.3')
        save rhcDesignData.mat conditions RHTable  Numtf Dentf
        run("rhcDesignGUI.m")
    case 3
        [step, ramp, parabolic, kRange, error] = steadyStateErrorDesign(Numtf, Dentf, Numfeedbacktf, Denfeedbacktf);
        save('steadyStateErrorDesignData.mat','-v7.3')
        save steadyStateErrorDesignData.mat step ramp parabolic kRange error
        run("steadyStateErrorDesignGUI.m")
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



function Numfeedback_Callback(hObject, eventdata, handles)
% hObject    handle to Numfeedback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Numfeedback as text
%        str2double(get(hObject,'String')) returns contents of Numfeedback as a double


% --- Executes during object creation, after setting all properties.
function Numfeedback_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Numfeedback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Denfeedback_Callback(hObject, eventdata, handles)
% hObject    handle to Denfeedback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Denfeedback as text
%        str2double(get(hObject,'String')) returns contents of Denfeedback as a double


% --- Executes during object creation, after setting all properties.
function Denfeedback_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Denfeedback (see GCBO)
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