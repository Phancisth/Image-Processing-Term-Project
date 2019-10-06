function varargout = project_design(varargin)
% PROJECT_DESIGN MATLAB code for project_design.fig
%      PROJECT_DESIGN, by itself, creates a new PROJECT_DESIGN or raises the existing
%      singleton*.
%
%      H = PROJECT_DESIGN returns the handle to a new PROJECT_DESIGN or the handle to
%      the existing singleton*.
%
%      PROJECT_DESIGN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT_DESIGN.M with the given input arguments.
%
%      PROJECT_DESIGN('Property','Value',...) creates a new PROJECT_DESIGN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before project_design_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to project_design_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help project_design

% Last Modified by GUIDE v2.5 23-Sep-2019 18:09:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_design_OpeningFcn, ...
                   'gui_OutputFcn',  @project_design_OutputFcn, ...
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


% --- Executes just before project_design is made visible.
function project_design_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project_design (see VARARGIN)

% Choose default command line output for project_design
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes project_design wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = project_design_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global image;
    global pic;
    global filename;
    % [filename pathname] = uigetfile({'*.bmp','*.jpg'}, 'file select');
    [filename pathname] = uigetfile('.jpg', 'file select');

    image = strcat(pathname, filename);
    pic=imread(image);

    axes(handles.axes1); imshow(pic);
    axes(handles.axes2); cla;

    set (handles.edit1, 'string', filename);

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla;
axes(handles.axes2); cla;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in analyze.
function analyze_Callback(hObject, eventdata, handles)
% hObject    handle to analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% TRAINING CODE
now1 = tic();
global image;
global pic;
global filename;
global excel;
global maskedRgbImage;
%global grayImage;

excel = 'E:\OneDrive\MUICT Year 4 Semester 1\Digital Image Processing\image-processing-project\test_me.xlsx';

tab=xlsread(excel);
[rr,cc]=size(tab);

%resize
pic = imresize(pic, [400 400]);

%....................................................................................
[rows, columns, numberOfColorBands] = size(pic);
if numberOfColorBands > 1
      % Convert it to gray scale by taking only the green channel.
      % The green channel will have the highest contrast for these green seeds.
      grayImage = pic(:, :, 2); % Take green channel.
end

% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')

[pixelCount, grayLevels] = imhist(grayImage);
binaryImage = grayImage > 120;

binaryImage = imclearborder(binaryImage);
binaryImage = imfill(binaryImage, 'holes');
binaryImage = bwareaopen(binaryImage, 500);

maskedRgbImage = bsxfun(@times, pic, cast(binaryImage, class(pic)));
%....................................................................................
%   Debug
%   figure(); imshow(maskedRgbImage);
% ............................ Calculate Features

 data(1)=mean(mean(maskedRgbImage(:,:,1)))/100;
 data(2)=mean(mean(maskedRgbImage(:,:,2)))/100;
 data(3)=mean(mean(maskedRgbImage(:,:,3)))/100;
 gray=rgb2gray(maskedRgbImage); data(4)=mean(mean(gray))/100;
 rngfil=rangefilt(maskedRgbImage);  
 entro=entropy(rngfil)/10; data(5)=entro;
 glcm=graycomatrix(gray,'O', [0,1]);
 S=graycoprops(glcm);
 data(6)=S.Energy;
 data(7)=S.Correlation;
 data(8)=S.Contrast*10;
 data(9)=S.Homogeneity;

% ............................ Matching 

min=999;
rec=0;
for i = 1 : rr
    diff=0;    
    for j=1 : cc
        diff=diff+sqrt(power(tab(i,j)-data(j))); 
    end
    if (diff <= 0 ) 
        min=diff;
        rec=i;
    end
end

if (rec ~= 0)
   
      %import thai name
   cellx=cat(2,'L',num2str(rec+1));
   [~,ff]=xlsread(excel,1,cellx);
   file=ff{1};
   set (handles.edit3, 'string',file);
    
      %import specific name
   cellx=cat(2,'M',num2str(rec+1));
   [~,ff]=xlsread(excel,1,cellx);
   file=ff{1};
   set (handles.edit4, 'string',file);
   
      %import info
   cellx=cat(2,'N',num2str(rec+1));
   [~,ff]=xlsread(excel,1,cellx);
   file=ff{1}
   set (handles.edit5, 'string',file);
    
   % import image file
   cellx=cat(2,'K',num2str(rec+1));
   [~,ff]=xlsread(excel,1,cellx);
   file=ff{1};
   result=imread(file);
   axes(handles.axes2); imshow(result);
   file=strrep(file,'.jpg','')
   set (handles.edit2, 'string',file);
   
else
   fig=zeros(250,300);
   axes(handles.axes2); imshow(fig);
   set (handles.edit2, 'string','*** Image Not Found ***');
end

% --- Executes on button press in result.
function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
