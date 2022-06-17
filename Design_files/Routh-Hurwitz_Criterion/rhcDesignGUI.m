function varargout = rhcDesignGUI(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rhcDesignGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @rhcDesignGUI_OutputFcn, ...
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


% --- Executes just before rhcDesignGUI is made visible.
function rhcDesignGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rhcDesignGUI (see VARARGIN)

% Choose default command line output for rhcDesignGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rhcDesignGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rhcDesignGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

syms k

data = load('rhcDesignData.mat');
conditions  = data.conditions;
RHTable = data.RHTable;
edit1RHTable = sym2str(RHTable);
len = length(edit1RHTable);
edit2RHTable = transpose([edit1RHTable(1:len/2); edit1RHTable(len/2+1:len)]);
set(handles.conditions,"string",sym2str(conditions))

set(handles.RHCTable,"data",edit2RHTable)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;       %Close the previous GUI