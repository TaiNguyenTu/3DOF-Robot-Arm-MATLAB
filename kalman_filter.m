function [x_k_new, P_k_new] = kalman_filter(z_k, x_k, P_k, A, H, Q, R)
    % Bước dự đoán
    x_k_pred = A * x_k;
    P_k_pred = A * P_k * A' + Q;

    % Bước cập nhật
    K_k = P_k_pred * H' / (H * P_k_pred * H' + R); % Hệ số Kalman
    x_k_new = x_k_pred + K_k * (z_k - H * x_k_pred); % Cập nhật trạng thái
    P_k_new = (eye(size(K_k, 1)) - K_k * H) * P_k_pred; % Cập nhật hiệp phương sai
end