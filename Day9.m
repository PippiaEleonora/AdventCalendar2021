clear all
clc
%%

fileID = fopen('input9.txt');
A = fscanf(fileID,'%s');
fclose(fileID);

fileID = fopen('input9.txt');
B = fscanf(fileID,'%d');
fclose(fileID);

n = length(B);
m = length(A)/n;
for i=1:n
   for j=1:m
       matrix(i,j) = str2double(A((i-1)*m+j));
   end
end

%%
minmatrix = zeros(n,m);

for i=1:n
    for j=1:m
        dx = min(j+1,m);
        sx = max(j-1,1);
        up = max(i-1,1);
        dw = min(i+1,n);
        if (matrix(i,j)<matrix(i,dx) || dx==j) && (matrix(i,j)<matrix(i,sx) || sx==j) && ...
           (matrix(i,j)<matrix(up,j) || up==i) && (matrix(i,j)<matrix(dw,j) || dw==i)    
            minmatrix(i,j) = 1;
        end
    end
end

sum(sum((matrix+1).*minmatrix))

%%
nummatrix = zeros(n,m);
cur = 1;
for i=1:n
    for j=1:m
        dx = min(j+1,m);
        sx = max(j-1,1);
        up = max(i-1,1);
        dw = min(i+1,n);
        if (matrix(i,j)<matrix(i,dx) || dx==j) && (matrix(i,j)<matrix(i,sx) || sx==j) && ...
           (matrix(i,j)<matrix(up,j) || up==i) && (matrix(i,j)<matrix(dw,j) || dw==i)    
            nummatrix(i,j) = cur;
            cur = cur+1;
        end
    end
end

global ZoneMatrix

ZoneMatrix = zeros(n,m);
for i=1:n
    for j=1:m
        if ZoneMatrix(i,j)==0
            ZoneMatrix(i,j) = minZoneNumb(matrix,nummatrix,i,j);
        end
    end
end

nZones = sum(sum(minmatrix));
deepZones = zeros(1,nZones);
for i=1:nZones
    deepZones(i) = sum(sum(ZoneMatrix==i));
end


sorted = sort(deepZones);
disp(sorted(length(deepZones))*sorted(length(deepZones)-1)*sorted(length(deepZones)-2))









%%
function val = minZoneNumb(matrix,nummatrix,i,j)
    [n,m] = size(matrix);
    dx = min(j+1,m);
    sx = max(j-1,1);
    up = max(i-1,1);
    dw = min(i+1,n);
    if (matrix(i,j)<matrix(i,dx) || dx==j) && (matrix(i,j)<matrix(i,sx) || sx==j) && ...
           (matrix(i,j)<matrix(up,j) || up==i) && (matrix(i,j)<matrix(dw,j) || dw==i)    
        ZoneMatrix(i,j) = nummatrix(i,j);
    elseif matrix(i,j)==9
        ZoneMatrix(i,j) = -1;
    else
        if matrix(i,j)>matrix(i,dx)
            ZoneMatrix(i,j) = minZoneNumb(matrix,nummatrix,i,dx);
        elseif matrix(i,j)>matrix(i,sx)
            ZoneMatrix(i,j) = minZoneNumb(matrix,nummatrix,i,sx);
        elseif matrix(i,j)>matrix(up,j)
            ZoneMatrix(i,j) = minZoneNumb(matrix,nummatrix,up,j);
        else
            ZoneMatrix(i,j) = minZoneNumb(matrix,nummatrix,dw,j);
        end
    end
    val = ZoneMatrix(i,j);
end
    
%%
