function varargout = Control_Processes(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Control_Processes_OpeningFcn, ...
                   'gui_OutputFcn',  @Control_Processes_OutputFcn, ...
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


function Control_Processes_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);


function varargout = Control_Processes_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function AnalysisPushButton_Callback(hObject, eventdata, handles)

run("Analysis.m")       %Open the new GUI 
closereq;       %Close the actual GUI 

function DesignPushButton_Callback(hObject, eventdata, handles)

run("Design.m")     %Open the new GUI 
closereq;       %Close the previous GUI