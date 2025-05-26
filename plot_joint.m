function handles = plot_joint(handles,dt,i,q1,q2,q3)

        xlabel(handles.axes_q1,'Time (s)');
        xlabel(handles.axes_q2,'Time (s)');
        xlabel(handles.axes_q3,'Time (s)');

        ylabel(handles.axes_q1,'q_1 (rad)');
        ylabel(handles.axes_q2,'q_2 (rad)');
        ylabel(handles.axes_q3,'q_3 (rad)');

        title(handles.axes_q1 ,'Theta_1');
        title(handles.axes_q2 ,'Theta_2');
        title(handles.axes_q3 ,'Theta_3');

        grid(handles.axes_q1, 'on');
        grid(handles.axes_q2, 'on');
        grid(handles.axes_q3, 'on');



if i == 1
        cla(handles.axes_q1, 'reset');
        cla(handles.axes_q2, 'reset');
        cla(handles.axes_q3, 'reset');

        handles.h_q1 = plot(handles.axes_q1, dt*(1:i), q1(1:i), 'r', 'LineWidth', 2);
        handles.h_q2 = plot(handles.axes_q2, dt*(1:i), q2(1:i), 'g', 'LineWidth', 2);
        handles.h_q3 = plot(handles.axes_q3, dt*(1:i), q3(1:i), 'b', 'LineWidth', 2);
    
else
  
        % Cập nhật dữ liệu đồ thị trong các vòng lặp tiếp theo
        set(handles.h_q1, 'XData', dt*(1:i), 'YData', q1(1:i));
        set(handles.h_q2, 'XData', dt*(1:i), 'YData', q2(1:i));
        set(handles.h_q3, 'XData', dt*(1:i), 'YData', q3(1:i));
     

   
end
end