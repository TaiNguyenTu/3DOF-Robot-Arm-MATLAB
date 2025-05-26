function button_Inverse(handles)

%% Get parameters of DH from GUI
L1    = 0.5;
L2    = 0.4;
L3    = 0.6;
theta1_pre= str2double(get(handles.edit_theta1,'String'))*pi/180;
theta2_pre= str2double(get(handles.edit_theta2,'String'))*pi/180;
theta3_pre= str2double(get(handles.edit_theta3,'String'))*pi/180;
X = str2double(get(handles.inverse_x,'String'));
Y = str2double(get(handles.inverse_y,'String'));
Z = str2double(get(handles.inverse_z,'String'));

%% Tính toán động học nghịch ra theta1_new,theta2_new,theta3_new

[theta1_new, theta2_new, theta3_new] = Inverse_Kinematic(L1,L2,L3,X,Y,Z);

% Update theta1,2,3 new
    theta1_deg = rad2deg(theta1_new);
    theta2_deg = rad2deg(theta2_new);
    theta3_deg = rad2deg(theta3_new);
    set(handles.theta1n,'String',num2str(theta1_deg,'%.2f') );
    set(handles.theta2n,'String',num2str(theta2_deg,'%.2f') );
    set(handles.theta3n,'String',num2str(theta3_deg,'%.2f') );

%% Trajectory planning
trajectory = [];
theta1_end=theta1_new;
theta2_end=theta2_new;
theta3_end=theta3_new;
v_max=str2double(get(handles.edit_vmax,'String'));
a_max=str2double(get(handles.edit_amax,'String'));
dt = 0.05;  % thời gian giữa các bước
   
if handles.checkbox_trajectory_plan.Value
    % Quy hoạch vận tốc
    [q1, v1, a1, t1] = calculate_Trajectory(theta1_pre, theta1_end, dt, v_max, a_max);
    [q2, v2, a2, t2] = calculate_Trajectory(theta2_pre, theta2_end, dt, v_max, a_max);
    [q3, v3, a3, t3] = calculate_Trajectory(theta3_pre, theta3_end, dt, v_max, a_max);

      % Đồng nhất mảng q1,q2,q3,v1,v2,v3
     step = max([length(t1), length(t2), length(t3)]);
     if length(t1) < step
        q1 = [q1, repmat(q1(end), 1, step - length(q1))];
        v1 = [v1, repmat(v1(end), 1, step - length(v1))];
        a1 = [a1, repmat(a1(end), 1, step - length(a1))];
     end
     if length(t2) < step
        q2 = [q2, repmat(q2(end), 1, step - length(q2))];
        v2 = [v2, repmat(v2(end), 1, step - length(v2))];
        a2 = [a2, repmat(a2(end), 1, step - length(a2))];
     end
     if length(t3) < step
        q3 = [q3, repmat(q3(end), 1, step - length(q3))];
        v3 = [v3, repmat(v3(end), 1, step - length(v3))];
        a3 = [a3, repmat(a3(end), 1, step - length(a3))];
     end

else
    % Không quy hoạch, sử dụng tuyến tính
    step = 50;
    q1 = linspace(theta1_pre, theta1_end, step);
    q2 = linspace(theta2_pre, theta2_end, step);
    q3 = linspace(theta3_pre, theta3_end, step);
end

%% Animation
for i = 1:step
    theta1 = q1(i);
    theta2 = q2(i);
    theta3 = q3(i);

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

%% Show_each_link's_Position_&_Orentation
% Position&Orientation of Link 3
    set(handles.edit_link3_x,'String', num2str(P3(1),'%.2f') );
    set(handles.edit_link3_y,'String', num2str(P3(2),'%.2f') );
    set(handles.edit_link3_z,'String', num2str(P3(3),'%.2f') );
    set(handles.edit_link3_phi,'String',num2str(rad2deg(O3(1)),'%.2f') );
    set(handles.edit_link3_theta,'String',num2str(rad2deg(O3(2)),'%.2f') );
    set(handles.edit_link3_psi,'String',num2str(rad2deg(O3(3)),'%.2f') );

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
%% Animation_for_Inverse_Kinematic
if handles.checkbox_trajectory.Value
      trajectory = [trajectory; P3'];  % Thêm tọa độ P3 vào mảng (lưu theo cột)
      plot3(handles.axes1, trajectory(:, 1), trajectory(:, 2), trajectory(:, 3), 'k', 'LineWidth', 2);  % Vẽ lại toàn bộ đường đi đã lưu
end
plot3(handles.axes1,X,Y,Z,'b*');
%% Robot's 3D Plot

    plot_base(handles);                           % Plot base

    plot_link1(handles,O1(3),P0,P1);              % Plot Link1

    plot_link2(handles,O2(1),O2(2),O2(3),P1,P2);  % Plot Link2

    plot_link3(handles,O3(1),O3(2),O3(3),P2,P3);  % Plot Link3

%% Vẽ đồ thị q,v,a 
 % Chỉ vẽ khi được tích checkbox
if handles.checkbox_trajectory_plan.Value
    handles = plot_joint(handles,dt,i,q1,q2,q3);
    handles = plot_joint_velocity(handles,dt,i,v1,v2,v3);
    handles = plot_joint_acceleration(handles,dt,i,a1,a2,a3);
end
%% Vẽ đồ thị vận tốc end_effector 

if handles.checkbox_trajectory_plan.Value
    % Tính toán vận tốc end-effector
    q_dot=[v1(i); v2(i); v3(i)];
    J=Jacobian_matrix(theta1, theta2, theta3); 
    v_e= J * q_dot;
    % Vẽ đồ thị
    handles = plot_end_effector_velocity(handles,dt,i,step, v_e);
end
pause(1/50000);
end
end