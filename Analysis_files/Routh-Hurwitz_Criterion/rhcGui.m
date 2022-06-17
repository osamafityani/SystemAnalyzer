function varargout = rhcGui(varargin)


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rhcGui_OpeningFcn, ...
                   'gui_OutputFcn',  @rhcGui_OutputFcn, ...
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


% --- Executes just before rhcGui is made visible.
function rhcGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rhcGui (see VARARGIN)

% Choose default command line output for rhcGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rhcGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rhcGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

data = load('rhcData.mat');
stable  = data.stable;
RHTable = data.RHTable;
sysPoles = data.sysRoots;
rhs = data.rhs;
lhs = data.lhs;
jw = data.jw;
syspolespositions = [lhs, jw, rhs];

if stable == 1
    set(handles.TheSysStability,"string","The System is stable.")
elseif stable == 0
    set(handles.TheSysStability,"string","The System is Marginally stable.")
else
    set(handles.TheSysStability,"string","The System is not stable.")
end

set(handles.rhcTable,"data",RHTable)
set(handles.rhcRootsTable,"data",sysPoles)
set(handles.polesPositionsTable,"data",syspolespositions)

axes(handles.rootsAxis);
tfsys = tf(data.Numtf,data.Dentf);
pzmap(tfsys);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;       %Close the actual GUI