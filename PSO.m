function [xm,fv] = PSO(fitness,N,c1,c2,w,M,D,xopt)

format long;
%epsilon=0.0000000000000001;
%------��ʼ����Ⱥ�ĸ���------------
%xoptΪ��ʼ��������ֵ
for i=1:N

    for j=1:D

        x(i,j)=randn+xopt;  %�����ʼ��λ��

        v(i,j)=randn;  %�����ʼ���ٶ�

    end

end

%------�ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg----------------------

for i=1:N

    p(i)=fitness(x(i,:));

    y(i,:)=x(i,:);

end

pg = x(N,:);             %PgΪȫ������

for i=1:(N-1)

    if fitness(x(i,:))<fitness(pg)

        pg=x(i,:);

    end

end

%------������Ҫѭ�������չ�ʽ���ε���------------
dd=0;
 figure;


for t=1:M
    dd=dd+1;
    for i=1:N

        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));

        x(i,:)=x(i,:)+v(i,:);

        if fitness(x(i,:))<p(i)

            p(i)=fitness(x(i,:));

            y(i,:)=x(i,:);

        end

        if p(i)<fitness(pg)

            pg=y(i,:);

        end
        

    end
     
    Pbest(t)=fitness(pg);
     
    plot(dd,Pbest(t),'*');
    xlabel('��������');
     ylabel('��ǰ�Ż��۲�ֵ'); 
    drawnow;
    hold on
    
%     if   t-1~=0 &&abs(Pbest(t-1)-Pbest(t))<=epsilon
%         break;
%     end
end
xm = pg';
fv = fitness(pg);



