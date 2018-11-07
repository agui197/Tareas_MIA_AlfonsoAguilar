clc;
clear all;
close all;

[num,text]=xlsread('annual_generation_state.xls');

%%
temp=cell2table(text);
temp=temp(2:end,:); 
num=table(num(:,[1,5]));
states=unique(temp(:,2));
producers=unique(temp(:,3));
energys=unique(temp(:,3));
%%
%num=num(:,[1,5])
%%

data=horzcat(temp(:,[2,4]),num(:,1));
    
%%
l=ismember(data(:,1),states(2,1),'rows')
data(l,3)