function handles = plot_end_effector_velocity(handles,dt,i,step,v_e)


        % Gán nhãn và tiêu đề cho các đồ thị
        xlabel(handles.axes6,'Time (s)');
        xlabel(handles.axes7,'Time (s)');
       
        ylabel(handles.axes6,'Velocity (m/s)');
        ylabel(handles.axes7,'Velocity (rad/s)');
        
        title(handles.axes6 ,'Velocity P of end-effector');
        title(handles.axes7 ,'Velocity O of end-effector');
        
        grid(handles.axes6, 'on');
        grid(handles.axes7, 'on');
        % Thêm chú thích (legend)
       legend(handles.axes6, {'x', 'y', 'z'}, 'FontSize', 6, 'Location', 'best');
       legend(handles.axes7, {'x', 'y', 'z'}, 'FontSize', 6, 'Location', 'best');




if i == 1
        cla(handles.axes6, 'reset');
        cla(handles.axes7, 'reset');
        
    % Khởi tạo mảng lưu vận tốc
    handles.v_e_history = zeros(6, step);
    % Lưu giá trị đầu tiên
    handles.v_e_history(:, i) = v_e;
    if handles.kalman_filter.Value
    % Khởi tạo Kalman Filter
        handles.A = eye(6);        % Ma trận trạng thái (vận tốc không đổi giữa các bước)
        handles.H = eye(6);        % Ma trận đo lường (đo trực tiếp vận tốc)
        handles.Q = 0.01 * eye(6); % Nhiễu hệ thống
        handles.R = 0.01 * eye(6);  % Nhiễu đo lường
        handles.P_k = eye(6);      % Hiệp phương sai ban đầu
        handles.x_k = zeros(6, 1); % Trạng thái ban đầu (vận tốc 0)
    end

    % Khởi tạo các đường biểu diễn
    hold(handles.axes6, 'on');
    hold(handles.axes7, 'on');
    handles.h_vx = plot(handles.axes6, dt*(1:i),  handles.v_e_history(1, 1:i), 'g', 'LineWidth', 2); 
    handles.h_vy = plot(handles.axes6, dt*(1:i),  handles.v_e_history(2, 1:i), 'b', 'LineWidth', 2); 
    handles.h_vz = plot(handles.axes6, dt*(1:i),  handles.v_e_history(3, 1:i), 'r', 'LineWidth', 2); 
    handles.h_wx = plot(handles.axes7, dt*(1:i),  handles.v_e_history(4, 1:i), 'g', 'LineWidth', 2); 
    handles.h_wy = plot(handles.axes7, dt*(1:i),  handles.v_e_history(5, 1:i), 'b', 'LineWidth', 2);
    handles.h_wz = plot(handles.axes7, dt*(1:i),  handles.v_e_history(6, 1:i), 'r', 'LineWidth', 2);
    hold(handles.axes6, 'off');
    hold(handles.axes7, 'off');
else
   % Lọc Kalman khi nếu được tích
   if handles.kalman_filter.Value
    [handles.x_k, handles.P_k] = kalman_filter(v_e, handles.x_k, handles.P_k, handles.A, handles.H, handles.Q, handles.R);
    v_e_filtered = handles.x_k; % Giá trị lọc
    handles.v_e_history(:, i) = v_e_filtered;
   else 
   % Không lọc và Lưu giá trị vận tốc vào lịch sử
    handles.v_e_history(:, i) = v_e;
   end

    % Cập nhật dữ liệu trên đồ thị
    set(handles.h_vx, 'XData', dt*(1:i), 'YData',  handles.v_e_history(1, 1:i));
    set(handles.h_vy, 'XData', dt*(1:i), 'YData',  handles.v_e_history(2, 1:i));
    set(handles.h_vz, 'XData', dt*(1:i), 'YData',  handles.v_e_history(3, 1:i));
    set(handles.h_wx, 'XData', dt*(1:i), 'YData',  handles.v_e_history(4, 1:i));
    set(handles.h_wy, 'XData', dt*(1:i), 'YData',  handles.v_e_history(5, 1:i));
    set(handles.h_wz, 'XData', dt*(1:i), 'YData',  handles.v_e_history(6, 1:i));

end

          
end