fileID = fopen('input3.txt');
A = fscanf(fileID,'%s');
fclose(fileID);

fileID = fopen('input3.txt');
B = fscanf(fileID,'%d');
fclose(fileID);

n = length(B);
m = length(A);
split = reshape(A,m/n,n);

gamma = '';
epsilon = '';
for i=1:m/n
    sum1 = 0;
    sum0 = 0;
    for j=1:n
        if strcmp(split(i,j),'1')
            sum1 = sum1 + 1;
        else
            sum0 = sum0 + 1;
        end
    end
    
    if sum1>sum0
        gamma(i) = '1';
        epsilon(i) = '0';
    else
        gamma(i) = '0';
        epsilon(i) = '1';
    end
end

sol1 = bin2dec(gamma)*bin2dec(epsilon)


%%
i = 1;
candidates = split;
while i<=m/n
    sum1 = 0;
    sum0 = 0;
    digits = zeros(1,size(candidates,2));
    for j=1:size(candidates,2)
        if strcmp(candidates(i,j),'1')
            sum1 = sum1 + 1;
            digits(j) = 1;
        else
            sum0 = sum0 + 1;
        end
    end
    if sum1>=sum0
        candidates(:,digits==0) = [];
    else
        candidates(:,digits==1) = [];
    end
    
    if size(candidates,2)==1
        i = m/n+1;
    else
        i = i + 1;
    end
end
oxygen = bin2dec(candidates');

%%
i = 1;
candidates = split;
while i<=m/n
    sum1 = 0;
    sum0 = 0;
    digits = zeros(1,size(candidates,2));
    for j=1:size(candidates,2)
        if strcmp(candidates(i,j),'1')
            sum1 = sum1 + 1;
            digits(j) = 1;
        else
            sum0 = sum0 + 1;
        end
    end
    if sum1<sum0
        candidates(:,digits==0) = [];
    else
        candidates(:,digits==1) = [];
    end
    
    if size(candidates,2)==1
        i = m/n+1;
    else
        i = i + 1;
    end
end
Co = bin2dec(candidates');
% bin2dec(gamma)*bin2dec(epsilon)

sol2 = Co*oxygen