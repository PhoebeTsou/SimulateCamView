function board = GenerateBoard()
global cb_Size cb_square

[cX cY] = meshgrid( 0:cb_Size(1)-1, 0:cb_Size(2)-1);
cX = cb_square * (cX - (cb_Size(1)-1)/2);
cY = cb_square * (cY - (cb_Size(2)-1)/2);
board = [cX(:), cY(:), zeros(cb_Size(1)*cb_Size(2), 1)]';
