%% Homogeneous transformation matrix
clear all;
clc;
close all;
%% DH_parameters
syms theta1 theta2 theta3 L1 L2 L3 d1 d2 d3 L
%% DH_matrix
T0_1=DH_matrix(0,theta1,L1,0)
T1_2=DH_matrix(0,theta2+sym(pi),-L2,sym(pi/2))
T0_2=T0_1*T1_2
T2_3=DH_matrix(L3,theta3+sym(pi),0,0)

T0_3=simplify(T0_1*T1_2*T2_3)
%% 
zero=[0 0 0]';
z0=[0 0 1]'
z1=[T0_1(1,3) T0_1(2,3) T0_1(3,3)]'
z2=[T0_2(1,3) T0_2(2,3) T0_2(3,3)]'

p0=[0 0 0]';
p1_temp= T0_1*[0 0 0 1]';
p1=p1_temp(1:3)
p2_temp= T0_2*[0 0 0 1]';
p2=p2_temp(1:3)
p3_temp= T0_3*[0 0 0 1]';
p3=p3_temp(1:3)

J_p0=simplify(Ham_nhan_2_vector(z0,p3-p0));
J_p1=simplify(Ham_nhan_2_vector(z1,p3-p1));
J_p2=simplify(Ham_nhan_2_vector(z2,p3-p2));
J=[J_p0 J_p1 J_p2;
    z0   z1    z2  ]

