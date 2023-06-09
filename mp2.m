clear
clc
close all

parameter = readmatrix('input.txt');

fid = fopen('input.txt');
first_line = fgetl(fid);
second_line = fgetl(fid);
first_line = str2num(first_line);
second_line = str2num(second_line);
size_of_ap = length(readmatrix('AP1.txt'));
fft_x = readmatrix('frequency_array.txt');

aps = [];
rel_vol_array = [];
rel_loc_array = [];

for c = 1:second_line
    start = (c-1)*size_of_ap+1;
    ending = (c-1)*size_of_ap+size_of_ap;
    aps=[aps;readmatrix('AP'+ string(c)+'.txt')];
    in_rng = aps(start:ending);
    
    [M,index] = max(abs(fft(in_rng)));
    rel_vol_array = [rel_vol_array; fft_x(index)* 299792458/(5.8e9)];
    
    
    temp = parameter(c,:)-first_line;
    squre_sum = 0;
    for k = 1:length(temp)
        squre_sum = squre_sum + temp(k)^2;
    end
    temp_norm = temp/sqrt(squre_sum);
    rel_loc_array = [rel_loc_array; temp_norm];
end

result=lsqr(rel_loc_array,rel_vol_array);
