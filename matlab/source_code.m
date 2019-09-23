function varargout = source_code(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 17-Sep-2019 13:49:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @source_code_OpeningFcn, ...
                   'gui_OutputFcn',  @source_code_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function source_code_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = source_code_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function file_name_Callback(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_name as text
%        str2double(get(hObject,'String')) returns contents of file_name as a double


% --- Executes during object creation, after setting all properties.
function file_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channel_value_Callback(hObject, eventdata, handles)
% hObject    handle to channel_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel_value as text
%        str2double(get(hObject,'String')) returns contents of channel_value as a double


% --- Executes during object creation, after setting all properties.
function channel_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_get.
function button_get_Callback(hObject, eventdata, handles)
% hObject    handle to button_get (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global image;
    global pic;
    global filename;
    [filename,pathname] = uigetfile('Select file');

    image=strcat(pathname, filename);
    pic=imread(image);

    axes(handles.image_input); imshow(pic);
    axes(handles.image_output); cla;

    set (handles.file_name, 'string', filename);


% --- Executes on button press in button_clear.
function button_clear_Callback(hObject, eventdata, handles)
% hObject    handle to button_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.image_input); cla;
axes(handles.image_output); cla;
set(handles.file_name, 'string', '');
set(handles.channel_value, 'string', '');

% --- Executes on button press in button_red.
function button_red_Callback(hObject, eventdata, handles)
% hObject    handle to button_red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global  pic;
red=pic;
red(:,:,2) = 0;
red(:,:,3) = 0;
axes(handles.image_output); imshow(red);
mean_red=mean(mean(red(:,:,1)));
xyz=sprintf('avg value: %4.2f', mean_red);
set(handles.channel_value, 'string', xyz);


% --- Executes on button press in button_blue.
% Blue Button
function button_blue_Callback(hObject, eventdata, handles)
% hObject    handle to button_blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global pic;
blue=pic;
blue(:,:,1)=0; 
blue(:,:,2)=0;
axes(handles.image_output); imshow(blue);
mean_blue=mean(mean(blue(:,:,3)));
xyz=sprintf('avg value: %4.2f', mean_blue);
set(handles.channel_value, 'string', xyz);


% --- Executes on button press in button_green.
% Green button
function button_green_Callback(hObject, eventdata, handles)
% hObject    handle to button_green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global pic;
green= pic;
green(:,:,1)=0;
green(:,:,3)=0;
axes(handles.image_output); imshow(green);
mean_green=mean(mean(green(:,:,2)));
xyz=sprintf('avg value: %4.2f', mean_green);
set(handles.channel_value, 'string', xyz);



% --- Executes on button press in button_grey.
function button_grey_Callback(hObject, eventdata, handles)
% hObject    handle to button_grey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pic;

% gray = pic;
gray = rgb2gray(pic);
axes(handles.image_output); imshow(gray);
mean_gray=mean(mean(gray));
xyz=sprintf('avg. value: %4.2f', mean_gray);
set(handles.channel_value, 'string', xyz);

% --- Executes on button press in button_yellow.
function button_yellow_Callback(~, eventdata, handles)
% hObject    handle to button_yellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;

yellow = pic;
yellow(:,:,3)=0;
axes(handles.image_output); imshow(yellow);

mean_yellow=(mean(mean(yellow(:,:,1)))+mean(mean(yellow(:,:,2))))/2;

xyz=sprintf('avg value: %4.2f', mean_yellow);
set(handles.channel_value, 'string', xyz);

% --- Executes on button press in button_magenta.
function button_magenta_Callback(hObject, eventdata, handles)
% hObject    handle to button_magenta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
magenta = pic;
magenta(:,:,2)=0;
axes(handles.image_output); imshow(magenta);

mean_magenta = (mean(mean(magenta(:,:,1)))+mean(mean(magenta(:,:,3))))/2;

xyz=sprintf('avg value: %4.2f', mean_magenta);
set(handles.channel_value, 'string', xyz);

% --- Executes on button press in button_exit.
function button_exit_Callback(hObject, eventdata, handles)
% hObject    handle to button_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();

% --- Executes on button press in button_cyan.
function button_cyan_Callback(hObject, eventdata, handles)
% hObject    handle to button_cyan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;

cyan = pic;
cyan(:,:,1)=0;
axes(handles.image_output); imshow(cyan);
mean_cyan=(mean(mean(cyan(:,:,2)))+mean(mean(cyan(:,:,3))))/2;
xyz=sprintf('avg value: %4.2f', mean_cyan);
set(handles.channel_value, 'string', xyz);
