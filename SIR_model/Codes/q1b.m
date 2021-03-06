clc;
clear all;
close all;

tstart = 0;
dt = 0.01;
tend = 30;

t = tstart:dt:tend;

S = zeros(size(t));
I = zeros(size(t));
R = zeros(size(t));
V = zeros(size(t));
vac_flag = zeros(size(t));

index = 0;
for i=1:length(t)
    if t(i)==index
        vac_flag(i) = 1;
        index = index+1;
    end
end

C = 762;
I0 = 1;
alpha = 0.5;
beta = 0.00218;
vac_rate = 0.15;

S(1) = C;
I(1) = 1;
R(1) = 0;

ep_end = 0;

for i=2:length(t)
    S(i) = S(i-1) - beta*I(i-1)*S(i-1)*dt - vac_flag(i-1)*vac_rate*S(i-1);
    I(i) = I(i-1) + (beta*I(i-1)*S(i-1) - alpha*I(i-1))*dt;
    if(I(i)<0.5 && ep_end==0)
        ep_end = t(i);
    end
    V(i) = V(i-1) + vac_flag(i-1)*vac_rate*S(i-1);
    R(i) = R(i-1) + alpha*I(i-1)*dt ;
end

disp(max(I));
disp(ep_end);

figure()
plot(t,S);
hold on
plot(t,I,'r--');
hold on
plot(t,R,'g--');
hold on
plot(t,V,'k--');
title('SIR with Vaccination');
xlabel('Time t(in days)');
ylabel('Population');
legend('Susceptible S(t)', 'Infected I(t)', 'Recovered R(t)', 'Vaccinated V(t)');