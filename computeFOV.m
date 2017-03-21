function fov = computeFOV(M, size)
fc(1) = M(1,1);
fc(2) = M(2,2);
cc(1) = M(1,3);
cc(2) = M(2,3);
nx = size(1);
ny = size(2);

FOV_HOR = 180 * ( atan((nx - (cc(1)+.5))/fc(1))  +  atan((cc(1)+.5)/fc(1))   )/pi;
FOV_VER = 180 * ( atan((ny - (cc(2)+.5))/fc(2))  +  atan((cc(2)+.5)/fc(2))   )/pi;

fov = [FOV_HOR FOV_VER];