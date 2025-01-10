A = readtable('input13.txt');

x1 = A.Var1;
y1 = A.Var2;


%% Fold paper
Matrix = [x1 y1];

% fold along x=655
% fold along y=447
% fold along x=327
% fold along y=223
% fold along x=163
% fold along y=111
% fold along x=81
% fold along y=55
% fold along x=40
% fold along y=27
% fold along y=13
% fold along y=6
valFold = [655, 447, 327,223,163, 111, 81, 55, 40, 27, 13, 6];
directionFold = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2];

for i=1:length(valFold)
    id = find(Matrix(:,directionFold(i))>valFold(i));
    Matrix(id,directionFold(i)) = valFold(i)*2-Matrix(id,directionFold(i));
    Matrix = unique(Matrix,'rows');
end


%% Draw code
Paper = zeros(max(Matrix(:,2))+1, max(Matrix(:,1))+1);
for i=1:size(Matrix,1)
    Paper(Matrix(i,2)+1, Matrix(i,1)+1) = 1;
end
sum(sum(Paper))