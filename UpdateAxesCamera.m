function UpdateAxesCamera(handles)
global imSize1 camMatrix1 distort1 cb_Size cb_R cb_T image1
global imSize2 camMatrix2 distort2  R T image2

%% Camera1
cla(handles.axesCamera1);
% image1 = imread('frameL0.bmp');

% Update image size and FOV
% set(handles.editSizeX1, 'String', num2str(size(image1,2)));
% set(handles.editSizeY1, 'String', num2str(size(image1,1)));

UpdateGlobalVarible(handles);

% Generate chessboard model
board = GenerateBoard();
cb_om = rodrigues(cb_R/180*pi());
board_Tran = cb_om * board + cb_T' * ones(1, (cb_Size(1))*(cb_Size(2)));

% Generate image Point
imagePoint = camMatrix1 * board_Tran;
imagePointX = imagePoint(1,:)./imagePoint(3,:);
imagePointY = imagePoint(2,:)./imagePoint(3,:);
dstPoint = undistortPoint([imagePointX; imagePointY]', camMatrix1, distort1);
imagePointX = dstPoint(:,1);
imagePointY = dstPoint(:,2);

axes(handles.axesCamera1), image(image1); 
hold on, plot(handles.axesCamera1,imagePointX, imagePointY, 'r.')

tempX = reshape(imagePointX, [cb_Size(2) cb_Size(1)]);
tempY = reshape(imagePointY, [cb_Size(2) cb_Size(1)]);
fillPointX = [...
    tempX(1, 1:cb_Size(1)), ...
    tempX(2:cb_Size(2)-1, cb_Size(1))', ...
    fliplr(tempX(cb_Size(2), 1:cb_Size(1))),...
    fliplr(tempX(1:cb_Size(2)-1, 1)')];
fillPointY = [...
    tempY(1, 1:cb_Size(1)), ...
    tempY(2:cb_Size(2)-1, cb_Size(1))', ...
    fliplr(tempY(cb_Size(2), 1:cb_Size(1))),...
    fliplr(tempY(1:cb_Size(2)-1, 1)')];

hold on, fill(fillPointX, fillPointY,'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(handles.axesCamera1, 'XLim', [1 imSize1(1)])
set(handles.axesCamera1, 'YLim', [1 imSize1(2)])
set(handles.axesCamera1, ...
    'YDir', 'reverse') % 'XGrid', 'on', 'YGrid', 'on'...
   

%% Camera 2
cla(handles.axesCamera2);
% image2 = imread('frameR0.bmp');

% Update image size and FOV
% set(handles.editSizeX2, 'String', num2str(size(image2,2)));
% set(handles.editSizeY2, 'String', num2str(size(image2,1)));
% set(handles.editSizeX2, 'String', num2str(imSize2(2)));
% set(handles.editSizeY2, 'String', num2str(imSize2(1)));
% UpdateGlobalVarible(handles);

r_om = rodrigues(R/180*pi());
imagePoint = camMatrix2 * (r_om * board_Tran - repmat(T,[1 cb_Size(1)*cb_Size(2)]));
% imagePoint = camMatrix2 * board_Tran;
imagePointX = imagePoint(1,:)./imagePoint(3,:);
imagePointY = imagePoint(2,:)./imagePoint(3,:);
dstPoint = undistortPoint([imagePointX; imagePointY]', camMatrix2, distort2);
imagePointX = dstPoint(:,1);
imagePointY = dstPoint(:,2);

axes(handles.axesCamera2), image(image2); 
hold on, plot(handles.axesCamera2,imagePointX, imagePointY, 'b.')
tempX = reshape(imagePointX, [cb_Size(2) cb_Size(1)]);
tempY = reshape(imagePointY, [cb_Size(2) cb_Size(1)]);
fillPointX = [...
    tempX(1, 1:cb_Size(1)), ...
    tempX(2:cb_Size(2)-1, cb_Size(1))', ...
    fliplr(tempX(cb_Size(2), 1:cb_Size(1))),...
    fliplr(tempX(1:cb_Size(2)-1, 1)')];
fillPointY = [...
    tempY(1, 1:cb_Size(1)), ...
    tempY(2:cb_Size(2)-1, cb_Size(1))', ...
    fliplr(tempY(cb_Size(2), 1:cb_Size(1))),...
    fliplr(tempY(1:cb_Size(2)-1, 1)')];
hold on, fill(fillPointX, fillPointY,'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
set(handles.axesCamera2, 'XLim', [1 imSize2(1)])
set(handles.axesCamera2, 'YLim', [1 imSize2(2)])
set(handles.axesCamera2, ...
    'YDir', 'reverse') % 'XGrid', 'on', 'YGrid', 'on'...


%% 3D Viewer
normT = cb_T(3)*1; % uint: mm
IP_left = normT *[1 -0 0;0 1 0;0 0 1]*...
    [1/camMatrix1(1,1) 0 0;0 1/camMatrix1(2,2) 0;0 0 1]*...
    [1 0 -camMatrix1(1,3);0 1 -camMatrix1(2,3);0 0 1]*...
    [0 imSize1(1) imSize1(1) 0; 0 0 imSize1(2) imSize1(2);1 1 1 1 ];
BaseCam1 = 0.3*normT*([0 1 0 0 0 0;0 0 0 1 0 0;0 0 0 0 0 1]);
IP_right = normT *[1 -0 0;0 1 0;0 0 1]*...
    [1/camMatrix2(1,1) 0 0;0 1/camMatrix2(2,2) 0;0 0 1]*...
    [1 0 -camMatrix2(1,3);0 1 -camMatrix2(2,3);0 0 1]*...
    [0 imSize2(1) imSize2(1) 0; 0 0 imSize2(2) imSize2(2);1 1 1 1];

% Relative position of right camera wrt left camera: (om,T)
% R = rodrigues(om);
% Change of reference:
BaseCam2 = r_om * (BaseCam1 + repmat(T,[1 6]));
IP_right = r_om * (IP_right + repmat(T,[1 4]));

cla(handles.axesPlot3D);
axes(handles.axesPlot3D);
hold on, plot3(BaseCam1(1,:),BaseCam1(3,:),-BaseCam1(2,:),'r-','linewidth', 2);
t1 = [IP_left(:,[1,2]), BaseCam1(:,1)]; fill3(t1(1,:), t1(3,:), -t1(2,:), 'r');
t2 = [IP_left(:,[2,3]), BaseCam1(:,1)]; fill3(t2(1,:), t2(3,:), -t2(2,:), 'r');
t3 = [IP_left(:,[3,4]), BaseCam1(:,1)]; fill3(t3(1,:), t3(3,:), -t3(2,:), 'r');
t4 = [IP_left(:,[4,1]), BaseCam1(:,1)]; fill3(t4(1,:), t4(3,:), -t4(2,:), 'r');
text(BaseCam1(1,2),BaseCam1(3,2),-BaseCam1(2,2),'X','HorizontalAlignment','center','FontWeight','bold');
text(BaseCam1(1,6),BaseCam1(3,6),-BaseCam1(2,6),'Z','HorizontalAlignment','center','FontWeight','bold');
text(BaseCam1(1,4),BaseCam1(3,4),-BaseCam1(2,4),'Y','HorizontalAlignment','center','FontWeight','bold');
text(BaseCam1(1,1),BaseCam1(3,1),-BaseCam1(2,1),'Camera 1','HorizontalAlignment','center','FontWeight','bold', 'color', 'r');

% Draw IR Cam
hold on , plot3(BaseCam2(1,:),BaseCam2(3,:),-BaseCam2(2,:),'b-','linewidth', 2);
t1 = [IP_right(:,[1,2]), BaseCam2(:,1)]; fill3(t1(1,:), t1(3,:), -t1(2,:), 'b');
t2 = [IP_right(:,[2,3]), BaseCam2(:,1)]; fill3(t2(1,:), t2(3,:), -t2(2,:), 'b');
t3 = [IP_right(:,[3,4]), BaseCam2(:,1)]; fill3(t3(1,:), t3(3,:), -t3(2,:), 'b');
t4 = [IP_right(:,[4,1]), BaseCam2(:,1)]; fill3(t4(1,:), t4(3,:), -t4(2,:), 'b');
text(BaseCam2(1,2),BaseCam2(3,2),-BaseCam2(2,2),'X','HorizontalAlignment','center','FontWeight','bold');
text(BaseCam2(1,6),BaseCam2(3,6),-BaseCam2(2,6),'Z','HorizontalAlignment','center','FontWeight','bold');
text(BaseCam2(1,4),BaseCam2(3,4),-BaseCam2(2,4),'Y','HorizontalAlignment','center','FontWeight','bold');
text(BaseCam2(1,1),BaseCam2(3,1),-BaseCam2(2,1),'Camera 2','HorizontalAlignment','center','FontWeight','bold', 'color', 'b');



%% Draw chessboard
boardX = reshape(board_Tran(1,:), cb_Size(2), cb_Size(1));
boardY = reshape(board_Tran(2,:), cb_Size(2), cb_Size(1));
boardZ = reshape(board_Tran(3,:), cb_Size(2), cb_Size(1));
hold on, h = mesh(boardX,boardZ, -boardY);
set(h,'edgecolor','g','linewidth',1,'facecolor','b', 'FaceAlpha', 1);
                        
rotate3d on;
axis('equal');
title('Simulation the station (uint: mm)');
a = 50;
b = 20;
view(a,b);
grid on;
hold off;
axis vis3d;
axis tight;
alpha(0.3);

hold off;