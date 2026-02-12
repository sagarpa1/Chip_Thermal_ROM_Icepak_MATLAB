data = readtable('Result_Table_T_Q.csv');

P = data.P_die;        
V = data.V_in;              
Q = data.Heat_flow;         
T = data.Temperature_Max;  

% TRAIN ROM
X = [P V];
mdl_T = fitlm(X,T);   
mdl_Q = fitlm(X,Q);   

disp('ROM Models Trained');

% PREDICT USING ROM 
Trom = predict(mdl_T,[P V]);
Qrom = predict(mdl_Q,[P V]);

% PHYSICS POST PROCESS 
A = 0.03*0.03;   % Die area (m^2)
Tair = 25;
Tplate = 30;

qflux = Qrom./A;               
Rth = (Trom - Tplate)./P;     
h = qflux./(Trom - Tair);     

% SAMPLE ROM TEST 
Ptest = 180;
Vtest = 12;

Ttest = predict(mdl_T,[Ptest Vtest]);
Qtest = predict(mdl_Q,[Ptest Vtest]);
qtest = Qtest/A;
Rtest = (Ttest - Tplate)/Ptest;
htest = qtest/(Ttest - Tair);

fprintf('\nROM Prediction at P=180 W , V=12 m/s\n');
fprintf('Tdie = %.2f C\n',Ttest);
fprintf('qflux = %.2f W/m^2\n',qtest);
fprintf('Rth = %.4f K/W\n',Rtest);
fprintf('h = %.2f W/m^2K\n',htest);

% FIGURE 1 : ROM VALIDATION 
Pfit = linspace(min(P),max(P),50);
Vmean = mean(V);

Tfit = predict(mdl_T,[Pfit(:) Vmean*ones(numel(Pfit),1)]);

figure;
scatter(P,T,'filled'); hold on;
plot(Pfit,Tfit,'LineWidth',2);
xlabel('Die Power (W)');
ylabel('Die Temperature (C)');
title('ROM Validation: Die Temperature vs Power');
legend('Icepak CFD','ROM Prediction');
grid on;

saveas(gcf,'ROM_Temperature_Fit.png');

% FIGURE 2 : h vs VELOCITY 
figure;
scatter(V,h,'filled');
xlabel('Velocity (m/s)');
ylabel('Effective h (W/m^2K)');
title('Effective Heat Transfer Coefficient vs Velocity');
grid on;
saveas(gcf,'h_vs_velocity.png');
disp('Plots saved: ROM_Temperature_Fit.png , h_vs_velocity.png');

% Figure 3 : Rth vs Power 

figure;
scatter(P,Rth,'filled');
xlabel('Power (W)');
ylabel('Thermal Resistance (K/W)');
title('Thermal Resistance vs Power');
grid on;

saveas(gcf,'Rth_vs_Power.png');
disp('Rth_vs_Power.png saved');
