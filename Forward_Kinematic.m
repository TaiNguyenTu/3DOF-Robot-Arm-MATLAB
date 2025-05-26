function Forward_Kinematic(handles)
%% Get parameters of DH from GUI
L1    = 0.5;
L2    = 0.4;
L3    = 0.6;
theta1= str2double(get(handles.edit_theta1,'String'))*pi/180;
theta2= str2double(get(handles.edit_theta2,'String'))*pi/180;
theta3= str2double(get(handles.edit_theta3,'String'))*pi/180;
% %% DH_table
% d     =  [L1;     0;      0];
% theta =  [theta1; theta2; theta3];
% a     =  [0;      L2;     L3];
% alpha =  [sym(pi/2);   0;      0];

%% Homogeneous transformation matrix

T0_1=DH_matrix(L1,theta1,0,pi/2);
T1_2=DH_matrix(0,theta2,L2,0);
T2_3=DH_matrix(0,theta3,L3,0);

T0_2=T0_1*T1_2;   
T0_3=T0_1*T1_2*T2_3;

% Position & Orientation for each Link
       P0=[0;0;0];                             
       [P1,O1]=Position_Orientation(T0_1,P0);  % Link 1
       [P2,O2]=Position_Orientation(T0_2,P0);  % Link 2
       [P3,O3]=Position_Orientation(T0_3,P0);  % Link 3

%% Set each Joint of Posion & Orientation
% Position&Orientation of Link 3
    set(handles.edit_link3_x,'String', num2str(P3(1),'%.2f') );
    set(handles.edit_link3_y,'String', num2str(P3(2),'%.2f') );
    set(handles.edit_link3_z,'String', num2str(P3(3),'%.2f') );
    set(handles.edit_link3_phi,'String',num2str(O3(1)*180/pi,'%.2f') );
    set(handles.edit_link3_theta,'String',num2str(O3(2)*180/pi,'%.2f') );
    set(handles.edit_link3_psi,'String',num2str(O3(3)*180/pi,'%.2f') );

%% Coordinate System
cla(handles.axes1, 'reset');  
hold(handles.axes1,'on');
grid(handles.axes1,'on');
xlabel(handles.axes1,'x');
ylabel(handles.axes1,'y');
zlabel(handles.axes1,'z');
xlim(handles.axes1,[-2 2]);
ylim(handles.axes1,[-2 2]);
zlim(handles.axes1,[-0.5 2]);
rotate3d(handles.axes1,'on');
view(handles.axes1,30,30);

if handles.checkbox_coor0.Value
    plot_coor(handles,P0(1),P0(2),P0(3),O1(1),O1(2),O1(3),0);
end
if handles.checkbox_coor1.Value
    plot_coor(handles,P1(1),P1(2),P1(3),O2(1),O2(2),O2(3),1);
end
if handles.checkbox_coor2.Value
    plot_coor(handles,P2(1),P2(2),P2(3),O3(1),O3(2),O3(3),2);
end
if handles.checkbox_coor3.Value
    plot_coor(handles,P3(1),P3(2),P3(3),O3(1),O3(2),O3(3),3);
end

%% Robot's 3D Plot

    plot_base(handles);                           % Plot base

    plot_link1(handles,O1(3),P0,P1);              % Plot Link1

    plot_link2(handles,O2(1),O2(2),O2(3),P1,P2);  % Plot Link2

    plot_link3(handles,O3(1),O3(2),O3(3),P2,P3);  % Plot Link3

pause(1/50000); 

end
