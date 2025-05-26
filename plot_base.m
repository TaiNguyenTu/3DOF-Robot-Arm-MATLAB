function plot_base(handles)
%% Declare:
    x_min = -0.2; % Kích thước hình hộp theo trục X
    x_max = 0.2;
    y_min = -0.15; % Kích thước hình hộp theo trục Y
    y_max = 0.15;
    z_min = -0.5; % Chiều cao hình hộp (giới hạn dưới)
    z_max = 0;    % Chiều cao hình hộp (giới hạn trên)
    
    %% Các đỉnh của hình hộp
    vertices = [
        x_min, y_min, z_min;
        x_max, y_min, z_min;
        x_max, y_max, z_min;
        x_min, y_max, z_min;
        x_min, y_min, z_max;
        x_max, y_min, z_max;
        x_max, y_max, z_max;
        x_min, y_max, z_max;
    ];

    %% Các mặt của hình hộp
    faces = [
        1, 2, 6, 5; % Mặt dưới
        2, 3, 7, 6; % Mặt bên phải
        3, 4, 8, 7; % Mặt trên
        4, 1, 5, 8; % Mặt bên trái
        1, 2, 3, 4; % Đáy
        5, 6, 7, 8; % Nắp
    ];
    
    %% Vẽ hình hộp
    patch(handles.axes1,'Faces', faces, 'Vertices', vertices,'FaceColor', [0.3, 0.3, 0.3], 'EdgeColor', 'none','FaceAlpha', 1);
%% 
h=-0.5;
theta=0:pi/1000:2*pi;
fill3(handles.axes1, 0.8*cos(theta) , 0.8*sin(theta) , h*ones(1,size(theta,2)),[0.5 0.5 0.5],'FaceAlpha',0.5);
set(handles.axes1, 'Color', [0.95, 0.95, 1]);
end
