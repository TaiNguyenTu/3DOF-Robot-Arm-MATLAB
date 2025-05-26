function [q, v, a, t] = calculate_Trajectory(start_q, end_q, dt, v_max, a_max)

    %% Declare:
    q_max= abs(end_q - start_q); 
    %% Tính toán
    
    % Tính thời gian và quãng đường trong giai đoạn tăng/giảm tốc
    t_a = v_max / a_max;              % Thời gian tăng tốc
    q_a = 0.5 * a_max * t_a^2;        % Quãng đường tăng tốc
    t_d = t_a;                        % Thời gian giảm tốc
    q_d = q_a;                        % Quãng đường giảm tốc


    if (q_a + q_d > q_max)            % không có đủ quãng đường để đạt đến vận tốc tối đa
        v_max = sqrt(a_max * q_max);  % Vận tốc giới hạn mới
        t_a = v_max / a_max;          % Thời gian tăng tốc mới
        t_d = t_a;                    % Thời gian giảm tốc mới
        t_c = 0;                      % Không có giai đoạn chuyển động đều
        T = t_a + t_d;                % Tổng thời gian
    else
        % Tính thời gian chuyển động đều
        t_c = (q_max - (q_a + q_d)) / v_max; % Thời gian chuyển động đều
        T = t_a + t_c + t_d;                 % Tổng thời gian
    end

    % Tạo vector thời gian
    % t = 0:dt:T;
    t = linspace(0, T, round(T/dt) + 1);

    % Khởi tạo mảng vị trí và vận tốc
    q = zeros(size(t));
    v = zeros(size(t));
    a = zeros(size(t));

    % Tính quỹ đạo cho từng thời điểm
    for i = 1:length(t)
        if t(i) < t_a
            % Giai đoạn tăng tốc
            a(i) = a_max;                                % Gia tốc
            v(i) = a_max * t(i);                         % Vận tốc
            q(i) = 0.5 * a_max * t(i)^2;                 % Vị trí
        elseif t(i) < t_a + t_c
            % Giai đoạn chuyển động đều
            a(i) = 0;                                    % Gia tốc
            v(i) = v_max;                                % Vận tốc
            q(i) = q_a + v_max * (t(i) - t_a);           % Vị trí
        else
            % Giai đoạn giảm tốc
            a(i) = -a_max;                               % Gia tốc
            v(i) = v_max - a_max * (t(i) - (t_a + t_c)); % Vận tốc
            q(i) = q_max - 0.5 * a_max * (T - t(i))^2;   % Vị trí
        end
     
    end
 % Đảm bảo các giá trị cuối cùng chính xác
    v(end) = 0;
    a(end) = 0;
    q(end) = q_max;

 
    if start_q > end_q
        % Nếu di chuyển ngược chiều, trừ đi giá trị vị trí
        q = start_q - q;
    else
        % Nếu di chuyển xuôi chiều, cộng thêm giá trị vị trí
        q = start_q + q;
    end
end
