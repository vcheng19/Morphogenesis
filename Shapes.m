function varargout = Shapes(varargin)
% SHAPES MATLAB code for Shapes.fig
%      SHAPES, by itself, creates a new SHAPES or raises the existing
%      singleton*.
%
%      H = SHAPES returns the handle to a new SHAPES or the handle to
%      the existing singleton*.
%
%      SHAPES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHAPES.M with the given input arguments.
%
%      SHAPES('Property','Value',...) creates a new SHAPES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Shapes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Shapes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Shapes

% Last Modified by GUIDE v2.5 27-May-2016 13:45:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Shapes_OpeningFcn, ...
                   'gui_OutputFcn',  @Shapes_OutputFcn, ...
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

% --- Executes just before Shapes is made visible.
function Shapes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Shapes (see VARARGIN)

clearvars -GLOBAL LocationMatrix
global pos;
global pos2;
global curvature;
global counter;

counter = 1;
pos = [1 1 1 1];
pos2 = [2 2 1.5 1.5];
color1 = [1 0 0];
color2 = [0 1 0];
curvature = [1 1];
%rectangle('Position',pos,'Curvature',curvature,'FaceColor',color1);
%rectangle('Position',pos2,'Curvature',curvature,'FaceColor',color2);
axis([0 5 0 5]);
axis equal;

% Choose default command line output for Shapes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Shapes wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Shapes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in initial_popup.
function initial_popup_Callback(hObject, eventdata, handles)
% hObject    handle to initial_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns initial_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from initial_popup

% global pos;
% global pos2;
% global curvature;
% 
% str = get(hObject, 'String');
% val = get(hObject, 'Value');
% switch str{val}
%     case 'Red'
%         new_color = [1 0 0];
%     case 'Green'
%         new_color = [0 1 0];
%     case 'Blue'
%         new_color = [0 0 1];
% end
% 
% rectangle('Position', pos,'Curvature', curvature,'FaceColor',new_color);
% rectangle('Position', pos2,'Curvature', curvature,'FaceColor',new_color);
% axis([0 5 0 5]);
% axis equal



% --- Executes during object creation, after setting all properties.
function initial_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initial_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in delete_button.
function delete_button_Callback(hObject, eventdata, handles)
% hObject    handle to delete_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clearvars -GLOBAL LocationMatrix;
clear, clc
close(gcbf)
Shapes

% --- Executes on button press in add_button.
function add_button_Callback(hObject, eventdata, handles)
% hObject    handle to add_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global counter;
global small_size;
small_size = 0.4;
a = 5*rand;
b = 5*rand;
rand_color = [rand rand rand];
rectangle('Position',[a b small_size small_size],'Curvature',[1 1],'FaceColor',rand_color);
hold on
global LocationMatrix;
LocationMatrix(counter, :) = [counter a b rand_color];
assignin('base','LocationMatrix', LocationMatrix);
counter = counter + 1;

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


% --- Executes on selection change in change_popup.
function change_popup_Callback(hObject, eventdata, handles)
% hObject    handle to change_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns change_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from change_popup
global LocationMatrix;
global small_size;
str = get(hObject, 'String');
val = get(hObject, 'Value');
switch str{val}
    case 'Red'
        edit_color = [1 0 0];
    case 'Green'
        edit_color = [0 1 0];
    case 'Blue'
        edit_color = [0 0 1];
end
edit_number = str2num(get(handles.edit1, 'String'));
if edit_number > size(LocationMatrix,1)
    error('Not enough circles!')
end
rectangle('Position',[LocationMatrix(edit_number, 2) ...
    LocationMatrix(edit_number, 3) small_size small_size], ...
    'Curvature',[1 1],'FaceColor',edit_color);

% --- Executes during object creation, after setting all properties.
function change_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to change_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function line_from_Callback(hObject, eventdata, handles)
% hObject    handle to line_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of line_from as text
%        str2double(get(hObject,'String')) returns contents of line_from as a double

% --- Executes during object creation, after setting all properties.
function line_from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to line_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function line_to_Callback(hObject, eventdata, handles)
% hObject    handle to line_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of line_to as text
%        str2double(get(hObject,'String')) returns contents of line_to as a double


% --- Executes during object creation, after setting all properties.
function line_to_CreateFcn(hObject, eventdata, handles)
% hObject    handle to line_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in line_popup.
function line_popup_Callback(hObject, eventdata, handles)
% hObject    handle to line_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns line_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from line_popup
global LocationMatrix;
global small_size;
str = get(hObject, 'String');
val = get(hObject, 'Value');
switch str{val}
    case 'Red'
        line_color = [1 0 0];
    case 'Green'
        line_color = [0 1 0];
    case 'Blue'
        line_color = [0 0 1];
end
from_point = str2num(get(handles.line_from, 'String'));
to_point = str2num(get(handles.line_to, 'String'));
line([LocationMatrix(from_point,2) + (small_size/2) LocationMatrix(to_point,2) + (small_size/2)], ...
    [LocationMatrix(from_point,3) + (small_size/2) LocationMatrix(to_point, 3) + (small_size/2)], ...
    'Marker','.','LineStyle','-', 'Color', line_color);

% --- Executes during object creation, after setting all properties.
function line_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to line_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function terp1_Callback(hObject, eventdata, handles)
% hObject    handle to terp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of terp1 as text
%        str2double(get(hObject,'String')) returns contents of terp1 as a double


% --- Executes during object creation, after setting all properties.
function terp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to terp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function terp2_Callback(hObject, eventdata, handles)
% hObject    handle to terp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of terp2 as text
%        str2double(get(hObject,'String')) returns contents of terp2 as a double


% --- Executes during object creation, after setting all properties.
function terp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to terp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function terp3_Callback(hObject, eventdata, handles)
% hObject    handle to terp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of terp3 as text
%        str2double(get(hObject,'String')) returns contents of terp3 as a double


% --- Executes during object creation, after setting all properties.
function terp3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to terp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function terp4_Callback(hObject, eventdata, handles)
% hObject    handle to terp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of terp4 as text
%        str2double(get(hObject,'String')) returns contents of terp4 as a double


% --- Executes during object creation, after setting all properties.
function terp4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to terp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in terp_button.
function terp_button_Callback(hObject, eventdata, handles)
% hObject    handle to terp_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LocationMatrix;
global small_size
pt1 = str2num(get(handles.terp1, 'String'));
pt2 = str2num(get(handles.terp2, 'String'));
pt3 = str2num(get(handles.terp3, 'String'));
pt4 = str2num(get(handles.terp4, 'String'));
X = [LocationMatrix(pt1,2) + small_size/2 LocationMatrix(pt2,2) + small_size/2 ...
    LocationMatrix(pt3,2) + small_size/2 LocationMatrix(pt4,2) + small_size/2];
V = [LocationMatrix(pt1,3) + small_size/2 LocationMatrix(pt2,3) + small_size/2 ...
    LocationMatrix(pt3,3) + small_size/2 LocationMatrix(pt4,3) + small_size/2];
Xq = linspace(min(X(:)), max(X(:)), 100);
Vq = interp1(X,V,Xq, 'spline');
hold on
plot(Xq, Vq)
axis([0 10 0 10])