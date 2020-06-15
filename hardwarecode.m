clear all

f = 40e03;
Vs = 48;
Vo = 12;
P = 96;
R = Vo^2/P;
d = 0.25;
L = (1/0.8) * (0.5 - d) * (1/f) * 12;




% % =============================================
% % Simulation of the Feedback Loop
% % =============================================
% % Some figure formatting
% set(groot, 'defaulttextinterpreter','latex');  
% set(groot, 'defaultAxesTickLabelInterpreter','latex');  
% set(groot, 'defaultLegendInterpreter','latex'); 
% reference step
r_step = 1; 
d_step = 0; % no disturbance
V_f = 0.6;
DC = 48;
freq = 25e3;
Duty = 24;
AL = 235e-9;
N = 24;
Lm = 1.3e-3;
options = simset('Solver','ode45');
sim('forward.slx',[0,0.3],options);

figure(1);
hold all;
plot(t,output,'Linewidth',2);
plot(t,zeros(size(t)),'k')
grid on;
legend({'error','desired error'},'FontSize',12)
title('Output Voltage of Forward Converter')
legend('Output Voltage');
xlabel('time [sec]','FontSize',18)
ylabel('voltage [V]','FontSize',18)
% xlim([0.28,0.2802]);
% ylim([14,16]);
xlim([0.02,0.0202])
% ylim([-11,-10])

figure(2)
plot(t,inputCurrent,'Linewidth',2)  
grid on
title('Input Current')
legend('input current')
xlabel('time [sec]','FontSize',18)
ylabel('current [A]','FontSize',18)
xlim([0.28,0.2802]);

figure(10)
plot(t,inductorCurrent,'Linewidth',2)
grid on
title('Inductor Current')
legend('inductor current')
xlabel('time [sec]','FontSize',18)
ylabel('current [A]','FontSize',18)
xlim([0.28,0.2802]);
% ylim([0,5]);

figure(3);
hold all;
plot(t,magCurrent,'Linewidth',2);
plot(t,zeros(size(t)),'k')
grid on;
legend({'error','desired error'},'FontSize',12)
title('Magnetizing Current')
legend('Magnetizing Current');
xlabel('time [sec]','FontSize',18)
ylabel('current [A]','FontSize',18)
xlim([0.28,0.2802]);

figure(4);
hold all;
plot(t,flux,'Linewidth',2);
plot(t,zeros(size(t)),'k')
grid on;
legend({'error','desired error'},'FontSize',12)
title('Flux')
legend('flux');
xlabel('time [sec]','FontSize',18)
ylabel('Weber [wb]','FontSize',18)
xlim([0.28,0.2804]);

figure(5);
hold all;
plot(t,trVoltage,'Linewidth',2);
plot(t,zeros(size(t)),'k')
grid on;
legend({'error','desired error'},'FontSize',12)
title('Terminal Voltages')
legend('Terminal Voltages');
xlabel('time [sec]','FontSize',18)
ylabel('Voltage [V]','FontSize',18)
xlim([0.28,0.2804]);

figure(6);
hold all;
plot(t,pdiode1,'Linewidth',2);
hold on
plot(t,pdiode2,'Linewidth',2);
plot(t,zeros(size(t)),'k')
grid on;
hold off;
legend({'error','desired error'},'FontSize',12)
title('Primary Diode Measurements')
legend('Diode Current','Diode Voltage');
xlabel('time [sec]','FontSize',18)
ylabel('Voltage [V], Amperes [A]','FontSize',18)
xlim([0.28,0.2802]);

figure(7);
hold all;
plot(t,rdiode1,'Linewidth',2);
hold on
plot(t,rdiode2,'Linewidth',2);
plot(t,zeros(size(t)),'k')
grid on;
hold off;
legend({'error','desired error'},'FontSize',12)
title('Secondary Diode 2 Measurements')
legend('Diode Current','Diode Voltage');
xlabel('time [sec]','FontSize',18)
ylabel('Voltage [V], Amperes [A]','FontSize',18)
xlim([0.28,0.2802]);

figure(8);
hold all;
plot(t,ldiode1,'Linewidth',2);
hold on
plot(t,ldiode2,'Linewidth',2);
plot(t,zeros(size(t)),'k')
grid on;
hold off;
legend({'error','desired error'},'FontSize',12)
title('Secondary Diode 1 Measurements')
legend('Diode Current','Diode Voltage');
xlabel('time [sec]','FontSize',18)
ylabel('Voltage [V], Amperes [A]','FontSize',18)
xlim([0.28,0.2802]);

figure(9);
hold all;
plot(t,mosfet1,'Linewidth',2);
hold on
plot(t,mosfet2,'Linewidth',2);
plot(t,zeros(size(t)),'k')
grid on;
hold off;
legend({'error','desired error'},'FontSize',12)
title('MOSFET Measurements')
legend('MOSFET Current','MOSFET Voltage');
xlabel('time [sec]','FontSize',18)
ylabel('Voltage [V], Amperes [A]','FontSize',18)
xlim([0.28,0.2802]);
% ylim([-1,51])


xlim([0.1,0.1001])
% ylim([-1,4])
disturbance step
r_step = 0; % no reference
d_step = .001;
sim('EE498_feedbackLoop.slx',[0,50],options);
subplot(2,1,2)
hold all;
plot(t,e);
plot(t,zeros(size(t)),'k')
grid on;
legend({'error','desired error'},'FontSize',12)
xlabel('time [sec]','FontSize',12)
ylabel('error [m/s]','FontSize',12)
set(findall(gcf,'Type','line'),'LineWidth',2)
set(gca,'FontSize',12)
title('Problem Template')
