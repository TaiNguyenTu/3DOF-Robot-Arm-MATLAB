function animation(handles,P3)
    % 
    % % Sử dụng persistent để lưu mảng trajectory
    % persistent trajectory;
    % % Khởi tạo mảng trajectory nếu lần đầu tiên gọi hàm hoặc Nếu nút reset được nhấn
    % if isempty(trajectory) || get(handles.button_reset, 'Value') == 1 % 
    %    trajectory = [];  
    % end
   trajectory = [];  
    % Lưu tọa độ P3 vào mảng trajectory
    trajectory = [trajectory; P3'];  % Thêm tọa độ P3 vào mảng (lưu theo cột)

        % Vẽ lại toàn bộ đường đi đã lưu
        plot3(handles.axes1, trajectory(:, 1), trajectory(:, 2), trajectory(:, 3), 'k', 'LineWidth', 2);

    end
