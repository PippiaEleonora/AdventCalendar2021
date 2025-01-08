A = readtable('input2.txt');

forward = sum(A.Var2(strcmp(A.Var1,'forward')));

down = sum(A.Var2(strcmp(A.Var1,'down')));
up = sum(A.Var2(strcmp(A.Var1,'up')));

sol1 = (down-up)*forward

aim = 0;
H = 0;
D = 0;
for i=1:length(A.Var1)
    if strcmp(A.Var1(i),'forward')
        H = H + A.Var2(i); 
        D = D + A.Var2(i)*aim;
    elseif strcmp(A.Var1(i),'down')
        aim = aim + A.Var2(i);
    else
        aim = aim - A.Var2(i);
    end
end
    
sol2 = H*D