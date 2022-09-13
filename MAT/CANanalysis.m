function varargout = CANanalysis(varargin)
% CANANALYSIS MATLAB code for CANanalysis.fig
%      CANANALYSIS, by itself, creates a new CANANALYSIS or raises the existing
%      singleton*.
%
%      H = CANANALYSIS returns the handle to a new CANANALYSIS or the handle to
%      the existing singleton*.
%
%      CANANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CANANALYSIS.M with the given input arguments.
%
%      CANANALYSIS('Property','Value',...) creates a new CANANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CANanalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CANanalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CANanalysis

% Last Modified by GUIDE v2.5 09-Feb-2019 15:56:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CANanalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @CANanalysis_OutputFcn, ...
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


% --- Executes just before CANanalysis is made visible.
function CANanalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CANanalysis (see VARARGIN)
global objR objS MatSD txID MatS

objR = serial('com11','BaudRate',115200);
objS = serial('com14','BaudRate',115200);

Mat = [ '0x0E' , '0x00' ; '0xFF' , '0x22' ; '0xE9' , '0xFA'; '0xDD' , '0x51' ];
MatCell = mat2cell(Mat,[1,1,1,1],[4,4]);
MatS = cell2mat([MatCell(1,1),MatCell(1,2),MatCell(2,1),MatCell(2,2),MatCell(3,1),MatCell(3,2),MatCell(4,1),MatCell(4,2)]);
txID = '1881ABBA';
MatSD = [txID,MatS];
set(handles.uitableR,'Data',MatCell);
set(handles.edittxID,'String',txID);

% Choose default command line output for CANanalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CANanalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CANanalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Monitor.
function Monitor_Callback(hObject, eventdata, handles)
% hObject    handle to Monitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Monitor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Monitor


% --- Executes during object creation, after setting all properties.
function Monitor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Monitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonSEND.
function pushbuttonSEND_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSEND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objS MatSD
MatSD
fprintf(objS,'%s',MatSD);

% --- Executes on button press in ConnectS.
function ConnectS_Callback(hObject, eventdata, handles)
% hObject    handle to ConnectS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objS;
if(get(hObject,'Value')==1)
set(handles.ConnectS,'String','Disconnect');
fopen(objS);
else
    set(handles.ConnectS,'String','Connect');
    fclose(objS);
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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in editCOMS.
function editCOMS_Callback(hObject, eventdata, handles)
% hObject    handle to editCOMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objR
a = get(hObject,'value');
objR.Port = ['com' num2str(a)]
% Hints: contents = cellstr(get(hObject,'String')) returns editCOMS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editCOMS


% --- Executes during object creation, after setting all properties.
function editCOMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCOMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ConnectR.
function ConnectR_Callback(hObject, eventdata, handles)
% hObject    handle to ConnectR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objR;
if(get(hObject,'Value')==1)
set(handles.ConnectR,'String','Disconnect');
fopen(objR);
i = 1;
l = 1;
data = fscanf(objR,'%s');
pause(0.0003);
if(length(data)==52)
    data = fscanf(objR,'%s');
end
timeS = data;
t=str2double(timeS);
x=t;
axes(handles.axes1)
while(get(hObject,'Value')==1)
    data = fscanf(objR,'%s');
    if(length(data)==47)
    datas(i,:) = data;
    datas = flip(datas);
    set(handles.Monitor,'String',datas);
    pause(0.03);
    i = i + 1;
    if(length(datas)>=1000)
        clear datas
        i = 1;
    end
    else if(l<=23)
        timeS = data;
        t=str2double(timeS);
        x=[x,t];
        plot(x,'--gs','LineStyle','-.',...
        'LineWidth',2,...
        'MarkerSize',4,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0.5,0.5,0.5])
        title('Time');
        ylim([100 400])
        xlim([0 25])
        xlabel('Msg num');
        ylabel('Time <uS>');
        grid on
        hold on
        hold on
        l = l + 1;
        if(l>=25)
            hold off
            clear x;
            x=t;
            %l=1;
        end
        end
    end
    clear data
end
    hold off
    set(handles.ConnectR,'String','Connect');
    fclose(objR);
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


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in editCOMR.
function editCOMR_Callback(hObject, eventdata, handles)
% hObject    handle to editCOMR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objS
a = get(hObject,'value');
objS.Port = ['com' num2str(a)]
% Hints: contents = cellstr(get(hObject,'String')) returns editCOMR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editCOMR


% --- Executes during object creation, after setting all properties.
function editCOMR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCOMR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edittxID_Callback(hObject, eventdata, handles)
% hObject    handle to edittxID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global txID MatS MatSD
txID = get(hObject,'String');
MatSD = [txID,MatS]

% Hints: get(hObject,'String') returns contents of edittxID as text
%        str2double(get(hObject,'String')) returns contents of edittxID as a double


% --- Executes during object creation, after setting all properties.
function edittxID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edittxID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on uitableR and none of its controls.
function uitableR_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitableR (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in uitableR.
function uitableR_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitableR (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global txID MatSD MatS
MatCell=get(hObject,'Data');
MatS = cell2mat([MatCell(1,1),MatCell(1,2),MatCell(2,1),MatCell(2,2),MatCell(3,1),MatCell(3,2),MatCell(4,1),MatCell(4,2)]);
%txID = '1881ABBA';
MatSD = [txID,MatS]
