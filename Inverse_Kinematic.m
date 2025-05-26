function [theta1_new, theta2_new, theta3_new] = Inverse_Kinematic(L1,L2,L3,X,Y,Z)
%%  Giới hạn 
    theta1_limit = deg2rad([-181, 181]);
    theta2_limit = deg2rad([-61, 91]);
    theta3_limit = deg2rad([-91, 91]);
%%  Kiểm tra giới hạn không gian làm việc
    distance = sqrt(X^2 + Y^2 + (Z - L1)^2);                                % Khoảng cách từ gốc đến điểm cần đến
    if distance > (L2 + L3) || distance < abs(L2 - L3)
    errordlg('Điểm yêu cầu nằm ngoài không gian làm việc của robot.', 'Error');
    return;
    end
%% Tính toán 4 trường hợp

% theta1
theta1=atan2(Y,X);

% theta3
cos_theta3 =(X^2+Y^2+(Z-L1)^2-L2^2-L3^2)/(2*L2*L3);
cos_theta3=  max(min(cos_theta3,1),-1);          % giới hạn cos_theta3 trong đoạn [-1;1]
sin_theta3 = sqrt(1-cos_theta3^2);
theta3_1=atan2(sin_theta3,cos_theta3);
theta3_2=atan2(-sin_theta3,cos_theta3);

% theta2
c1_1= sqrt(X^2+Y^2); 
c1_2=-sqrt(X^2+Y^2); 

theta_TH = [];
idx = 1;       % Chỉ số nghiệm

for c1 = [c1_1, c1_2]
        for theta3 = [theta3_1, theta3_2]
            a1=L2+L3*cos(theta3); 
            b1=-L3*sin(theta3)  ;   
            a2=-b1              ; 
            b2=a1               ;   
            c2=Z-L1             ;
            tmp=a1*b2-b1*a2     ;
cos_theta2=(c1*b2-b1*c2)/tmp;
sin_theta2=(a1*c2-c1*a2)/tmp;
theta2=atan2(sin_theta2,cos_theta2);

% Lưu nghiệm
            theta_TH(idx).theta1 = theta1;
            theta_TH(idx).theta2 = theta2;
            theta_TH(idx).theta3 = theta3;
            idx = idx + 1;
        end
end

%% Kiểm tra giới hạn

    valid_TH = [];
    invalid_TH = [];
    invalid_reasons = {};

    for k = 1:length(theta_TH)
        theta1 = theta_TH(k).theta1;
        theta2 = theta_TH(k).theta2;
        theta3 = theta_TH(k).theta3;

        % Kiểm tra giới hạn
        if theta1 < theta1_limit(1) || theta1 > theta1_limit(2)
            invalid_TH(end + 1) = k;
            invalid_reasons{k} = sprintf('theta1 vượt giới hạn.');
        elseif theta2 < theta2_limit(1) || theta2 > theta2_limit(2)
            invalid_TH(end + 1) = k;
            invalid_reasons{k} = sprintf('theta2 vượt giới hạn.');
        elseif theta3 < theta3_limit(1) || theta3 > theta3_limit(2)
            invalid_TH(end + 1) = k;
            invalid_reasons{k} = sprintf('theta3 vượt giới hạn.');
        else
            valid_TH(end+1) = k; % Nghiệm hợp lệ
        end
    end
%% Hiển thị thông báo
 if isempty(valid_TH)
        errordlg('Không có nghiệm nào hợp lệ.', 'Error');
        return;
 end

 % Chuẩn bị danh sách hiển thị
    valid_options = {};
    for k = valid_TH
        valid_options{end+1} = sprintf('Nghiệm %d: theta1 = %.2f°, theta2 = %.2f°, theta3 = %.2f°',k, rad2deg(theta_TH(k).theta1), rad2deg(theta_TH(k).theta2), rad2deg(theta_TH(k).theta3));
    end

    invalid_options = {};
    for k = invalid_TH
        reason = invalid_reasons{k};
        invalid_options{end+1} = sprintf('Nghiệm %d: theta1 = %.2f°, theta2 = %.2f°, theta3 = %.2f° (%s)',k, rad2deg(theta_TH(k).theta1), rad2deg(theta_TH(k).theta2), rad2deg(theta_TH(k).theta3), reason);
    end

    % Hiển thị hộp thoại lựa chọn nghiệm
    list_items = [valid_options, {'--------------------------------------------------------------------------------------------------'}, {'DANH SÁCH NGHIỆM KHÔNG HỢP LỆ !'}, invalid_options];
    choice = listdlg('PromptString', {'CHỌN MỘT NGHIỆM HỢP LỆ:'}, ...
                     'SelectionMode', 'single', ...
                     'ListString', list_items,...
                     'ListSize', [500, 300]);
    if isempty(choice)
        warndlg('Bạn chưa chọn nghiệm nào. Hủy thao tác.', 'Warning');
        return;
    end
    if choice < 1 || choice > length(valid_TH)
    warndlg('Lựa chọn không hợp lệ. Hủy thao tác.', 'Warning');
    return;
    end

    %% Gán nghiệm được chọn
    chosen_TH = theta_TH(valid_TH(choice));
    theta1_new = chosen_TH.theta1;
    theta2_new = chosen_TH.theta2;
    theta3_new = chosen_TH.theta3;
end