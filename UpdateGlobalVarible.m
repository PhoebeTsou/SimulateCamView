function UpdateGlobalVarible(handles)
global camMatrix1 camMatrix2 distort1 distort2 R T imSize1 imSize2 ...
    fov1 fov2 cb_Size cb_square cb_R cb_T
camMatrix1(1,1) = str2double(get(handles.editFcX1, 'String'));
camMatrix1(2,2) = str2double(get(handles.editFcY1, 'String'));
camMatrix1(1,3) = str2double(get(handles.editCcX1, 'String'));
camMatrix1(2,3) = str2double(get(handles.editCcY1, 'String'));
camMatrix2(1,1) = str2double(get(handles.editFcX2, 'String'));
camMatrix2(2,2) = str2double(get(handles.editFcY2, 'String'));
camMatrix2(1,3) = str2double(get(handles.editCcX2, 'String'));
camMatrix2(2,3) = str2double(get(handles.editCcY2, 'String'));
distort1(1) = str2double(get(handles.editDist1_K1, 'String'));
distort1(2) = str2double(get(handles.editDist1_K2, 'String'));
distort1(3) = str2double(get(handles.editDist1_P1, 'String'));
distort1(4) = str2double(get(handles.editDist1_P2, 'String'));
distort1(5) = str2double(get(handles.editDist1_K3, 'String'));
distort1(6) = str2double(get(handles.editDist1_K4, 'String'));
distort1(7) = str2double(get(handles.editDist1_K5, 'String'));
distort1(8) = str2double(get(handles.editDist1_K6, 'String'));
distort2(1) = str2double(get(handles.editDist2_K1, 'String'));
distort2(2) = str2double(get(handles.editDist2_K2, 'String'));
distort2(3) = str2double(get(handles.editDist2_P1, 'String'));
distort2(4) = str2double(get(handles.editDist2_P2, 'String'));
distort2(5) = str2double(get(handles.editDist2_K3, 'String'));
distort2(6) = str2double(get(handles.editDist2_K4, 'String'));
distort2(7) = str2double(get(handles.editDist2_K5, 'String'));
distort2(8) = str2double(get(handles.editDist2_K6, 'String'));
R(1) = str2double(get(handles.editR1, 'String'));
R(2) = str2double(get(handles.editR2, 'String'));
R(3) = str2double(get(handles.editR3, 'String'));
T(1) = str2double(get(handles.editT1, 'String'));
T(2) = str2double(get(handles.editT2, 'String'));
T(3) = str2double(get(handles.editT3, 'String'));

imSize1(1) = str2double(get(handles.editSizeX1, 'String'));
imSize1(2) = str2double(get(handles.editSizeY1, 'String'));
imSize2(1) = str2double(get(handles.editSizeX2, 'String'));
imSize2(2) = str2double(get(handles.editSizeY2, 'String'));

fov1 = computeFOV(camMatrix1, imSize1);
fov2 = computeFOV(camMatrix2, imSize2);
set(handles.editFovX1, 'String', num2str(fov1(1)));
set(handles.editFovY1, 'String', num2str(fov1(2)));
set(handles.editFovX2, 'String', num2str(fov2(1)));
set(handles.editFovY2, 'String', num2str(fov2(2)));


cb_square = str2double(get(handles.edit_SquareSize, 'String'));
cb_Size(1) = str2double(get(handles.edit_PatternWidth, 'String'));
cb_Size(2) = str2double(get(handles.edit_PatternHeight, 'String'));
cb_R(1) =  str2double(get(handles.editBoardR1, 'String'));
cb_R(2) =  str2double(get(handles.editBoardR2, 'String'));
cb_R(3) =  str2double(get(handles.editBoardR3, 'String'));
cb_T(1) =  str2double(get(handles.editBoardT1, 'String'));
cb_T(2) =  str2double(get(handles.editBoardT2, 'String'));
cb_T(3) =  str2double(get(handles.editBoardT3, 'String'));
