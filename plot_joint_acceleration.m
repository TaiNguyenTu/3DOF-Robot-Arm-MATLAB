function handles = plot_joint_acceleration(handles,dt,i,a1,a2,a3)

        xlabel(handles.axes_a1,'Time (s)');
        xlabel(handles.axes_a2,'Time (s)');
        xlabel(handles.axes_a3,'Time (s)');

        ylabel(handles.axes_a1,'a_1 (rad/s^2)');
        ylabel(handles.axes_a2,'a_2 (rad/s^2)');
        ylabel(handles.axes_a3,'a_3 (rad/s^2)');

        title(handles.axes_a1 ,'Acceleration of theta_1');
        title(handles.axes_a2 ,'Acceleration of theta_2');
        title(handles.axes_a3 ,'Acceleration of theta_3');

        grid(handles.axes_a1, 'on');
        grid(handles.axes_a2, 'on');
        grid(handles.axes_a3, 'on');

if i == 1
        cla(handles.axes_a1, 'reset');
        cla(handles.axes_a2, 'reset');
        cla(handles.axes_a3, 'reset');
        
        handles.h_a1 = plot(handles.axes_a1, dt*(1:i), a1(1:i), 'r', 'LineWidth', 2);
        handles.h_a2 = plot(handles.axes_a2, dt*(1:i), a2(1:i), 'g', 'LineWidth', 2);
        handles.h_a3 = plot(handles.axes_a3, dt*(1:i), a3(1:i), 'b', 'LineWidth', 2);

else

        % Cập nhật dữ liệu đồ thị trong các vòng lặp tiếp theo
        set(handles.h_a1, 'XData', dt*(1:i), 'YData', a1(1:i));
        set(handles.h_a2, 'XData', dt*(1:i), 'YData', a2(1:i));
        set(handles.h_a3, 'XData', dt*(1:i), 'YData', a3(1:i));
    
end
   
end
