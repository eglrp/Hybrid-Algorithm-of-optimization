function [ output_args ] = rspons( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

i=0;
regionstep=[0  0.01 1.9];

%**********************      һ��      ****************************************
for x=regionstep(1):regionstep(2):regionstep(3)
    i=i+1;
    y(i)=tmd([0.9113 0.16359 ],x,0.1);

end
x=regionstep(1):regionstep(2):regionstep(3);
plot(x,y,'-')
hold on

%--------------------------���ش���--------------------------------------------
i=0;
for x=regionstep(1):regionstep(2):regionstep(3)
    i=i+1;
    y(i)=tmdserie( [ 0.0815    1.0641    0.8707    0.0009    0.2944  ],x,0.1);

end
x=regionstep(1):regionstep(2):regionstep(3);
plot(x,y,'^')
hold on
% % pp=spline(x,y);
% fnplt(pp);
% hold on
% J = -fnmin(fncmb(pp,-1))
% %-----------------------���ز���������������������������������������������������
% i=0;
% for x=regionstep(1):regionstep(2):regionstep(3)
%     i=i+1;
%     y(i)=tmd([  0.8424    1.0074    0.1158    0.1343],x,0.1);
% 
% end
% x=regionstep(1):regionstep(2):regionstep(3);
% plot(x,y,'g.')
% hold on
% %***************���ز���***************************************
% i=0;
% for x=regionstep(1):regionstep(2):regionstep(3)
%     i=i+1;
%     y(i)=tmd([0.9672    0.8709    0.7948    1.0868    0.0866    0.0817    0.0839    0.0964],x,0.1);
% 
% end
% x=regionstep(1):regionstep(2):regionstep(3);
% plot(x,y,'r*')
% hold on

%****************���ش���************************************
i=0;
for x=regionstep(1):regionstep(2):regionstep(3)
    i=i+1;
    y(i)=tmdserie( [   0.0804    0.0180    0.0001    1.0634    0.8757    0.0780    0.6558  0.0016    0.2919    0.2718    0.1446],x,0.1);

end
x=regionstep(1):regionstep(2):regionstep(3);
plot(x,y,'*')
pp=spline(x,y);
fnplt(pp);
hold on
J = -fnmin(fncmb(pp,-1))
hold on

%*******************    ����  ********************************
% i=0;
% for x=regionstep(1):regionstep(2):regionstep(3)
%     i=i+1;
%     y(i)=tmd([0.7752 0.8327 0.8912 0.9554 1.0336 1.13228 0.05252 0.05773 0.05899 0.0635 0.0656 0.063299],x,0.1);
% 
% end
% x=regionstep(1):regionstep(2):regionstep(3);
% plot(x,y,'ko')
% hold on
%******************ԭϵͳ******************************
i=0;
for x=regionstep(1):regionstep(2):regionstep(3)
    i=i+1;
    y(i)=tmd([0,0],x,0.1);

end
x=regionstep(1):regionstep(2):regionstep(3);
plot(x,y,'co')
hold on

axis([0,2,0,7])
% legend('һ��','���ش���','���ز���','���ز���','ԭϵͳ')
legend('һ��','���ش���','���ش���','ԭϵͳ')
xlabel('Ƶ�ʱ�')
ylabel('�����')
end