function [ zhenfubi ] = vbrabsb( INPUTi,lamda ,miu)
%please input the gama and kesi, remember that input the kesi when gama input is completely finished  

%lamda����Ƶ�ʱ�
INPUT=reshape(INPUTi,numel(INPUTi)/2,2);
a=size(INPUT,1);%a Ϊ��������������
miuni=miu/a;%miuΪn�ض���������zhong������,����������������Ҫ����n(miuΪmius����һ������������������)
gama=INPUT(:,1);%��i�������������Ĺ���Ƶ�ʱ�
kesi=INPUT(:,2);%��i�������������������


ww1=miuni.*lamda.^2;
ww2=2.*lamda.*kesi./gama;
ww3=1.-(lamda.^2)./(gama.^2);
aa=ww1.*(ww3+ww2.^2)./(ww3.^2.+ww2.^2);
bb=ww1.*ww2./(ww3.^2+ww2.^2);
A=(1-lamda.^2)-sum(aa);
B=sum(bb);
zhenfubi=1/(A^2+B^2)^0.5;


end

