function varargout = steadyStateErrorGui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @steadyStateErrorGui_OpeningFcn, ...
                   'gui_OutputFcn',  @steadyStateErrorGui_OutputFcn, ...
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


% --- Executes just before steadyStateErrorGui is made visible.
function steadyStateErrorGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to steadyStateErrorGui (see VARARGIN)

% Choose default command line output for steadyStateErrorGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes steadyStateErrorGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
data = load('steadyStateErrorData.mat');
stable = data.stable;
step = data.step;
ramp = data.ramp;
parabolic = data.parabolic;

ssETable = [step ramp parabolic];

set(handles.StepSize,'Enable','off');
set(handles.text4,'Enable','off');
set(handles.FinalTime,'Enable','off');
set(handles.text3,'Enable','off');

if stable == 1
    set(handles.TheSysStabilityssE,"string","The System is stable.")
    set(handles.steadyStateErrorTable,"data",ssETable)
else
    set(handles.TheSysStabilityssE,"string","The System is Marginally or unstable.")
end

% --- Outputs from this function are returned to the command line.
function varargout = steadyStateErrorGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in steadyStateErrorTable.
function steadyStateErrorTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to steadyStateErrorTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function TheSysStabilityssE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TheSysStabilityssE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in getResponse.
function getResponse_Callback(hObject, eventdata, handles)
% hObject    handle to getResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns getResponse contents as cell array
%        contents{get(hObject,'Value')} returns selected item from getResponse
data = load('steadyStateErrorData.mat');

sys = data.sys;
operation = get(hObject,'Value');
finalTime = str2double(get(handles.FinalTime,"string"));

delete steadyStateErrorData.mat

switch operation
    case 2
        set(handles.StepSize,'Enable','on');
        set(handles.text4,'Enable','on');
        set(handles.FinalTime,'Enable','on');
        set(handles.text3,'Enable','on');
        stepSize = str2double(get(handles.StepSize,"string"));
        axes(handles.ErrorPlot)
        [t, y] = stepResponse(sys, stepSize, finalTime);
        plot(t,y)
    case 3
        set(handles.StepSize,'Enable','off');
        set(handles.text4,'Enable','off');
        set(handles.FinalTime,'Enable','on');
        set(handles.text3,'Enable','on');
        axes(handles.ErrorPlot)
        [t, y] = rampResponse(sys, finalTime);
        plot(t,y)
    case 4
        set(handles.StepSize,'Enable','off');
        set(handles.text4,'Enable','off');
        set(handles.FinalTime,'Enable','on');
        set(handles.text3,'Enable','on');
        axes(handles.ErrorPlot)
        [t, y] = parabolicResponse(sys, finalTime);
        plot(t,y)
end

% --- Executes during object creation, after setting all properties.
function getResponse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to getResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FinalTime_Callback(hObject, eventdata, handles)
% hObject    handle to FinalTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FinalTime as text
%        str2double(get(hObject,'String')) returns contents of FinalTime as a double


% --- Executes during object creation, after setting all properties.
function FinalTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FinalTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StepSize_Callback(hObject, eventdata, handles)
% hObject    handle to StepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StepSize as text
%        str2double(get(hObject,'String')) returns contents of StepSize as a double


% --- Executes during object creation, after setting all properties.
function StepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StepSize (see GCBO)
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
closereq;       %Close the actual GUI