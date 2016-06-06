function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 03-Jun-2016 14:43:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.thresh_slide,'Value',0.5);
imshow(zeros(150));

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pb_load.
function pb_load_Callback(hObject, eventdata, handles)
% hObject    handle to pb_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global TIFF;
[filename, pathname] = uigetfile({'*.tif';'*.*'}, 'Pick an Image File');
img = imread([pathname,filename]);
TIFF = loadtiff([pathname,filename]);
set(handles.edit1,'String',[pathname,filename]);
axes(handles.img_display);
imshow(img);
set(handles.img_display,'Visible','off');
guidata(hObject, handles);


% --- Executes on button press in segment_button.
function segment_button_Callback(hObject, eventdata, handles)
% hObject    handle to segment_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global B;
thresh_slide = get(handles.thresh_slide, 'Value');
thresh_level = str2num(get(handles.thresh_level, 'Str'));
img_new = imadjust(imadjust(imadjust(img)));
if isempty(thresh_level)
    A = im2bw(img_new, thresh_slide);
else
    A = im2bw(img_new, thresh_level);
end
A = imclose(A,strel('disk',1));
B = bwmorph(A,'thin','Inf');
imshow(B);
%colormap([1 1 1; 0 0 1])


% --- Executes on slider movement.
function thresh_slide_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global current;
segment_button_Callback(handles.segment_button, eventdata, handles);
overlay_button_Callback(handles.overlay_button,eventdata,handles);;
pull_down_Callback(handles.pull_down, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function thresh_slide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function thresh_level_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_level as text
%        str2double(get(hObject,'String')) returns contents of thresh_level as a double


% --- Executes during object creation, after setting all properties.
function thresh_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imsave;

% --- Executes on button press in overlay_button.
function overlay_button_Callback(hObject, eventdata, handles)
% hObject    handle to overlay_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global B;
global junk;
global current;
junk = img;
junk = repmat(double(img)./255,[1 1 3]);
sizee = size(B);
for r = 1:sizee(1)
    for c = 1:sizee(2)
        if B(r,c) == 1
            junk(r,c,:) = [1,0,0];
        end
    end
end
imshow(current);


% --- Executes on selection change in pull_down.
function pull_down_Callback(hObject, eventdata, handles)
% hObject    handle to pull_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pull_down contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pull_down
global current;
global B;
global junk;
str = get(hObject, 'String');
val = get(hObject, 'Value');
switch str{val}
    case 'Binary'
        current = B;
    case 'Overlay'
        current = junk;
end
imshow(current);

% --- Executes during object creation, after setting all properties.
function pull_down_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pull_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in se    nd_button.
function send_button_Callback(hObject, eventdata, handles)
% hObject    handle to send_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global B;
imwrite(B,'myGTRough.png');
closereq;
SubGUI;