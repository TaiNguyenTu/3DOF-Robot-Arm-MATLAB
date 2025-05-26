function button_forward(handles,theta1_end,theta2_end,theta3_end)
%% Get parameters of DH from GUI
L1    = 0.5;
L2    = 0.4;
L3    = 0.6;

%% Homogeneous transformation matrix
trajectory = [];  
step=50;
theta1_a=linspace(0,theta1_end,step); %from theta1 2 theta_set divide for 1000 points
theta2_a=linspace(0,theta2_end,step);
theta3_a=linspace(0,theta3_end,step);
for i=1:step
theta1= theta1_a(i);
theta2= theta2_a(i);
theta3= theta3_a(i);

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
% Position&Orientation of end-effector
    set(handles.edit_link3_x,'String', num2str(P3(1),'%.2f'));
    set(handles.edit_link3_y,'String', num2str(P3(2),'%.2f'));
    set(handles.edit_link3_z,'String', num2str(P3(3),'%.2f'));
    set(handles.edit_link3_phi,'String',num2str(O3(1)*180/pi,'%.2f'));
    set(handles.edit_link3_theta,'String',num2str(O3(2)*180/pi,'%.2f'));
    set(handles.edit_link3_psi,'String',num2str(O3(3)*180/pi,'%.2f'));
% Update theta
    set(handles.edit_theta1,'string',num2str(theta1*180/pi, '%.2f'));
    set(handles.edit_theta2,'string',num2str(theta2*180/pi, '%.2f'));
    set(handles.edit_theta3,'string',num2str(theta3*180/pi, '%.2f'));

%% Coordinate System
cla(handles.axes1,'reset');
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
%% Animation
if handles.checkbox_trajectory.Value
    trajectory = [trajectory; P3'];  % Thêm tọa độ P3 vào mảng (lưu theo cột)
    plot3(handles.axes1, trajectory(:, 1), trajectory(:, 2), trajectory(:, 3), 'k', 'LineWidth', 2); % Vẽ lại toàn bộ đường đi đã lưu
end
%% Robot's 3D Plot

    plot_base(handles);                          % Plot base

    plot_link1(handles,O1(3),P0,P1);             % Plot Link1

    plot_link2(handles,O2(1),O2(2),O2(3),P1,P2); % Plot Link2

    plot_link3(handles,O3(1),O3(2),O3(3),P2,P3); % Plot Link3




% Cập nhật đồ họa và tạo hiệu ứng chuyển động

pause(1/50000); % Dừng 10ms để tạo hiệu ứng

end
end