% StartMatrix = [2 2 3 8 5 1 8 6 1 4; ...
%                4 5 5 2 3 8 8 5 5 3; ...
%                2 5 6 2 1 2 1 1 4 3; ...
%                2 6 6 6 6 8 5 3 3 7; ...
%                7 5 7 5 5 1 8 7 8 4; ...
%                3 5 7 2 5 3 4 8 7 1; ...
%                8 4 1 1 7 1 8 2 8 3; ...
%                7 7 4 2 6 6 8 3 8 5; ...
%                1 2 3 5 1 3 3 2 3 1; ...
%                2 5 4 6 1 6 5 3 4 5];
% StartMatrix = [5 4 8 3 1 4 3 2 2 3; ...
%                 2 7 4 5 8 5 4 7 1 1; ...
%                 5 2 6 4 5 5 6 1 7 3; ...
%                 6 1 4 1 3 3 6 1 4 6; ...
%                 6 3 5 7 3 8 5 4 7 8; ...
%                 4 1 6 7 5 2 4 6 4 5; ...
%                 2 1 7 6 8 4 1 7 2 1; ...
%                 6 8 8 2 8 8 1 1 3 4; ...
%                 4 8 4 6 8 4 8 5 5 4; ...
%                 5 2 8 3 7 5 1 5 2 6];
StartMatrix = [1 5 6 4 5 2 4 2 2 6; ...
                1 3 8 4 5 5 4 6 8 5; ...
                7 5 8 2 2 6 4 8 3 5; ...
                8 8 1 2 6 7 2 2 7 2; ...
                1 1 6 1 4 6 3 1 3 7; ...
                7 8 3 1 7 6 2 3 4 4; ...
                2 8 5 5 5 2 7 7 4 8; ...
                6 1 4 1 7 3 7 8 7 4; ...
                8 6 1 1 4 5 8 3 1 3; ...
                8 2 1 5 3 7 2 4 4 3];

currentStatus = StartMatrix;
countFlash = 0;
nEvolution = 100;
for i=1:nEvolution
    currentStatus = currentStatus+1;
    ListFlash = find(currentStatus==10);
    currentFlash = ones(10,10);
    currentFlash(ListFlash)=0;
    if ~isempty(ListFlash)
        existNeighbor = 1;
        while existNeighbor
            dx = ListFlash+1;
            dx(mod(dx,10)==1)=[];
            sx = ListFlash-1;
            sx(mod(sx,10)==0)=[];
            up = ListFlash-10;
            up(up<=0)=[];
            updx = up+1;
            updx(mod(updx,10)==1)=[];
            upsx = up-1;
            upsx(mod(upsx,10)==0)=[];
            dw = ListFlash+10;
            dw(dw>100)=[];
            dwdx = dw+1;
            dwdx(mod(dwdx,10)==1)=[];
            dwsx = dw-1;
            dwsx(mod(dwsx,10)==0)=[];
            neighborhood = [dx; sx; ...
                            up; updx; upsx; ...
                            dw; dwdx; dwsx]; 
            
            [indexNeigh, ~, numbAdd] = unique(neighborhood);
            currentStatus_old = currentStatus;
            for j=1:length(indexNeigh)
                currentStatus(indexNeigh(j)) = min(currentStatus(indexNeigh(j))+sum(numbAdd==j),10);
            end
            NewListFlash = find((currentFlash.*currentStatus)==10);
            if ~isempty(NewListFlash)
                currentFlash(NewListFlash) = 0;
                ListFlash = NewListFlash;
            else
                existNeighbor = 0;
            end
        end 
        ListFlash = find(currentStatus==10);
        countFlash = countFlash + length(ListFlash);
        currentStatus(ListFlash) = 0;
    end
end
countFlash

%%
% StartMatrix = [2 2 3 8 5 1 8 6 1 4; ...
%                4 5 5 2 3 8 8 5 5 3; ...
%                2 5 6 2 1 2 1 1 4 3; ...
%                2 6 6 6 6 8 5 3 3 7; ...
%                7 5 7 5 5 1 8 7 8 4; ...
%                3 5 7 2 5 3 4 8 7 1; ...
%                8 4 1 1 7 1 8 2 8 3; ...
%                7 7 4 2 6 6 8 3 8 5; ...
%                1 2 3 5 1 3 3 2 3 1; ...
%                2 5 4 6 1 6 5 3 4 5];
% StartMatrix = [5 4 8 3 1 4 3 2 2 3; ...
%                 2 7 4 5 8 5 4 7 1 1; ...
%                 5 2 6 4 5 5 6 1 7 3; ...
%                 6 1 4 1 3 3 6 1 4 6; ...
%                 6 3 5 7 3 8 5 4 7 8; ...
%                 4 1 6 7 5 2 4 6 4 5; ...
%                 2 1 7 6 8 4 1 7 2 1; ...
%                 6 8 8 2 8 8 1 1 3 4; ...
%                 4 8 4 6 8 4 8 5 5 4; ...
%                 5 2 8 3 7 5 1 5 2 6];
StartMatrix = [1 5 6 4 5 2 4 2 2 6; ...
                1 3 8 4 5 5 4 6 8 5; ...
                7 5 8 2 2 6 4 8 3 5; ...
                8 8 1 2 6 7 2 2 7 2; ...
                1 1 6 1 4 6 3 1 3 7; ...
                7 8 3 1 7 6 2 3 4 4; ...
                2 8 5 5 5 2 7 7 4 8; ...
                6 1 4 1 7 3 7 8 7 4; ...
                8 6 1 1 4 5 8 3 1 3; ...
                8 2 1 5 3 7 2 4 4 3];

currentStatus = StartMatrix;
countFlash = 0;
nEvolution = 100;
i = 1;
NotAll = 1;
while NotAll
    currentStatus = currentStatus+1;
    ListFlash = find(currentStatus==10);
    currentFlash = ones(10,10);
    currentFlash(ListFlash)=0;
    if ~isempty(ListFlash)
        existNeighbor = 1;
        while existNeighbor
            dx = ListFlash+1;
            dx(mod(dx,10)==1)=[];
            sx = ListFlash-1;
            sx(mod(sx,10)==0)=[];
            up = ListFlash-10;
            up(up<=0)=[];
            updx = up+1;
            updx(mod(updx,10)==1)=[];
            upsx = up-1;
            upsx(mod(upsx,10)==0)=[];
            dw = ListFlash+10;
            dw(dw>100)=[];
            dwdx = dw+1;
            dwdx(mod(dwdx,10)==1)=[];
            dwsx = dw-1;
            dwsx(mod(dwsx,10)==0)=[];
            neighborhood = [dx; sx; ...
                            up; updx; upsx; ...
                            dw; dwdx; dwsx]; 
            
            [indexNeigh, ~, numbAdd] = unique(neighborhood);
            currentStatus_old = currentStatus;
            for j=1:length(indexNeigh)
                currentStatus(indexNeigh(j)) = min(currentStatus(indexNeigh(j))+sum(numbAdd==j),10);
            end
            NewListFlash = find((currentFlash.*currentStatus)==10);
            if ~isempty(NewListFlash)
                currentFlash(NewListFlash) = 0;
                ListFlash = NewListFlash;
            else
                existNeighbor = 0;
            end
        end 
        ListFlash = find(currentStatus==10);
        countFlash = countFlash + length(ListFlash);
        currentStatus(ListFlash) = 0; 
        if length(ListFlash)==100
            NotAll = 0;
        end
    end
    if NotAll
        i = i+1;
    end
end
i