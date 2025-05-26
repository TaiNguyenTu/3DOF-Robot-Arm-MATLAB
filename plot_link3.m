function plot_link3(handles,roll,pitch,yaw,P2,P3)

%% Declare:

    opacity=get(handles.slider_opacity,'Value');
    direction = P3 - P2; % Vector hướng từ P1 đến P2
    length = norm(direction); % Chiều dài liên kết 
    width=0.2;
    height=0.2;
%% Rotation matrix (from roll, pitch, yaw)
    Rz = [cos(yaw), -sin(yaw), 0;
          sin(yaw),  cos(yaw), 0;
          0,         0,        1];
    Ry = [cos(pitch),  0, sin(pitch);
          0,           1, 0;
         -sin(pitch),  0, cos(pitch)];
    Rx = [1,  0,       0;
          0, cos(roll), -sin(roll);
          0, sin(roll),  cos(roll)];
    R = Rz * Ry * Rx;
 
%% Create a rectangular prism (hình hộp chữ nhật)
    % Kích thước hình hộp: width (ngang), height (cao), length (dọc).
    % 8 điểm ( hàng) và 3 tọa độ (cột)
    vertices = [
                 0, -height/2, -width/2;    % Đỉnh 1
                 0, -height/2,  width/2;    % Đỉnh 2
                 0,  height/2,  width/2;    % Đỉnh 3
                 0,  height/2, -width/2;    % Đỉnh 4
               length, -height/2, -width/2; % Đỉnh 5
               length, -height/2,  width/2; % Đỉnh 6
               length,  height/2,  width/2; % Đỉnh 7
               length,  height/2, -width/2; % Đỉnh 8
                                                        ];
     % Áp dụng ma trận xoay và dịch chuyển
    vertices = (R * vertices')'; % Xoay các đỉnh
    vertices = vertices + [P2(1);P2(2);P2(3)]'; % Dịch chuyển đến vị trí P1

     % Define faces of the rectangular prism
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
    cap_radius = width / 2; % Bán kính nắp hình trụ
    cap_height = 0.2;      % Chiều cao nắp hình trụ

    % Tạo hình trụ
    [Xc, Yc, Zc] = cylinder(cap_radius, 100); % Tạo hình trụ mịn
    Zc = Zc * cap_height;                     % Scale chiều cao

    % Biến đổi tọa độ hình trụ
    top_center = R*[0; 0; -height/2] + P2;  % Tâm hình trụ (vị trí vòng tròn đỏ)
    cylinder_vertices = [Xc(:), Yc(:), Zc(:)]';  % Chuyển về ma trận 3xN
    cylinder_vertices = R * cylinder_vertices;  % Xoay hình trụ
    cylinder_vertices = cylinder_vertices + top_center; % Dịch chuyển đến vị trí

    % Chuyển về dạng 2D cho `surf`
    Xc = reshape(cylinder_vertices(1, :), size(Xc));
    Yc = reshape(cylinder_vertices(2, :), size(Yc));
    Zc = reshape(cylinder_vertices(3, :), size(Zc));

    % Vẽ hình trụ
    surf(handles.axes1, Xc, Yc, Zc,'FaceColor', [0 0.4471 0.7412], 'EdgeColor', 'k', 'FaceAlpha', opacity);
  %% Add top and bottom caps
    % Cap top and bottom circles
    theta = linspace(0, 2 * pi, 30);
    x_cap = cap_radius * cos(theta);
    y_cap = cap_radius * sin(theta);
    z_cap = -cap_height/2 * ones(size(x_cap));                   

    % Transform bottom cap
    bottom_cap = R * [x_cap; y_cap; z_cap] + P2;

    fill3(handles.axes1, bottom_cap(1, :), bottom_cap(2, :), bottom_cap(3, :),[0 0.4471 0.7412], 'EdgeColor', 'k', 'FaceAlpha', opacity);

    % Top cap
    top_circle_x = x_cap;   % Điểm X giống với đáy dưới
    top_circle_y = y_cap;   % Điểm Y giống với đáy dưới
    top_circle_z = cap_height/2 * ones(size(x_cap)); 

    % Transform top cap
    top_cap = R * [top_circle_x; top_circle_y; top_circle_z] + P2;

    fill3(handles.axes1, top_cap(1, :), top_cap(2, :), top_cap(3, :),[0 0.4471 0.7412], 'EdgeColor', 'k', 'FaceAlpha', opacity);
    %% 


end