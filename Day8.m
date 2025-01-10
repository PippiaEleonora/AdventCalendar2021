clear all
clc

%%

opts = delimitedTextImportOptions("NumVariables", 15);
opts.VariableNames = ["v1"];

A = readtable('input8.txt', opts);

A = table2cell(A);

for i=1:length(A)
    A{i} = strsplit(A{i},' ');
end

for i=1:length(A)
    for j = 1:15
        stringMatrix{i,j} = A{i}{j};
    end
end

%%
% 0  = 6
% 1  = 2
% 2  = 5
% 3  = 5
% 4  = 4
% 5  = 5
% 6  = 6
% 7  = 4
% 8  = 7
% 9  = 6

% 2, 3, 5 => 5
% 0, 6, 9 => 6
charA = 'z';
charB = 'z';
charC = 'z';
charD = 'z';
charE = 'z';
charF = 'z';
charG = 'z';

n = length(stringMatrix);
numMatrix = -1*ones(n,15);
for i=1:n
    cur1 = 1;
    id1 = [];
    cur4 = 1;
    id4 = [];
    cur7 = 1;
    id7 = [];
    cur235 = 1;
    id235 = [];
    cur069 = 1;
    id069 = [];
    cur8 = 1;
    id8 = [];
    for j=1:15
        if length(stringMatrix{i,j})==2
            id1(cur1) = j;
            cur1 = cur1 + 1;
        end
        if length(stringMatrix{i,j})==3
            id7(cur7) = j;
            cur7 = cur7 + 1;
        end
        if length(stringMatrix{i,j})==4
            id4(cur4) = j;
            cur4 = cur4 + 1;
        end
        if length(stringMatrix{i,j})==5
            id235(cur235) = j;
            cur235 = cur235 + 1;
        end
        if length(stringMatrix{i,j})==6
            id069(cur069) = j;
            cur069 = cur069 + 1;
        end
        if length(stringMatrix{i,j})==7
            id8(cur8) = j;
            cur8 = cur8 + 1;
        end
    end
    numMatrix(i,id1) = 1;
    numMatrix(i,id7) = 7;
    numMatrix(i,id4) = 4;
    numMatrix(i,id8) = 8;
    
    if ~isempty(id1)
        charCF = stringMatrix{i,id1(1)};
        if ~isempty(id7)
            charA = strrep(strrep(stringMatrix{i,id7(1)},charCF(1),''),charCF(2),'');
        end
        charADG = 'z';
        for j=1:length(id235)
            if contains(stringMatrix{i,id235(j)},charCF(1)) && contains(stringMatrix{i,id235(j)},charCF(2))
                numMatrix(i,id235(j)) = 3;
                charADG = strrep(strrep(stringMatrix{i,id235(j)},charCF(1),''),charCF(2),'');
            end
        end
        if ~strcmp(charADG,'z')
            for j=1:length(id069)
                if ~contains(stringMatrix{i,id069(j)},charADG(1)) || ~contains(stringMatrix{i,id069(j)},charADG(2)) || ~contains(stringMatrix{i,id069(j)},charADG(3))
                    numMatrix(i,id069(j)) = 0;
                    if ~contains(stringMatrix{i,id069(j)},charADG(1))
                        charD = charADG(1);
                    elseif ~contains(stringMatrix{i,id069(j)},charADG(2))
                        charD = charADG(2);
                    else
                        charD = charADG(3);
                    end
                else
                    if contains(stringMatrix{i,id069(j)},charCF(1)) && contains(stringMatrix{i,id069(j)},charCF(2))
                        numMatrix(i,id069(j)) = 9;
                    else
                        numMatrix(i,id069(j)) = 6;
                    end
                end
            end
        else
            disp('error 069')
        end
        if ~isempty(id4)
            charBD = strrep(strrep(stringMatrix{i,id4(1)},charCF(1),''),charCF(2),'');
            for j=1:length(id235)
                if contains(stringMatrix{i,id235(j)},charBD(1)) && contains(stringMatrix{i,id235(j)},charBD(2)) && numMatrix(i,id235(j)) == -1
                    numMatrix(i,id235(j)) = 5;
                    if contains(stringMatrix{i,id235(j)},charCF(1))
                        charF = charCF(1);
                        charC = charCF(2);
                    else
                        charF = charCF(2);
                        charC = charCF(1);
                    end
                elseif numMatrix(i,id235(j)) == -1
                    numMatrix(i,id235(j)) = 2;
                    if contains(stringMatrix{i,id235(j)},charCF(1))
                        charC = charCF(1);
                        charF = charCF(2);
                    else
                        charC = charCF(2);
                        charF = charCF(1);
                    end
                end
            end
        else
            disp('error4')
        end
        
    elseif ~isempty(id7) && ~isempty(id4)
        for j=1:3
            for k=1:4
                if ~strcmp(stringMatrix{i,id7(1)}(j),stringMatrix{i,id4(1)}(k))
                    charA = stringMatrix{i,id7(1)}(j);
                    break;
                end
            end
        end
        charCF = strrep(stringMatrix{i,id7(1)},charA,'');
        charBD = strrep(strrep(stringMatrix{i,id4(1)},charCF(1),''),charCF(2),'');
        
        for j=1:length(id235)
            if contains(stringMatrix{i,id235(j)},charA) && contains(stringMatrix{i,id235(j)},charBD(1)) && contains(stringMatrix{i,id235(j)},charBD(2))
                numMatrix(i,id235(j)) = 5;
                if contains(stringMatrix{i,id235(j)},charCF(1))
                    charF = charCF(1);
                    charC = charCF(2);
                else
                    charF = charCF(2);
                    charC = charCF(1);
                end
                charG = strrep(strrep(strrep(strrep(stringMatrix{i,id4(1)},charBD(1),''),charBD(2),''),charA,''),charF,'');
            end
        end
        if ~strcmp(charF,'z')
            for j=1:length(id235)
                if contains(stringMatrix{i,id235(j)},charF) && numMatrix(i,id235(j)) == -1
                    numMatrix(i,id235(j)) = 3;
                elseif numMatrix(i,id235(j)) == -1
                    numMatrix(i,id235(j)) = 2;
                end
            end
        else
            if length(id235)>1
                disp('error 235')
            end
        end
        
        for j=1:length(id069)
            if ~contains(stringMatrix{i,id069(j)},charCF(1)) || ~contains(stringMatrix{i,id069(j)},charCF(2))
                numMatrix(i,id069(j)) = 6;
            else
                if contains(stringMatrix{i,id069(j)},charBD(1)) && contains(stringMatrix{i,id069(j)},charBD(2))
                    numMatrix(i,id069(j)) = 9;
                else
                    numMatrix(i,id069(j)) = 0;
                end
            end
        end
    else
        disp('error')
    end

end

sum(sum(numMatrix(:,12:15)==1))+sum(sum(numMatrix(:,12:15)==4))+sum(sum(numMatrix(:,12:15)==7))+sum(sum(numMatrix(:,12:15)==8))


sum(numMatrix(:,15)+numMatrix(:,14)*10+numMatrix(:,13)*100+numMatrix(:,12)*1000)