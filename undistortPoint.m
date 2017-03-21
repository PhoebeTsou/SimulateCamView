
%%
% srcPoint: N*2 matrix 
%%
function dstPoint = undistortPoint(srcPoint, cameraMatrix, distortCoff)

% [mx,my] = meshgrid(0:nx/20:(nx-1),0:ny/20:(ny-1));
% [nnx,nny]=size(mx);
% px=reshape(mx',nnx*nny,1);
% py=reshape(my',nnx*nny,1);

fc(1) = cameraMatrix(1,1);
fc(2) = cameraMatrix(2,2);
cc(1) = cameraMatrix(1,3);
cc(2) = cameraMatrix(2,3);
px = srcPoint(:,1);
py = srcPoint(:,2);

rays=inv(cameraMatrix)*[px';py';ones(1,length(px))];
x=[rays(1,:)./rays(3,:);rays(2,:)./rays(3,:)];

xd=apply_distortion(x, distortCoff);
px2=fc(1)*xd(1,:)+cc(1);
py2=fc(2)*xd(2,:)+cc(2);

dstPoint = [px2', py2'];
end
