clear all
clc
%%

fileID = fopen('input14.txt');
tline = fgetl(fileID);
i=1;
while ischar(tline)
    A{i,:} = strsplit(tline,' -> ');
    i=i+1;
    tline = fgetl(fileID);
end
fclose(fileID);


%%
for i=1:length(A)
    dictionary.(A{i,1}{1})=A{i,1}{2};
    dictionary_quantity.(A{i,1}{1}) = 0;
    letter_quantity.(A{i,1}{1}(1)) = 0;
    letter_quantity.(A{i,1}{1}(2)) = 0;
end

%%
%NNCB
dictionary_quantity.NN = 1;
dictionary_quantity.NC = 1;
dictionary_quantity.CB = 1;

fieldNames = fieldnames(dictionary_quantity);

letter_quantity.N = 2;
letter_quantity.C = 1;
letter_quantity.B = 1;
%%
%OOFNFCBHCKBBVNHBNVCP

letter_quantity.O = 2;
letter_quantity.F = 2;
letter_quantity.B = 4;
letter_quantity.N = 3;
letter_quantity.C = 3;
letter_quantity.H = 2;
letter_quantity.K = 1;
letter_quantity.V = 2;
letter_quantity.P = 1;

dictionary_quantity.OO = 1;
dictionary_quantity.OF = 1;
dictionary_quantity.FN = 1;
dictionary_quantity.NF = 1;
dictionary_quantity.FC = 1;
dictionary_quantity.CB = 1;
dictionary_quantity.BH = 1;
dictionary_quantity.HC = 1;
dictionary_quantity.CK = 1;
dictionary_quantity.KB = 1;
dictionary_quantity.BB = 1;
dictionary_quantity.BV = 1;
dictionary_quantity.VN = 1;
dictionary_quantity.NH = 1;
dictionary_quantity.HB = 1;
dictionary_quantity.BN = 1;
dictionary_quantity.NV = 1;
dictionary_quantity.VC = 1;
dictionary_quantity.CP = 1;

fieldNames = fieldnames(dictionary_quantity);

%%
%SCSCS KK VV B KVF K SCCSOV
letter_quantity.S = 5;
letter_quantity.C = 4;
letter_quantity.K = 4;
letter_quantity.V = 4;
letter_quantity.B = 1;
letter_quantity.F = 1;
letter_quantity.O = 1;

dictionary_quantity.SC = 3;
dictionary_quantity.CS = 3;
dictionary_quantity.SK = 1;
dictionary_quantity.KK = 1;
dictionary_quantity.KV = 2;
dictionary_quantity.VV = 1;
dictionary_quantity.VB = 1;
dictionary_quantity.BK = 1;
dictionary_quantity.VF = 1;
dictionary_quantity.FK = 1;
dictionary_quantity.KS = 1;
dictionary_quantity.CC = 1;
dictionary_quantity.SO = 1;
dictionary_quantity.OV = 1;


fieldNames = fieldnames(dictionary_quantity);
%%
iterations = 40;
dictionary_quantity_old = dictionary_quantity;
for i=1:iterations
    for j=1:length(fieldNames)
        dictionary_quantity_new.(fieldNames{j}) = 0;
    end
    for j=1:length(fieldNames)
        if dictionary_quantity_old.(fieldNames{j})>0
            val1 = [fieldNames{j}(1), dictionary.(fieldNames{j})];
            dictionary_quantity_new.(val1) = dictionary_quantity_new.(val1)+dictionary_quantity_old.(fieldNames{j});
            val2 = [dictionary.(fieldNames{j}),fieldNames{j}(2)];
            dictionary_quantity_new.(val2) = dictionary_quantity_new.(val2)+dictionary_quantity_old.(fieldNames{j});
            
            letter_quantity.(dictionary.(fieldNames{j})) = letter_quantity.(dictionary.(fieldNames{j})) + dictionary_quantity_old.(fieldNames{j});
        end
    end
    dictionary_quantity_old = dictionary_quantity_new;
end

