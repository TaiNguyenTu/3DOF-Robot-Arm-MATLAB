function varargout = BTL_robot(varargin)
% BTL_ROBOT MATLAB code for BTL_robot.fig
%      BTL_ROBOT, by itself, creates a new BTL_ROBOT or raises the existing
%      singleton*.
%
%      H = BTL_ROBOT returns the handle to a new BTL_ROBOT or the handle to
%      the existing singleton*.
%
%      BTL_ROBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BTL_ROBOT.M with the given input arguments.
%
%      BTL_ROBOT('Property','Value',...) creates a new BTL_ROBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BTL_robot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BTL_robot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BTL_robot

% Last Modified by GUIDE v2.5 26-May-2025 23:55:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BTL_robot_OpeningFcn, ...
                   'gui_OutputFcn',  @BTL_robot_OutputFcn, ...
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


% --- Executes just before BTL_robot is made visible.
function BTL_robot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BTL_robot (see VARARGIN)
set(handles.edit_link3_x,'String',0);
set(handles.edit_link3_y,'String',0);
set(handles.edit_link3_z,'String',0);
set(handles.edit_link3_phi,'String',0);
set(handles.edit_link3_theta,'String',0);
set(handles.edit_link3_psi,'String',0);
Forward_Kinematic(handles);
%% 
xlabel(handles.axes_q1,'Time (s)');
        xlabel(handles.axes_q2,'Time (s)');
        xlabel(handles.axes_q3,'Time (s)');

        ylabel(handles.axes_q1,'q_1 (rad)');
        ylabel(handles.axes_q2,'q_2 (rad)');
        ylabel(handles.axes_q3,'q_3 (rad)');

        title(handles.axes_q1 ,'Theta_1');
        title(handles.axes_q2 ,'Theta_2');
        title(handles.axes_q3 ,'Theta_3');

        grid(handles.axes_q1, 'on');
        grid(handles.axes_q2, 'on');
        grid(handles.axes_q3, 'on');
%%
xlabel(handles.axes_a1,'Time (s)');
        xlabel(handles.axes_a2,'Time (s)');
        xlabel(handles.axes_a3,'Time (s)');

        ylabel(handles.axes_a1,'a_1 (rad/s^2)');
        ylabel(handles.axes_a2,'a_2 (rad/s^2)');
        ylabel(handles.axes_a3,'a_3 (rad/s^2)');

        title(handles.axes_a1 ,'Acceleration of theta_1');
        title(handles.axes_a2 ,'Acceleration of theta_2');
        title(handles.axes_a3 ,'Acceleration of theta_3');

        grid(handles.axes_a1, 'on');
        grid(handles.axes_a2, 'on');
        grid(handles.axes_a3, 'on');
%% 
 xlabel(handles.theta1_dot,'Time (s)');
        xlabel(handles.theta2_dot,'Time (s)');
        xlabel(handles.theta3_dot,'Time (s)');

        ylabel(handles.theta1_dot,'v_1 (rad/s)');
        ylabel(handles.theta2_dot,'v_2 (rad/s)');
        ylabel(handles.theta3_dot,'v_3 (rad/s)');

        title(handles.theta1_dot ,'Velocity of theta_1');
        title(handles.theta2_dot ,'Velocity of theta_2');
        title(handles.theta3_dot ,'Velocity of theta_3');

        grid(handles.theta1_dot, 'on');
        grid(handles.theta2_dot, 'on');
        grid(handles.theta3_dot, 'on');
%%
 xlabel(handles.axes6,'Time (s)');
        xlabel(handles.axes7,'Time (s)');
       
        ylabel(handles.axes6,'Velocity (m/s)');
        ylabel(handles.axes7,'Velocity (rad/s)');
        
        title(handles.axes6 ,'Velocity P of end-effector');
        title(handles.axes7 ,'Velocity O of end-effector');
        
        grid(handles.axes6, 'on');
        grid(handles.axes7, 'on');


% Choose default command line output for BTL_robot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BTL_robot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BTL_robot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%%  Setup
    set(handles.slider_theta1, 'Max', 180);
    set(handles.slider_theta1, 'Min', -180);
    set(handles.slider_theta1, 'SliderStep', [1, 1]/50);
%% Display slider to edit
    value_theta1=get(handles.slider_theta1,'Value');
    set(handles.edit_theta1,'String',num2str(value_theta1, '%.2f'));    
%% FK
    Forward_Kinematic(handles);
    

% --- Executes during object creation, after setting all properties.
function slider_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%%  Setup
    set(handles.slider_theta2, 'Max', 90);
    set(handles.slider_theta2, 'Min', -60);
    set(handles.slider_theta2, 'SliderStep', [1, 1]/50);
%% Display slider to edit
    value_theta2=get(handles.slider_theta2,'Value');
    set(handles.edit_theta2,'String',num2str(value_theta2, '%.2f'));
%% FK

    Forward_Kinematic(handles);

% --- Executes during object creation, after setting all properties.
function slider_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_theta3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%%  Setup
    set(handles.slider_theta3, 'Max', 90);
    set(handles.slider_theta3, 'Min', -90);
    set(handles.slider_theta3, 'SliderStep', [1, 1]/50);
%% Display slider to edit
    value_theta3=get(handles.slider_theta3,'Value');
    set(handles.edit_theta3,'String',num2str(value_theta3, '%.2f'));
%% FK

    Forward_Kinematic(handles);

% --- Executes during object creation, after setting all properties.
function slider_theta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta1 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta1 as a double
   %% 
   value_theta1=str2double(get(handles.edit_theta1,'String'));
   if (value_theta1>=-180)&&(value_theta1<=180)
       set(handles.slider_theta1,'Value',value_theta1);
       Forward_Kinematic(handles);
   else 
       msgbox('Hãy nhập lại góc theta1 !');
   end
  


% --- Executes during object creation, after setting all properties.
function edit_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta2 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta2 as a double 
%% 
    value_theta2=str2double(get(handles.edit_theta2,'String'));
    if (value_theta2>=-60)&&(value_theta2<=90)
        set(handles.slider_theta2,'Value',value_theta2);
        Forward_Kinematic(handles);
    else 
        msgbox('Hãy nhập lại theta2 !');
    end
   
 




% --- Executes during object creation, after setting all properties.
function edit_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta3 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta3 as a double
%% 
    value_theta3=str2double(get(handles.edit_theta3,'String'));
    if (value_theta3>=-90)&&(value_theta3<=90)
        set(handles.slider_theta3,'Value',value_theta3);
        Forward_Kinematic(handles);
    else 
        msgbox('Hãy nhập lại theta3 !');
    end


% --- Executes during object creation, after setting all properties.
function edit_theta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_set.
function button_set_Callback(hObject, eventdata, handles)
% hObject    handle to button_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% FK
theta1_end= str2double(get(handles.edit_theta1,'String'))*pi/180;
theta2_end= str2double(get(handles.edit_theta2,'String'))*pi/180;
theta3_end= str2double(get(handles.edit_theta3,'String'))*pi/180;
% Đưa robot về base trước khi vẽ Forward
set(handles.edit_theta1,'string',num2str(0));
set(handles.edit_theta2,'string',num2str(0));
set(handles.edit_theta3,'string',num2str(0));
set(handles.slider_theta1,'Value',0);
set(handles.slider_theta2,'Value',0);
set(handles.slider_theta3,'Value',0);
Forward_Kinematic(handles);
%% Vẽ
button_forward(handles,theta1_end,theta2_end,theta3_end);



% --- Executes on button press in button_reset.
function button_reset_Callback(hObject, eventdata, handles)
% hObject    handle to button_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% RESET
set(handles.edit_theta1,'string',num2str(0));
set(handles.edit_theta2,'string',num2str(0));
set(handles.edit_theta3,'string',num2str(0));
set(handles.slider_theta1,'Value',0);
set(handles.slider_theta2,'Value',0);
set(handles.slider_theta3,'Value',0);
Forward_Kinematic(handles);
cla(handles.theta1_dot,'reset');
cla(handles.theta2_dot,'reset');
cla(handles.theta3_dot,'reset');
cla(handles.axes_q1,'reset');
cla(handles.axes_q2,'reset');
cla(handles.axes_q3,'reset');
cla(handles.axes_a1,'reset');
cla(handles.axes_a2,'reset');
cla(handles.axes_a3,'reset');
cla(handles.axes6,'reset');
cla(handles.axes7,'reset');
%% 
xlabel(handles.axes_q1,'Time (s)');
        xlabel(handles.axes_q2,'Time (s)');
        xlabel(handles.axes_q3,'Time (s)');

        ylabel(handles.axes_q1,'q_1 (rad)');
        ylabel(handles.axes_q2,'q_2 (rad)');
        ylabel(handles.axes_q3,'q_3 (rad)');

        title(handles.axes_q1 ,'Theta_1');
        title(handles.axes_q2 ,'Theta_2');
        title(handles.axes_q3 ,'Theta_3');

        grid(handles.axes_q1, 'on');
        grid(handles.axes_q2, 'on');
        grid(handles.axes_q3, 'on');
%%
xlabel(handles.axes_a1,'Time (s)');
        xlabel(handles.axes_a2,'Time (s)');
        xlabel(handles.axes_a3,'Time (s)');

        ylabel(handles.axes_a1,'a_1 (rad/s^2)');
        ylabel(handles.axes_a2,'a_2 (rad/s^2)');
        ylabel(handles.axes_a3,'a_3 (rad/s^2)');

        title(handles.axes_a1 ,'Acceleration of theta_1');
        title(handles.axes_a2 ,'Acceleration of theta_2');
        title(handles.axes_a3 ,'Acceleration of theta_3');

        grid(handles.axes_a1, 'on');
        grid(handles.axes_a2, 'on');
        grid(handles.axes_a3, 'on');
%% 
 xlabel(handles.theta1_dot,'Time (s)');
        xlabel(handles.theta2_dot,'Time (s)');
        xlabel(handles.theta3_dot,'Time (s)');

        ylabel(handles.theta1_dot,'v_1 (rad/s)');
        ylabel(handles.theta2_dot,'v_2 (rad/s)');
        ylabel(handles.theta3_dot,'v_3 (rad/s)');

        title(handles.theta1_dot ,'Velocity of theta_1');
        title(handles.theta2_dot ,'Velocity of theta_2');
        title(handles.theta3_dot ,'Velocity of theta_3');

        grid(handles.theta1_dot, 'on');
        grid(handles.theta2_dot, 'on');
        grid(handles.theta3_dot, 'on');
%%
 xlabel(handles.axes6,'Time (s)');
        xlabel(handles.axes7,'Time (s)');
       
        ylabel(handles.axes6,'Velocity (m/s)');
        ylabel(handles.axes7,'Velocity (rad/s)');
        
        title(handles.axes6 ,'Velocity P of end-effector');
        title(handles.axes7 ,'Velocity O of end-effector');
        
        grid(handles.axes6, 'on');
        grid(handles.axes7, 'on');
 







function edit_L1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L1 as text
%        str2double(get(hObject,'String')) returns contents of edit_L1 as a double
Forward_Kinematic(handles);

% --- Executes during object creation, after setting all properties.
function edit_L1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L2 as text
%        str2double(get(hObject,'String')) returns contents of edit_L2 as a double
Forward_Kinematic(handles);

% --- Executes during object creation, after setting all properties.
function edit_L2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L3 as text
%        str2double(get(hObject,'String')) returns contents of edit_L3 as a double
Forward_Kinematic(handles);

% --- Executes during object creation, after setting all properties.
function edit_L3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_opacity_Callback(hObject, eventdata, handles)
% hObject    handle to slider_opacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%% FK
    Forward_Kinematic(handles);


% --- Executes during object creation, after setting all properties.
function slider_opacity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_opacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox_coor0.
function checkbox_coor0_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coor0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_coor0
%% FK
    Forward_Kinematic(handles);

% --- Executes on button press in checkbox_coor1.
function checkbox_coor1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_coor1
%% FK
    Forward_Kinematic(handles);

% --- Executes on button press in checkbox_coor2.
function checkbox_coor2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_coor2
%% FK
    Forward_Kinematic(handles);

% --- Executes on button press in checkbox_coor3.
function checkbox_coor3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_coor3
%% FK
    Forward_Kinematic(handles);

% --- Executes on button press in checkbox_workspace.
function checkbox_workspace_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_workspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_workspace
%% Workspace
     % Kiểm tra trạng thái checkbox
    if handles.checkbox_workspace.Value
        camPos = handles.axes1.CameraPosition;
        Workspace(handles); % Gọi hàm vẽ workspace
        handles.axes1.CameraPosition = camPos;
    else
        % Xóa workspace khi checkbox bị tắt
        hWorkspace = findobj(handles.axes1, 'Tag', 'WorkspaceShape');
        if ~isempty(hWorkspace)
            delete(hWorkspace); % Xóa workspace
        end
    end







function edit_link1_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link1_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link1_x as text
%        str2double(get(hObject,'String')) returns contents of edit_link1_x as a double


% --- Executes during object creation, after setting all properties.
function edit_link1_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link1_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link2_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link2_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link2_x as text
%        str2double(get(hObject,'String')) returns contents of edit_link2_x as a double


% --- Executes during object creation, after setting all properties.
function edit_link2_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link2_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link3_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link3_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link3_x as text
%        str2double(get(hObject,'String')) returns contents of edit_link3_x as a double


% --- Executes during object creation, after setting all properties.
function edit_link3_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link3_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link1_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link1_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link1_y as text
%        str2double(get(hObject,'String')) returns contents of edit_link1_y as a double


% --- Executes during object creation, after setting all properties.
function edit_link1_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link1_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link2_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link2_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link2_y as text
%        str2double(get(hObject,'String')) returns contents of edit_link2_y as a double


% --- Executes during object creation, after setting all properties.
function edit_link2_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link2_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link3_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link3_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link3_y as text
%        str2double(get(hObject,'String')) returns contents of edit_link3_y as a double


% --- Executes during object creation, after setting all properties.
function edit_link3_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link3_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link1_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link1_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link1_z as text
%        str2double(get(hObject,'String')) returns contents of edit_link1_z as a double


% --- Executes during object creation, after setting all properties.
function edit_link1_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link1_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link2_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link2_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link2_z as text
%        str2double(get(hObject,'String')) returns contents of edit_link2_z as a double


% --- Executes during object creation, after setting all properties.
function edit_link2_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link2_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link3_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link3_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link3_z as text
%        str2double(get(hObject,'String')) returns contents of edit_link3_z as a double


% --- Executes during object creation, after setting all properties.
function edit_link3_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link3_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link3_psi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link3_psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link3_psi as text
%        str2double(get(hObject,'String')) returns contents of edit_link3_psi as a double


% --- Executes during object creation, after setting all properties.
function edit_link3_psi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link3_psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link2_psi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link2_psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link2_psi as text
%        str2double(get(hObject,'String')) returns contents of edit_link2_psi as a double


% --- Executes during object creation, after setting all properties.
function edit_link2_psi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link2_psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link1_psi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link1_psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link1_psi as text
%        str2double(get(hObject,'String')) returns contents of edit_link1_psi as a double


% --- Executes during object creation, after setting all properties.
function edit_link1_psi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link1_psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link3_theta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link3_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link3_theta as text
%        str2double(get(hObject,'String')) returns contents of edit_link3_theta as a double


% --- Executes during object creation, after setting all properties.
function edit_link3_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link3_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link2_theta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link2_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link2_theta as text
%        str2double(get(hObject,'String')) returns contents of edit_link2_theta as a double


% --- Executes during object creation, after setting all properties.
function edit_link2_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link2_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link1_theta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link1_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link1_theta as text
%        str2double(get(hObject,'String')) returns contents of edit_link1_theta as a double


% --- Executes during object creation, after setting all properties.
function edit_link1_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link1_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link3_phi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link3_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link3_phi as text
%        str2double(get(hObject,'String')) returns contents of edit_link3_phi as a double


% --- Executes during object creation, after setting all properties.
function edit_link3_phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link3_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link2_phi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link2_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link2_phi as text
%        str2double(get(hObject,'String')) returns contents of edit_link2_phi as a double


% --- Executes during object creation, after setting all properties.
function edit_link2_phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link2_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_link1_phi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_link1_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_link1_phi as text
%        str2double(get(hObject,'String')) returns contents of edit_link1_phi as a double


% --- Executes during object creation, after setting all properties.
function edit_link1_phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_link1_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta1 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta1 as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta2 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta2 as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta3 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta3 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta1 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta1 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inverse_x_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inverse_x as text
%        str2double(get(hObject,'String')) returns contents of inverse_x as a double


% --- Executes during object creation, after setting all properties.
function inverse_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inverse_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inverse_y_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inverse_y as text
%        str2double(get(hObject,'String')) returns contents of inverse_y as a double


% --- Executes during object creation, after setting all properties.
function inverse_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inverse_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inverse_z_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inverse_z as text
%        str2double(get(hObject,'String')) returns contents of inverse_z as a double


% --- Executes during object creation, after setting all properties.
function inverse_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inverse_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inverse_psi_Callback(hObject, eventdata, handles)
% hObject    handle to inverse_psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inverse_psi as text
%        str2double(get(hObject,'String')) returns contents of inverse_psi as a double


% --- Executes during object creation, after setting all properties.
function inverse_psi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inverse_psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_trajectory.
function checkbox_trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_trajectory


% --- Executes on button press in button_inverse.
function button_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to button_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_Inverse(handles);




function theta3n_Callback(hObject, eventdata, handles)
% hObject    handle to theta3n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta3n as text
%        str2double(get(hObject,'String')) returns contents of theta3n as a double


% --- Executes during object creation, after setting all properties.
function theta3n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta3n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta2n_Callback(hObject, eventdata, handles)
% hObject    handle to theta2n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta2n as text
%        str2double(get(hObject,'String')) returns contents of theta2n as a double


% --- Executes during object creation, after setting all properties.
function theta2n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta1n_Callback(hObject, eventdata, handles)
% hObject    handle to theta1n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta1n as text
%        str2double(get(hObject,'String')) returns contents of theta1n as a double


% --- Executes during object creation, after setting all properties.
function theta1n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit61_Callback(hObject, eventdata, handles)
% hObject    handle to edit61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit61 as text
%        str2double(get(hObject,'String')) returns contents of edit61 as a double


% --- Executes during object creation, after setting all properties.
function edit61_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit60_Callback(hObject, eventdata, handles)
% hObject    handle to edit60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit60 as text
%        str2double(get(hObject,'String')) returns contents of edit60 as a double


% --- Executes during object creation, after setting all properties.
function edit60_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit59_Callback(hObject, eventdata, handles)
% hObject    handle to edit59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit59 as text
%        str2double(get(hObject,'String')) returns contents of edit59 as a double


% --- Executes during object creation, after setting all properties.
function edit59_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_trajectory_plan.
function checkbox_trajectory_plan_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_trajectory_plan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_trajectory_plan


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_vmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vmax as text
%        str2double(get(hObject,'String')) returns contents of edit_vmax as a double


% --- Executes during object creation, after setting all properties.
function edit_vmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amax as text
%        str2double(get(hObject,'String')) returns contents of edit_amax as a double


% --- Executes during object creation, after setting all properties.
function edit_amax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit72_Callback(hObject, eventdata, handles)
% hObject    handle to edit72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit72 as text
%        str2double(get(hObject,'String')) returns contents of edit72 as a double


% --- Executes during object creation, after setting all properties.
function edit72_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit73_Callback(hObject, eventdata, handles)
% hObject    handle to edit73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit73 as text
%        str2double(get(hObject,'String')) returns contents of edit73 as a double


% --- Executes during object creation, after setting all properties.
function edit73_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit74_Callback(hObject, eventdata, handles)
% hObject    handle to edit74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit74 as text
%        str2double(get(hObject,'String')) returns contents of edit74 as a double


% --- Executes during object creation, after setting all properties.
function edit74_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in kalman_filter.
function kalman_filter_Callback(hObject, eventdata, handles)
% hObject    handle to kalman_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of kalman_filter



function edit75_Callback(hObject, eventdata, handles)
% hObject    handle to edit75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit75 as text
%        str2double(get(hObject,'String')) returns contents of edit75 as a double


% --- Executes during object creation, after setting all properties.
function edit75_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit76_Callback(hObject, eventdata, handles)
% hObject    handle to edit76 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit76 as text
%        str2double(get(hObject,'String')) returns contents of edit76 as a double


% --- Executes during object creation, after setting all properties.
function edit76_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit76 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit77_Callback(hObject, eventdata, handles)
% hObject    handle to edit77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit77 as text
%        str2double(get(hObject,'String')) returns contents of edit77 as a double


% --- Executes during object creation, after setting all properties.
function edit77_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit79_Callback(hObject, eventdata, handles)
% hObject    handle to edit79 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit79 as text
%        str2double(get(hObject,'String')) returns contents of edit79 as a double


% --- Executes during object creation, after setting all properties.
function edit79_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit79 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit80_Callback(hObject, eventdata, handles)
% hObject    handle to edit80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit80 as text
%        str2double(get(hObject,'String')) returns contents of edit80 as a double


% --- Executes during object creation, after setting all properties.
function edit80_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
