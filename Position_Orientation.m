function [P,O] = Position_Orientation(T0_i,P0)
%% Position
P_temp = T0_i*[P0;1];
P = P_temp(1:3);

%% Orientation
%Roll
O(1) = atan2(T0_i(3,2),T0_i(3,3));
%Pitch
O(2) = atan2(-T0_i(3,1),sqrt(T0_i(3,2)^2 + T0_i(3,3)^2));
%Yaw
O(3) = atan2(T0_i(2,1),T0_i(1,1));

end