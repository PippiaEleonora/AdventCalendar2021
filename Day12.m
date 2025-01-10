clear all
clc
%%

fileID = fopen('input12.txt');
tline = fgetl(fileID);
i=1;
while ischar(tline)
    A{i,:} = strsplit(tline,'-');
    i=i+1;
    tline = fgetl(fileID);
end
fclose(fileID);

%%
NodesNames = "";
NodesNumbers = zeros(length(A),2);
NodesType = [];
for i=1:length(A)
    node1 = A{i}{1};
    node2 = A{i}{2};
    if isempty(find(strcmp(NodesNames,node1), 1))
        NodesNames(end+1) = string(node1);
        NodesNumbers(i,1) = length(NodesNames)-1;
        asciiCode = double(node1);
        if length(asciiCode)==5
            NodesType(end+1) = 0;
        elseif length(asciiCode)==3
            NodesType(end+1) = 3;
        elseif asciiCode(1)>=97
            NodesType(end+1) = 1; %% only one time
        else
            NodesType(end+1) = 2; %% multiple time
        end
    else
        NodesNumbers(i,1) = find(strcmp(NodesNames,node1), 1)-1;
    end
    
    if isempty(find(strcmp(NodesNames,node2), 1))
        NodesNames(end+1) = string(node2);
        NodesNumbers(i,2) = length(NodesNames)-1;
        asciiCode = double(node2);
        if length(asciiCode)==5
            NodesType(end+1) = 0;
        elseif length(asciiCode)==3
            NodesType(end+1) = 3;
        elseif asciiCode(1)>=97
            NodesType(end+1) = 1; %% only one time
        else
            NodesType(end+1) = 2; %% multiple time
        end
    else
        NodesNumbers(i,2) = find(strcmp(NodesNames,node2), 1)-1;
    end
end
NodesNames(1) = [];
Neighborhood = zeros(length(NodesNames));
Neighborhood_size = zeros(length(NodesNames),1);
for i=1:length(A)
    n1 = NodesNumbers(i,1);
    n2 = NodesNumbers(i,2);
    Neighborhood_size(n1) = Neighborhood_size(n1) + 1;
    Neighborhood(n1, Neighborhood_size(n1)) = n2;
    Neighborhood_size(n2) = Neighborhood_size(n2) + 1;
    Neighborhood(n2, Neighborhood_size(n2)) = n1;
end


%%
tic
startNode = find(NodesType==0,1);
PathDescription(1,1) = startNode;
Visited = zeros(length(NodesType),1);
Visited(startNode) = 1;
SelectedNeighbor = ones(length(NodesType),1);
countPath = 1;
length_path = 1;
existPath = 1;
PathVisited(length_path) = 0;
exeption = 0;
nodeExeption = -1;
while existPath
    s = PathDescription(countPath,length_path);
    
    % find next
    if NodesType(s) == 3
        % End of the path! No next available
        countPath = countPath+1;
        PathDescription(countPath,:) = PathDescription(countPath-1,:);
        Visited(s) = 0;
        PathDescription(countPath,length_path) = 0;
        PathVisited(length_path) = 0;
        length_path = length_path-1;
        PathVisited(length_path) = PathVisited(length_path) + 1;
    else
        next = Neighborhood(s,PathVisited(length_path)+1);
        while (next==0 || (Visited(next) && exeption) || NodesType(next)==0)
            if PathVisited(length_path)+1>Neighborhood_size(s)
                if s==nodeExeption
                    exeption = 0;
                    nodeExeption = -1;
                else
                    Visited(s) = 0;
                end
                PathDescription(countPath,length_path) = 0;
                PathVisited(length_path) = 0;
                length_path = length_path-1;
                if length_path == 0
                    next = -1;
                    break;
                else
                    s = PathDescription(countPath,length_path);
                end
            end
            PathVisited(length_path) = PathVisited(length_path)+1;
            next = Neighborhood(s,PathVisited(length_path)+1);
        end
        
        if next~=-1
            if Visited(next)
                exeption = 1;
                nodeExeption = next;
            end
            PathDescription(countPath,length_path+1) = next;
            if NodesType(next)==1
                Visited(next) = 1;
            end
            length_path = length_path+1;
            PathVisited(length_path) = 0;
        else
            existPath = 0;
        end
    end
end

toc
%% Another solution
tic 
global n_paths
first_star = 0;
second_star =1;
n_paths = count_next_path(find(NodesType==0,1), [], second_star, Neighborhood_size, Neighborhood, NodesType);
toc


function n_paths = count_next_path(start, seen, twice, Neighborhood_size, Neighborhood, NodesType)
    if NodesType(start)==1 || NodesType(start)==0
        seen(end+1) = start;
    end
    n_paths = 0;
    for n = 1:Neighborhood_size(start)
        target = Neighborhood(start,n);
        if NodesType(target)==3
            n_paths = n_paths + 1;
        elseif isempty(find(seen==target, 1))
            n_paths = n_paths + count_next_path(target, seen, twice, Neighborhood_size, Neighborhood, NodesType);
        elseif NodesType(target)~=0 && twice
            n_paths = n_paths + count_next_path(target, seen, 0, Neighborhood_size, Neighborhood, NodesType);
        end
    end
end
