function [ zhenfubi ] =tmdserialmass( a ,lamda,miu)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sz=numel(a)/2;%��������������
miuni=miu/sz;
insertlocat=1:3:3*sz-3;%��������������λ��

gamakesimiu=-ones(1,3*sz-1);
gamakesimiu(insertlocat)=miuni*ones(1,sz-1);
gamakesimiu(gamakesimiu<0)=a;


[ zhenfubi ] = tmdserie( gamakesimiu,lamda ,miu);

end

