function plot_link1(handles,yaw_d,P0,P1)
%% Declare:
x_0=P0(1);
y_0=P0(2);
x_1=P1(1);
y_1=P1(2);
r=0.12;
h1=0.5;
opacity=get(handles.slider_opacity,'Value');
yaw=yaw_d-pi/2;
%% Parametric equation of a circle
theta=(0+yaw):pi/100:(2*pi+yaw);
x=r*cos(theta);
y=r*sin(theta);
z=(h1-0.1)*ones(size(theta));

%% Plot base_cylinder
surf(handles.axes1,[x_1+x; x_0+x], [y_1+y; y_0+y], [z; 0*ones(1,size(theta,2))], ...
                   'FaceColor',[0 0.4471 0.7412]  ,'EdgeColor','none','FaceAlpha',opacity);
fill3(handles.axes1, x,y,z, [0 0.4471 0.7412] ,'EdgeColor','k','FaceAlpha',opacity);
fill3(handles.axes1, x,y,0*ones(1,size(theta,2)),[0 0.4471 0.7412],'EdgeColor','k','FaceAlpha',opacity);
end

