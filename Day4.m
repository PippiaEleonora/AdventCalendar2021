
fileID = fopen('input4.txt');
A = fscanf(fileID,'%s');
fclose(fileID);

%Add manually in the input a ";" at the end of the random numbers
randNumb = str2double(strsplit(A(1:strfind(A,';')),','));
gameTable = table2array(readtable('input4.txt'));

Win = 0;
n = 1;
raws = zeros(size(gameTable,1),1);
columns = zeros(size(gameTable,1),1);
Card = zeros(size(gameTable,1)/5,1);
while n<=length(randNumb) && ~Win
    matches = find(transpose(gameTable)==randNumb(n));
    r = floor((matches-1)/5)+1;%mod(matches,size(gameTable,1));
    c = (floor((matches-1)/25))*5 + mod(matches-1,5)+1; %floor(r/5)*5 + col;% matches-(col-1)*size(gameTable,1);
    columns(c) = columns(c) + 1;
    raws(r) = raws(r) + 1;
    
    if any(raws==5)
        val = find(raws==5);
        Card(floor((val-1)/5)+1) = 1;
        Win = 1;
    elseif any(columns==5)
        val = find(columns==5);
        Card(floor((val-1)/5)+1) = 1;
        Win = 1;
    else 
        n = n+1;
    end
end
    
if sum(columns==5)
    val = find(columns==5);
else
    val = find(raws==5);
end
firstID = floor((val-1)/5)*5+1;
Victory = gameTable(firstID:firstID+4,:);
unmarked = setdiff(Victory,randNumb(1:n));
marked = setdiff(Victory,unmarked);

sol1 = sum(unmarked)*randNumb(n)%sum(marked)

%%

fileID = fopen('input4.txt');
A = fscanf(fileID,'%s');
fclose(fileID);

randNumb = str2double(strsplit(A(1:strfind(A,';')),','));
gameTable = table2array(readtable('input4.txt'));

Win = 0;
n = 1;
raws = zeros(size(gameTable,1),1);
columns = zeros(size(gameTable,1),1);
Card = zeros(size(gameTable,1)/5,1);
Card_old = zeros(size(gameTable,1)/5,1);
while n<=length(randNumb) && ~Win
    Card_old = Card;
    matches = find(transpose(gameTable)==randNumb(n));
    r = floor((matches-1)/5)+1;%mod(matches,size(gameTable,1));
    c = (floor((matches-1)/25))*5 + mod(matches-1,5)+1; %floor(r/5)*5 + col;% matches-(col-1)*size(gameTable,1);
    columns(c) = columns(c) + 1;
    raws(r) = raws(r) + 1;
    
    if any(raws(r)==5)
        val = find(raws(r)==5);
        Card(floor((r(val)-1)/5)+1) = 1;
    end
    if any(columns(c)==5)
        val = find(columns(c)==5);
        Card(floor((c(val)-1)/5)+1) = 1;
    end
    if prod(Card)>0
        Win = 1;
    else
        n = n+1;
    end
    
end

idCard = find(Card_old == 0)
Victory = gameTable((idCard-1)*5+1:(idCard-1)*5+5,:);
unmarked = setdiff(Victory,randNumb(1:n));
marked = setdiff(Victory,unmarked);

sol2 = sum(unmarked)*randNumb(n)%sum(marked)