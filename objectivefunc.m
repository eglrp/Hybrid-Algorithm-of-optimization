function [ J] = objectivefunc( gamakesi )
%UNTITLED Summary of this function goes here

%objectivefunc([0.8505 0.9940 0.1280 0.1628])
%objectivefunc([0.7984 0.8785 0.9679  1.0910 0.0731 0.0814 0.0882 0.0939])
%   Detailed explanation goes
%   here%IIIIIIIIIII!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ȥ��С��0�Ľ�
for i=1:numel(gamakesi)
    if gamakesi(i)<=0||gamakesi(i)>=1.5
        J=inf;
        return;
    end
end
regionstep=[0  0.01 1.9];
x=regionstep(1):regionstep(2):regionstep(3);
y=zeros(1,numel(x))';
for i=1:numel(x)
    y(i)=tmd(gamakesi,x(i),0.1);
end
pp=spline(x,y);
% plot(x,y,'+')
% hold on
% fnplt(pp);
% hold on
% xlabel('Ƶ�ʱ�')
% ylabel('�����')

J = -fnmin(fncmb(pp,-1));%ѡȡ���ֵ��Ϊ�Ż�����
return;
% 
% dpp=fnder(pp);
% Z=fnzeros(dpp,[0.6,1.4]);
% 
% %************�жϵ�һ����ֵ����Ƿ�Ϊ����ֵ********************
% ddpp=fnder(dpp);
% if ppval(ddpp,Z(1))>=0
%     J=inf;
%     return;
% end           %��ʱ����ֹյ㣬�����ǲ�Ӧ�ñ�����ģ�������
% %*******************************************************
% % j=1;%��ʱ�������ź���д��������ȴ������ȫû��Ҫ��
% % ֻ��MATLABһ�м��ɣ��ʽ�MATLAB��C���ǲ����ǵ�
% % for i=1:2:size(Z,2)
% %     j=j+1;ȡ��������
% %     Px(j)=Z(1,i);
% % end
% Px=Z(1,1:2:end);
% 
% %********************�жϼ���ֵ��ĸ���*****************
% % if (numel(Px)~=(1+0.5*numel(gamakesi)))
% %     J=((numel(Px)-1-0.5*numel(gamakesi)))^2+9;
% %     return;
% % end
% %****************************************************
% 
% P=ppval(pp,Px);
% %I=sum((sum(P)/numel(P)-P).^2);
% J=sum(P)/numel(P);

end

