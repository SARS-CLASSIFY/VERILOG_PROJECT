function [datax,datay] = my_xlsread(filename,sheet,xlsrange)
data = xlsread(filename,sheet,xlsrange);
datax = data(:,1);%读取第一列
datay = data(:,2);%读取第二列
end