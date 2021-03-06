
syms s
s = tf('s');


L = 0.68e-3;
RL = 60e-3;
C = 30e-6;
RC = 3e-3;
Vin = 48;
N = 2;
Vo = 15;
Io = 3.2;
R = Vo / Io;
f = 25e3;
D = 0.22;

fcmax = RL * (1-D)^2 / (6*pi*L);

ideal_T = Vin*N/(L*C*(s^2 + s/(R*C) + (1 / L*C)));

t_B = Vin*N*(1 + s*RC*C);
t_A = L*C*(s^2 + s*((1/C/R)+(RC+RL)/L)+1/L/C);
t = t_B/t_A;


% t = (R*Vo*(1-D) - s*L*Vo/(1-D)) / (R*D^2 - 2*R*D + R + C*L*R*s^2 + L*s);

% 
figure(1)
bode(t,{1e2,10e7})
title('Bode Plot of Converter');
legend('Plant')
grid on
set(findall(gcf,'Type','line'),'LineWidth',2)
set(gca,'FontSize',12)

% figure(2)
% bode(ideal_T,{1e2,10e7})
% title('Bode Plot Ideal 48V Input');
% legend('ideal')
% grid on
% set(findall(gcf,'Type','line'),'LineWidth',2)
% set(gca,'FontSize',12)




% wz1 = 1 / RC / C;
% Gdo = Vo^2/(Vin*N);
% w_rhp_zero = (1-D)^2 * (R-RL) / L;
% w0 = sqrt( (RL+ (1-D)^2 * R) / R ) / sqrt(L*C);
% Q = w0 / (RL/L + 1/C/(R+RC));
% 
% Gdv = Gdo * ((1 + s/wz1) * ( 1 - s/w_rhp_zero)) / ( 1 + s / w0 / Q + s^2 / w0^2);
% poles = pole(Gdv);
% zeros = zero(Gdv);
% 

f_lc = 1 / (2*pi*sqrt(L*C));
f_esr = 1 / ( 2*pi*RC*C);
F0 = 2500;

Vosc = 1.8;
% L = 10e-6;
% C = 100e-6;
% Vin = 3;

angle = 80;
Fz2 = F0 * sqrt((1-sind(angle))/(1+sind(angle)))+200 ;
Fp2 = F0 * sqrt((1+sind(angle))/(1-sind(angle)))-200 ;
Vref = 0.9;
Cf3 = 2.2e-9;
Fz1 = Fz2/2  ;
Fp3 = f/2;
Rf3 = 1 / ( 2* pi * Cf3 * Fp2);
Rf1 = 1 / ( 2*pi*Cf3*Fz2) - Rf3;
Rf2 = Rf1*Vref / ( Vo - Vref);
Rc1 = 2*pi*F0*L*C*Vosc/Vin/Cf3;
Cc1 = 1 / (2*pi*Rc1*Fz1);
Cc2 = 1 / ( 2*pi*Rc1*Fp3);
% 
B  = ( 1 + s*Rc1*Cc1)*(1 + s*Cf3*(Rf1+Rf3));
A  = s*Rf1*(Cc1 + Cc2)*(1 + s*Rc1*(Cc1*Cc2 / (Cc1 + Cc2))*(1 + s*Rf3*Cf3));
% 
H = B/A;
% 
figure(2)
bode(H,{1e2,10e7})
title('Bode Plot of Compensator');
legend('Compensator')
grid on
set(findall(gcf,'Type','line'),'LineWidth',2)
set(gca,'FontSize',12)
% 
figure(3)  
bode(t*H,{1e2,10e7})
title('Bode Plot of Open Loop');
legend('Open-loop')
grid on
set(findall(gcf,'Type','line'),'LineWidth',2)
set(gca,'FontSize',12)
% 
% 
% 
% 
% figure(3)
% bode(Gdv*H)
% 
% % figure(3) 
% % bode(t,Gdv);
% % title('Bode plot of boost converter')
% % legend('ideal','non-ideal');
% 
