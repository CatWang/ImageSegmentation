close all
clc;
sp=[2 4; 3 10; 4 8];
nsp=size(sp);
sn=[4 2; 8 6; 10 5];
nsn=size(sn);
sd=[sp;sn];
lsd=[true true true false false false];
Y = nominal(lsd);

figure(1);
subplot(1,2,1)
    plot(sp(1:nsp,1),sp(1:nsp,2),'m+');
    hold on
    plot(sn(1:nsn,1),sn(1:nsn,2),'c*');
subplot(1,2,2)
    svmStrut = svmtrain(sd, Y, 'showplot',true);
    