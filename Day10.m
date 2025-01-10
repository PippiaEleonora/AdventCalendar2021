clear all
clc
%%

fileID = fopen('input10.txt');
tline = fgetl(fileID);
i=1;
while ischar(tline)
    A{i,1} = tline;
    i=i+1;
    tline = fgetl(fileID);
end
fclose(fileID);


%%

        
mismatchSimbol = cell(length(A),1);
count = 0;
for i=1:length(A)
    string = A{i};
    n = length(string);
    numberA = zeros(n,1);
    checkNumber = zeros(n,1);
    pointer = 1;
    saveInfo(i,3) = n;
    for j=1:n
        switch string(j)
            case '<'
                numberA(j) = 25137;
            case '>'
                numberA(j) = -25137;
            case '('
                numberA(j) = 3;
            case ')'
                numberA(j) = -3;
            case '['
                numberA(j) = 57;
            case ']'
                numberA(j) = -57;
            case '{'
                numberA(j) = 1197;
            case '}'
                numberA(j) = -1197;
        end
        if numberA(j)>0
            checkNumber(pointer) = numberA(j);
            pointer = pointer + 1;
        else
            if numberA(j)+checkNumber(pointer-1) == 0
                pointer = pointer-1;
                checkNumber(pointer) = 0;
            else
                count = count - numberA(j);
                saveInfo(i,1) = j;
                saveInfo(i,2) = numberA(j);
                
                break
            end
        end
    end
end
disp(count)

%%
mismatchSimbol = cell(length(A),1);
count = 0;
rate = zeros(length(A),1);
for i=1:length(A)
    string = A{i};
    n = length(string);
    numberA = zeros(n,1);
    checkNumber = zeros(n,1);
    pointer = 0;
    saveInfo(i,3) = n;
    for j=1:n
        switch string(j)
            case '<'
                numberA(j) = 4;
            case '>'
                numberA(j) = -4;
            case '('
                numberA(j) = 1;
            case ')'
                numberA(j) = -1;
            case '['
                numberA(j) = 2;
            case ']'
                numberA(j) = -2;
            case '{'
                numberA(j) = 3;
            case '}'
                numberA(j) = -3;
        end
        if numberA(j)>0
            checkNumber(pointer+1) = numberA(j);
            pointer = pointer + 1;
        else
            if numberA(j)+checkNumber(pointer) == 0
                checkNumber(pointer) = 0;
                pointer = pointer-1;
            else
                count = count - numberA(j);
                saveInfo(i,1) = j;
                saveInfo(i,2) = numberA(j);
                
                break
            end
        end
    end
    if saveInfo(i,1)==0
        for j=pointer:-1:1
            rate(i) = rate(i)*5+checkNumber(j);
        end
    end
end

sorted = sort(rate);
sorted(sorted == 0) = [];
sorted(ceil(length(sorted)/2))