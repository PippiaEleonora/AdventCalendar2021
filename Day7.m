fileID = fopen('input7.txt');
A = fscanf(fileID,'%s');
fclose(fileID);

Positions = str2double(strsplit(A,','));


maxN = max(Positions);
minN = min(Positions);

start = round(mean(Positions));
winning = 0;
best = sum(Positions);
if median(Positions)<start
    for i=start:-1:1
        curr = sum(abs(Positions-i));
        if curr < best
            best = curr;
            winning = i;
        end
    end
else
    for i=start:maxN
        curr = sum(abs(Positions-i));
        if curr < best
            best = curr;
            winning = i;
        end
    end
end


%%

best = sum(Positions.*(Positions+1)/2);
winning = 0;
if median(Positions)<start
    for i=start:-1:1
        curr = sum(abs(Positions-i).*(abs(Positions-i)+1)/2);
        if curr < best
            best = curr;
            winning = i;
        end
    end
else
    for i=start:maxN%length(Positions)
        curr = sum(abs(Positions-i).*(abs(Positions-i)+1)/2);
        if curr < best
            best = curr;
            winning = i;
        end
    end
end


