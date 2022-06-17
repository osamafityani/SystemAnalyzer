function varargout = steadyStateErrorDesginGUI(varargin)
% STEADYSTATEERRORDESGINGUI MATLAB code for steadyStateErrorDesginGUI.fig
%      STEADYSTATEERRORDESGINGUI, by itself, creates a new STEADYSTATEERRORDESGINGUI or raises the existing
%      singleton*.
%
%      H = STEADYSTATEERRORDESGINGUI returns the handle to a new STEADYSTATEERRORDESGINGUI or the handle to
%      the existing singleton*.
%
%      STEADYSTATEERRORDESGINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEADYSTATEERRORDESGINGUI.M with the given input arguments.
%
%      STEADYSTATEERRORDESGINGUI('Property','Value',...) creates a new STEADYSTATEERRORDESGINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before steadyStateErrorDesginGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to steadyStateErrorDesginGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help steadyStateErrorDesginGUI

% Last Modified by GUIDE v2.5 16-Jun-2022 19:40:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @steadyStateErrorDesginGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @steadyStateErrorDesginGUI_OutputFcn, ...
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


% --- Executes just before steadyStateErrorDesginGUI is made visible.
function steadyStateErrorDesginGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to steadyStateErrorDesginGUI (see VARARGIN)

% Choose default command line output for steadyStateErrorDesginGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes steadyStateErrorDesginGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = steadyStateErrorDesginGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

syms k

data = load('steadyStateErrorDesignData.mat');
step = data.step;
ramp = data.ramp;
parabolic = data.parabolic;
kRange = data.kRange;

ssETable = [step ramp parabolic];

set(handles.steadyStateErrorDesignTable,"data",sym2str(vpa(ssETable)))
set(handles.kRange,"string",sym2str(kRange))


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;       %Close the previous GUI