%% Project Point
% Reference to opencv
%     void projectPoints(
%         InputArray objectPoints: 3xN matrix
%         InputArray rvec, 
%         InputArray tvec, 
%         InputArray cameraMatrix, 
%         InputArray distCoeffs, 
%         OutputArray imagePoints, 
%         OutputArray jacobian=noArray(), 
%         double aspectRatio=0 )

function [imagePoints jacobian] = projectPoints(objectPoints, rvec, tvec, cameraMatrix, distCoeffs, aspectRatio)


%% check roation matrix
[m n] = size(rvec);
if(m == 3 && n == 3)
    rot = rodrigues(rvec);
elseif(m == 3 && n == 1)
    rot = rvec;
elseif(m == 1 && n == 3)
    rot = rvec';
else
    error('The rotation matrix is failed.');
end

%% check translation matrix
if(m == 3 && n == 1)
    tran = tvec;
elseif(m == 1 && n == 3)
    tran = tvec';
else
    error('The translation matrix is failed.');
return;