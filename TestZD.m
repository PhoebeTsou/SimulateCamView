clear all;

%% Basic Parameters
imSize_Depth = [320 240];
cam_Depth = [...
    211.56 0 160;...
    0 216.04 120;...
    0 0 1];

imSize_Color = [320 240];
cam_Color = [...
    211.56 0 160;...
    0 216.04 120;...
    0 0 1];

% imSize_Color = [640 480];
% cam_Color = [...
%     582.65 0 320;...
%     0 579.75 240;...
%     0 0 1];

R = [0,0,0];
R_rod = rodrigues(R/180*pi());
T = [20,0,0]';
P = [R_rod,T];

Z = 5000;

%% Generate image index
[DepthX DepthY] = meshgrid( 1:imSize_Depth(1), 1:imSize_Depth(2) );
[ColorX ColorY] = meshgrid( 1:imSize_Color(1), 1:imSize_Color(2) );

idx_DepthX = DepthX(:);
idx_DepthY = DepthY(:);


tempX1 = (idx_DepthX - cam_Depth(1,3)) .* Z ./ cam_Depth(1,1);
tempY1 = (idx_DepthY - cam_Depth(2,3)) .* Z ./ cam_Depth(2,2);
tempZ1 = ones(size(idx_DepthX))' * Z;

temp1 = [tempX1(:), tempY1(:), tempZ1(:)]';
temp2 = R_rod * temp1 - T*ones(1,size(temp1,2));

newX = temp2(1,:)./temp2(3,:) * cam_Color(1,1) + cam_Color(1,3);
newY = temp2(2,:)./temp2(3,:) * cam_Color(2,2) + cam_Color(2,3);

newX = reshape(newX, fliplr(imSize_Depth));
newY = reshape(newY, fliplr(imSize_Depth));

dX = DepthX - newX;
dY = DepthY - newY;

subplot(321), imshow(DepthX,[]), title('DepthX'), colorbar
subplot(322), imshow(DepthY,[]), title('DepthY'), colorbar
subplot(323), imshow(newX,[]), title('newX'), colorbar
subplot(324), imshow(newX,[]), title('newY'), colorbar
subplot(325), imshow(dX,[]), title('dX'), colorbar
subplot(326), imshow(dY,[]), title('dY'), colorbar

impixelinfo

colormap(jet); 

