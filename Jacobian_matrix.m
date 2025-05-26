function J = Jacobian_matrix(theta1, theta2, theta3)

L1=0.5;
L2=0.4;
L3=0.6;
%% 
J= [-sin(theta1)*(L2*cos(theta2)+L3*cos(theta2 + theta3)) ,-cos(theta1)*(L1+L2*sin(theta2)+L3*sin(theta2 + theta3)) , -cos(theta1)*(L1+L3*sin(theta2+theta3));
     cos(theta1)*(L2*cos(theta2)+L3*cos(theta2 + theta3)) ,-sin(theta1)*(L1+L2*sin(theta2)+L3*sin(theta2 + theta3)) , -sin(theta1)*(L1+L3*sin(theta2+theta3));
            0                                             , L2*cos(theta2)+L3*cos(theta2 + theta3)                  ,  L3*cos(theta2 + theta3);
            0                                             , sin(theta1)                                             ,  sin(theta1);
            0                                             , -cos(theta1)                                            , -cos(theta1);            
            1                                             , 0                                                       , 0                                       ];
end