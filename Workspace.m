function Workspace(handles)
L1    = 0.5;
L2    = 0.4;
L3    = 0.6;

    % Số lượng điểm để tạo workspace
    num_points = 30;  

    % Giới hạn các góc (theo độ)
    theta1_range = deg2rad(linspace(-180, 180, num_points)); % θ1 từ -180° đến 180°
    theta2_range = deg2rad(linspace(-60, 90, num_points));   % θ2 từ -30° đến 90°
    theta3_range = deg2rad(linspace(-90, 90, num_points));   % θ3 từ -90° đến 90°

    % Khởi tạo workspace với kích thước phù hợp
    workspace = zeros(num_points^3, 3);  
    index = 1;  % Chỉ số để điền giá trị vào workspace

    % Duyệt qua tất cả các góc
    for i = 1:num_points
        theta1 = theta1_range(i);
        for j = 1:num_points
            theta2 = theta2_range(j);
            for k = 1:num_points
                theta3 = theta3_range(k);

                % Tính toán các ma trận biến đổi DH
               T0_1=DH_matrix(L1,theta1,0,pi/2);
               T1_2=DH_matrix(0,theta2,L2,0);
               T2_3=DH_matrix(0,theta3,L3,0);

                  % Ma trận tổng hợp từ gốc đến End Effector
                T0_3=T0_1*T1_2*T2_3;

                % Lấy tọa độ của End Effector
                P3 = T0_3(1:3, 4);
             

                 % Lưu điểm vào workspace
                workspace(index, :) = P3';
                index = index + 1;
         
            end
        end
    end

    % Tạo hình alphaShape từ dữ liệu workspace
    shp = alphaShape(workspace(:, 1), workspace(:, 2), workspace(:, 3), 5);
    % Đặt trục vẽ vào handles.axis1
    axes(handles.axes1);
    % Vẽ workspace mới và gắn tag
    h_Plot = plot(shp, 'FaceColor', [0.8, 0, 0], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    set(h_Plot, 'Tag', 'WorkspaceShape'); % Gắn tag để quản lý


    xlim(handles.axes1,[-2 2]);
    ylim(handles.axes1,[-2 2]);
    zlim(handles.axes1,[-0.5 2]);
    rotate3d(handles.axes1,'on');
    view(handles.axes1,30,30);
  
end



