clear all
close all
time=0:0.01:1;
figure;
noise_scale=1
angle=-40/180*pi;
for iteration=1%:10

v_con=0.078*ones(size(time));
v_rais=0.49/(2*pi)*(1-cos(2*pi*time));
a=0.49*sin(2*pi*time);

a=a/max(a)/sqrt(2);
v_con=v_con/max(v_con)/2;
v_rais=v_rais/max(v_rais);

x_d_vis_con=v_con*sin(angle)+randn(size(time))*noise_scale;
x_d_vis_rais=v_rais*sin(angle)+randn(size(time))*noise_scale;

x_d_vest=(a)*sin(angle)+randn(size(time))*noise_scale;
x_d_vest2=(a)*sin(angle)+randn(size(time))*noise_scale;


x_d_comb_con=1/sqrt(2)*x_d_vis_con+1/sqrt(2)*x_d_vest;
x_d_comb_rais=1/sqrt(2)*x_d_vis_rais+1/sqrt(2)*x_d_vest;



X_vest=cumsum(a.*x_d_vest);
X_vest2=cumsum(a.*x_d_vest2);
X_vis_con=cumsum(v_con.*x_d_vis_con);
X_vis_rais=cumsum(v_rais.*x_d_vis_rais);

d_comb_con=sqrt(0.5*v_con.^2+0.5*a.^2);
d_comb_rais=sqrt(0.5*v_rais.^2+0.5*a.^2);

X_comb_con=cumsum(d_comb_con.*x_d_comb_con*2);
X_comb_rais=cumsum(d_comb_rais.*x_d_comb_rais*2);


hold on
subplot(2,3,2);
plot(time,X_vis_con,'b')
hold on
plot(time,v_con/max(v_con)*0.5*max(X_vis_con),':b')

subplot(2,3,5);
plot(time,X_vis_rais,'r')
hold on
plot(time,v_rais/max(v_rais)*0.5*max(X_vis_rais),':r')


hold on
subplot(2,3,1);
plot(time,X_vest,'g')
hold on
plot(time,a/max(a)*0.5*max(X_vest),':g')
subplot(2,3,4);
plot(time,X_vest2,'g')
hold on
plot(time,a/max(a)*0.5*max(X_vest),':g')

subplot(2,3,3);
plot(time,X_comb_con,'Color',[0.5 0.5 0.5])
hold on
plot(time,X_vis_con,'b')
plot(time,X_vest,'g')

subplot(2,3,6);
plot(time,X_comb_rais,'Color',[0.5 0.5 0.5])
hold on
plot(time,X_vis_rais,'r')
plot(time,X_vest2,'g')


ALL.X_comb_rais(iteration,:)=X_comb_rais;
ALL.X_comb_con(iteration,:)=X_comb_con;
ALL.X_vest(iteration,:)=X_vest;
ALL.X_vest2(iteration,:)=X_vest2;
ALL.X_vis_con(iteration,:)=X_vis_con;
ALL.X_vis_rais(iteration,:)=X_vis_rais;

end
% 
% figure
% subplot(2,3,2);
% plotyy(time,mean(ALL.X_vis_con),time,v_con)
% hold on
% subplot(2,3,5);
% plotyy(time,mean(ALL.X_vis_rais),time,v_rais)
% 
% 
% hold on
% subplot(2,3,1);
% plotyy(time,mean(ALL.X_vest),time,a)
% hold on
% subplot(2,3,4);
% plotyy(time,mean(ALL.X_vest2),time,a)
% 
% 
% subplot(2,3,3);
% plot(time,mean(ALL.X_comb_con))
% hold on
% subplot(2,3,6);
% plot(time,mean(ALL.X_comb_rais))
% hold on


%% 
C=-50:50;
k=0.01
A=sqrt(900)
RT=A./(k*C).*tanh(k*C*A);
psy=1./(1+exp(-2*k*C*A));


figure
subplot(1,2,1)
plot(psy)
subplot(1,2,2)
plot(RT)


