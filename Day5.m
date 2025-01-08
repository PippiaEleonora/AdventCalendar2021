% Substitute each "," with " ; " in the input
A = readtable('input5.txt');

x1 = A.Var1;
y1 = A.Var3;
x2 = A.Var5;
y2 = A.Var7;

selection = (x1==x2) | (y1==y2);

%%
n = max([x1; x2; y1; y2]);

Matrix = zeros(n);

stepX = (x1<x2)*2-1;
stepY = (y1<y2)*2-1;

for i=1:length(selection)
    if selection(i)
%         Matrix(x1(i):stepX(i):x2(i), y1(i):stepY(i):y2(i)) = Matrix(x1(i):stepX(i):x2(i), y1(i):stepY(i):y2(i)) + 1;
        Matrix([x1(i):stepX(i):x2(i)]+[((y1(i):stepY(i):y2(i))-1)*n]) = Matrix([x1(i):stepX(i):x2(i)]+[((y1(i):stepY(i):y2(i))-1)*n]) + 1;
    end
end

sum(sum(Matrix>1))


for i=1:length(selection)
    Matrix([x1(i):stepX(i):x2(i)]+[((y1(i):stepY(i):y2(i))-1)*n]) = Matrix([x1(i):stepX(i):x2(i)]+[((y1(i):stepY(i):y2(i))-1)*n]) + 1;
end

sum(sum(Matrix>1))
