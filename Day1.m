fileID = fopen('input1.txt');
A = fscanf(fileID,'%d');
fclose(fileID);

sol1 = sum(A(2:end)>A(1:end-1))

B=A(1:end-2)+A(2:end-1)+A(3:end);
sol2 = sum(B(2:end)>B(1:end-1))

% Better solution
sol2_bis = sum(A(4:end)>A(1:end-3))