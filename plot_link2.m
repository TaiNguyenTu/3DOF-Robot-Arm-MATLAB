function plot_link2(handles,roll,pitch,yaw,P1,P2)
%% Declare:
    opacity=get(handles.slider_opacity,'Value');
    direction = P2 - P1; % Vector hướng từ P1 đến P2

    length = norm(direction); % Chiều dài liên kết 
    width=0.2;
    height=0.2;
%% 

    % Ma trận xoay 3D từ roll, pitch, yaw
    Rz = [cos(yaw), -sin(yaw), 0;
          sin(yaw),  cos(yaw), 0;
          0,         0,        1];
    Ry = [cos(pitch),  0, sin(pitch);
          0,           1, 0;
         -sin(pitch),  0, cos(pitch)];
    Rx = [1,  0,       0;
          0, cos(roll), -sin(roll);
          0, sin(roll),  cos(roll)];
    % Ma trận quay R
    R = Rz * Ry * Rx;
 
%% Create a rectangular prism (hình hộp chữ nhật)
    % Kích thước hình hộp: width (ngang), height (cao), length (dọc).
    % 8 điểm ( hàng) và 3 tọa độ (cột)
    vertices = [
                 0, -height/2, -width/2; % Đỉnh 1
                 0, -height/2,  width/2; % Đỉnh 2
                 0,  height/2,  width/2; % Đỉnh 3
                 0,  height/2, -width/2; % Đỉnh 4
               length, -height/2, -width/2; % Đỉnh 5
               length, -height/2,  width/2; % Đỉnh 6
               length,  height/2,  width/2; % Đỉnh 7
               length,  height/2, -width/2; % Đỉnh 8
                                                        ];
  
    % Áp dụng ma trận xoay và dịch chuyển
    vertices = (R * vertices')'; % Xoay các đỉnh
    vertices = vertices + [P1(1);P1(2);P1(3)]'; % Dịch chuyển đến vị trí P1

    %% Define faces of the rectangular prism
    faces = [1, 2, 3, 4; % Mặt đáy
             5, 6, 7, 8; % Mặt trên
             1, 2, 6, 5; % Mặt bên 1
             2, 3, 7, 6; % Mặt bên 2
             3, 4, 8, 7; % Mặt bên 3
             4, 1, 5, 8]; % Mặt bên 4

    % Plot rectangular prism

    patch(handles.axes1,'Faces', faces, 'Vertices', vertices,'FaceColor', [0 0.4471 0.7412], 'EdgeColor', 'none', 'FaceAlpha', opacity);
    %% Add a cylindrical cap to the top of the rectangular prism
    % Kích thước hình trụ
    cylinder_radius = width / 2; % Bán kính hình trụ
    cylinder_height = 0.2;      % Chiều cao hình trụ

    % Tạo hình trụ
    [Xc, Yc, Zc] = cylinder(cylinder_radius, 100); % Tạo hình trụ mịn
    Zc = Zc * cylinder_height;                    % Scale chiều cao

    % Biến đổi tọa độ hình trụ
    top_center =R * [0; 0; -height/2]+ P1;  % Tâm hình trụ (vị trí vòng tròn đỏ)
    cylinder_vertices = [Xc(:), Yc(:), Zc(:)]';  % Chuyển về ma trận 3xN
    cylinder_vertices = R * cylinder_vertices;  % Xoay hình trụ
    cylinder_vertices = cylinder_vertices + top_center; % Dịch chuyển đến vị trí

    % Chuyển về dạng 2D cho `surf`
    Xc = reshape(cylinder_vertices(1, :), size(Xc));
    Yc = reshape(cylinder_vertices(2, :), size(Yc));
    Zc = reshape(cylinder_vertices(3, :), size(Zc));

    % Vẽ hình trụ
    surf(handles.axes1, Xc, Yc, Zc, ...
        'FaceColor', [0 0.4471 0.7412], 'EdgeColor', 'k', 'FaceAlpha', opacity);
  %% Add top and bottom caps
    % Bottom cap
    bottom_circle_x = cylinder_radius * cos(linspace(0, 2 * pi, 100)); % Điểm X
    bottom_circle_y = cylinder_radius * sin(linspace(0, 2 * pi, 100)); % Điểm Y
    bottom_circle_z = -cylinder_height/2 * ones(size(bottom_circle_x));                   

    % Transform bottom cap
    bottom_cap = R * [bottom_circle_x; bottom_circle_y; bottom_circle_z] + P1;

    fill3(handles.axes1, bottom_cap(1, :), bottom_cap(2, :), bottom_cap(3, :),[0 0.4471 0.7412], 'EdgeColor', 'k', 'FaceAlpha', opacity);

    % Top cap
    top_circle_x = bottom_circle_x;   % Điểm X giống với đáy dưới
    top_circle_y = bottom_circle_y;   % Điểm Y giống với đáy dưới
    top_circle_z = cylinder_height/2 * ones(size(bottom_circle_x)); 

    % Transform top cap
    top_cap = R * [top_circle_x; top_circle_y; top_circle_z] + P1;

    fill3(handles.axes1, top_cap(1, :), top_cap(2, :), top_cap(3, :),[0 0.4471 0.7412], 'EdgeColor', 'k', 'FaceAlpha', opacity);
end