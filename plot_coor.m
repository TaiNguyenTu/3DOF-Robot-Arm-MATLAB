function plot_coor(handles,x,y,z,roll,pitch,yaw,i)
% x,y,z: tọa độ của điểm gốc (nơi hệ trục tọa độ i bắt đầu).
% i: Chỉ số của hệ trục, được hiển thị trên đồ thị.
% yaw: Góc quay quanh trục z của hệ trục tọa độ.
%% 
Rx = [1,    0     ,      0;
      0, cos(roll), -sin(roll);
      0, sin(roll), cos(roll)];

Ry = [cos(pitch), 0, sin(pitch);
      0         , 1, 0         ;
     -sin(pitch), 0, cos(pitch)];

Rz=[ cos(yaw), -sin(yaw), 0;
     sin(yaw), cos(yaw),  0;
       0,          0      1];
    if i==0
        R=Rz;
    else
        R=Rz * Ry * Rx;
    end
hold on
axis_x=R(:,1)*0.25;
axis_y=R(:,2)*0.25;
axis_z=R(:,3)*0.25;

%% 
% x
    line(handles.axes1,[x x+axis_x(1)],[y y+axis_x(2)],[z z+axis_x(3)],'linewidth',1.5,'color',[0 1 0])
    text(handles.axes1,x+axis_x(1),y+axis_x(2),z+axis_x(3),(['x',num2str(i)]))
% y
    line(handles.axes1,[x x+axis_y(1)],[y y+axis_y(2)],[z z+axis_y(3)],'linewidth',1.5,'color',[0 0 1])
    text(handles.axes1,x+axis_y(1),y+axis_y(2),z+axis_y(3),(['y',num2str(i)]))
% z
    line(handles.axes1,[x x+axis_z(1)],[y y+axis_z(2)],[z z+axis_z(3)],'linewidth',1.5,'color',[1 0 0])
    text(handles.axes1,x+axis_z(1),y+axis_z(2),z+axis_z(3),(['z',num2str(i)]))
end
