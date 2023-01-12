function [avg1_plot, avg2_plot, sync_avg_F, sync_avg_D] = sync_avg(EEG, INDF, INDD)

% ----------------ordered stimulations-------------------%
window_F = zeros(length(INDF), 139); % Preallocating sweep matrix for ordered stimulations
DC_F = zeros(length(INDF),1); % Preallocating DC matrix for ordered stimulations 

for i =1:length(INDF)
    window_F(i,:) = EEG(INDF(i)-13 : INDF(i)+125); % floor(-0.05(sec) * 250(sample/sec))=-13
                                                   % floor(0.5(sec) * 250(sample/sec))=125 
                                                   
    DC_F(i) = sum(window_F(i,:))/length(INDF);
    window_F(i,:) =  window_F(i,:)- DC_F(i); % Removing DC value from each sweep
end 

sync_avg_F = mean(window_F,1); % Synchron Averaging of ordered sweeps

subplot(2,1,1); avg1_plot = plot(sync_avg_F);
title('Synchron Average of Ordered Stimulations');
xlabel('Time');
ylabel('Amplitude');
grid on;

% ----------------disordered stimulations-------------------%
window_D = zeros(length(INDD), 139);  % Preallocating sweep matrix for disordered stimulations
DC_D = zeros(length(INDD),1); % Preallocating DC matrix for disordered stimulations 

for j =1:length(INDD)-1
    window_D(j,:) = EEG(INDD(j)-13 : INDD(j)+125);
    DC_D(j) = sum(window_D(j,:))/length(INDD);
    window_D(j,:) = window_D(j,:)- DC_D(j); % Removing DC value from each sweep
end

sync_avg_D = mean(window_D,1);% Synchron Averaging of disordered sweeps

subplot(2,1,2); avg2_plot = plot(sync_avg_D);
title('Synchron Average of Disordered Stimulations');
xlabel('Time');
ylabel('Amplitude');
grid on;

end
