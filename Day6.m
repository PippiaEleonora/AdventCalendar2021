fileID = fopen('input6.txt');
A = fscanf(fileID,'%s');
fclose(fileID);
starting_clock = str2double(strsplit(A,','));

N_lanterfish = [sum(starting_clock==0), sum(starting_clock==1), sum(starting_clock==2), ...
                sum(starting_clock==3), sum(starting_clock==4), sum(starting_clock==5), ...
                sum(starting_clock==6), sum(starting_clock==7), sum(starting_clock==8)];

iteration = 256;
%%
for i=1:iteration
    current_evolv = N_lanterfish(1);
    N_lanterfish(1:end-1) = N_lanterfish(2:end);
    N_lanterfish(end) = current_evolv;
    N_lanterfish(7) = N_lanterfish(7) + current_evolv;
    
%     add(1,i) = sum(N_lanterfish);
%     if i==1
%         add(2,i) = current_evolv;
%         add(3,i) = current_evolv;
%     else
%         add(2,i) = add(2,i-1) + current_evolv;
%         add(3,i) = current_evolv;
%     end
end

sum(N_lanterfish)

            
