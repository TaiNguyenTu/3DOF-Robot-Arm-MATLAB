function handles = plot_joint_velocity(handles,dt,i,v1,v2,v3)
      


        xlabel(handles.theta1_dot,'Time (s)');
        xlabel(handles.theta2_dot,'Time (s)');
        xlabel(handles.theta3_dot,'Time (s)');

        ylabel(handles.theta1_dot,'v_1 (rad/s)');
        ylabel(handles.theta2_dot,'v_2 (rad/s)');
        ylabel(handles.theta3_dot,'v_3 (rad/s)');

        title(handles.theta1_dot ,'Velocity of theta_1');
        title(handles.theta2_dot ,'Velocity of theta_2');
        title(handles.theta3_dot ,'Velocity of theta_3');

        grid(handles.theta1_dot, 'on');
        grid(handles.theta2_dot, 'on');
        grid(handles.theta3_dot, 'on');

if i == 1
        cla(handles.theta1_dot, 'reset');
        cla(handles.theta2_dot, 'reset');
        cla(handles.theta3_dot, 'reset');
     
        handles.h_v1 = plot(handles.theta1_dot, dt*(1:i), v1(1:i), 'r', 'LineWidth', 2);
        handles.h_v2 = plot(handles.theta2_dot, dt*(1:i), v2(1:i), 'g', 'LineWidth', 2);
        handles.h_v3 = plot(handles.theta3_dot, dt*(1:i), v3(1:i), 'b', 'LineWidth', 2);
else

        % Cập nhật dữ liệu đồ thị trong các vòng lặp tiếp theo
        set(handles.h_v1, 'XData', dt*(1:i), 'YData', v1(1:i));
        set(handles.h_v2, 'XData', dt*(1:i), 'YData', v2(1:i));
        set(handles.h_v3, 'XData', dt*(1:i), 'YData', v3(1:i));
      
end
end
