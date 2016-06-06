function varargout = SubGUI(varargin)
% SUBGUI MATLAB code for SubGUI.fig
%      SUBGUI, by itself, creates a new SUBGUI or raises the existing
%      singleton*.
%
%      H = SUBGUI returns the handle to a new SUBGUI or the handle to
%      the existing singleton*.
%
%      SUBGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBGUI.M with the given input arguments.
%
%      SUBGUI('Property','Value',...) creates a new SUBGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SubGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SubGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SubGUI

% Last Modified by GUIDE v2.5 03-Jun-2016 15:24:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SubGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SubGUI_OutputFcn, ...
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


% --- Executes just before SubGUI is made visible.
function SubGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SubGUI (see VARARGIN)

% Choose default command line output for SubGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SubGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Rough GT is displayed here
global B;
B = imread('myGTRough.png');
imshow(B)

global store;
[m,n] = size(B);
store = zeros(m,n,4);
store(:,:,1)=B;
store(:,:,2)=B;
store(:,:,3)=B;
store(:,:,4)=B;



% --- Outputs from this function are returned to the command line.
function varargout = SubGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in delete_button.
function delete_button_Callback(hObject, eventdata, handles)
% hObject    handle to delete_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global B;
global current;


rect = getrect;
Xmin = round(rect(1)); Xmax = Xmin + round(rect(3));
Ymin = round(rect(2)); Ymax = Ymin + round(rect(4));
X = Xmin:Xmax; Y = Ymin:Ymax;
for m = 1:length(X)
    for n = 1:length(Y)
        B(Y(n),X(m)) = 0;
    end
end
%B(Y,X) = 0;
overlay_Callback(handles.overlay,eventdata,handles);
pull_down_Callback(handles.pull_down, eventdata, handles)
imshow(current);

global store;
store(:,:,1) = store(:,:,2);
store(:,:,2) = store(:,:,3);
store(:,:,3) = store(:,:,4);
store(:,:,4) = current;


delete_button_Callback(handles.delete_button, eventdata, handles);



% --- Executes on button press in interp_button.
function interp_button_Callback(hObject, eventdata, handles)
% hObject    handle to interp_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global B;
global current;
[xinp, yinp] = ginputc('Color', 'r', 'LineWidth', 1);
temp2 = size(xinp);
row = temp2(1);
    if row == 1
       xx = round(xinp(1));
       yy = round(yinp(1));
       B(xx, yy) = 1;
       imshow(B);
       return;
    end
for i = 1:row-1
    first = round([xinp(i), yinp(i)]);
    second = round([xinp(i+1), yinp(i+1)]);
    deltax = second(1) - first(1);
    deltay = second(2) - first(2);
    slope = deltay/deltax;
    x0 = first(1);
    y0 = first(2);
    y = @(x) y0 + slope*(x - x0);
    x = @(y) (y-y0)/slope + x0;
    if abs(deltax) > abs(deltay)
        if x0 < second(1)
            for j = x0:second(1)
                y1 = round(y(j));
                B(y1,j) = 1;
            end
        else
            for j = second(1):x0
                y1 = round(y(j));
                B(y1,j) = 1;
            end
        end
    else
        if y0 < second(2)
            for j = y0:second(2)
                x1 = round(x(j));
                B(j, x1) = 1;
            end
        else
            for j = second(2):y0
                x1 = round(x(j));
                B(j, x1) = 1;
            end
        end
        
    end
    overlay_Callback(handles.overlay,eventdata,handles);
    pull_down_Callback(handles.pull_down, eventdata, handles)
    imshow(current);
end

global store;
store(:,:,1) = store(:,:,2);
store(:,:,2) = store(:,:,3);
store(:,:,3) = store(:,:,4);
store(:,:,4) = current;
%global store;
%store(:,:,1) = store(:,:,2);
%store(:,:,2) = store(:,:,3);
%store(:,:,3) = store(:,:,4);
%store(:,:,4) = B;


% --- Executes on button press in send_button.
function send_button_Callback(hObject, eventdata, handles)
% hObject    handle to send_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global B;
global TIFF;
imwrite(B,'myGT.png')
assignin('base','TIFF',TIFF);
setup;
RUNME;
fprintf('Done with segmentation!\n')

% --- Executes on selection change in pull_down.
function pull_down_Callback(hObject, eventdata, handles)
% hObject    handle to pull_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pull_down contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pull_down
global B;
global junk;
global current;
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


% --- Executes on button press in overlay.
function overlay_Callback(hObject, eventdata, handles)
% hObject    handle to overlay (see GCBO)
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


% --- Executes on button press in undo_but.
function undo_but_Callback(hObject, eventdata, handles)
% hObject    handle to undo_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current;
global store;

current = store(:,:,3);
store(:,:,4) = store(:,:,3);
store(:,:,3) = store(:,:,2);
store(:,:,2) = store(:,:,1);

[m,n] = size(current);
store(:,:,1) = zeros(m,n);

if current==zeros(m,n)
    set(handles.text2,'string','Can''t undo any more');
else
imshow(current);
end
