function [X_o_plot, X_e_plot_, X_noise_p, SNR] = SNR_func(EEG, INDF, n, t1, t2)

%calculating sample range
s1 = floor(t1*0.25);
s2 = floor(t2*0.25);

window_F = zeros(n, s2-s1+1); % Preallocating sweep matrix for ordered stimulations
DC_F = zeros(n,1); % Preallocating DC matrix for ordered stimulations 

for i =1:n
    window_F(i,:) = EEG(INDF(i)+s1 : INDF(i)+s2);
    DC_F(i) = sum(window_F(i,:))/length(INDF); 
    window_F(i,:) =  window_F(i,:)- DC_F(i); % Removing DC value from each sweep
end 

sync_avg_F = mean(window_F,1);
window_F_o = zeros(n/2, s2-s1+1); % Preallocating sweep matrix for ODD ordered stimulations
window_F_e = zeros(n/2, s2-s1+1); % Preallocating sweep matrix for EVEN ordered stimulations

% for even vlues of n
for i = 1:n/2
    window_F_o(i,:) = window_F(2*i-1,:);
    window_F_e(i,:) = window_F(2*i,:);
end

X_o = mean(window_F_o, 1); % ODD sweeps averaging
X_e = mean(window_F_e, 1); % EVEN sweeps averaging
X_noise = X_o - X_e; % Residual Noise

SNR = var(sync_avg_F)/var(X_noise);

subplot(3,1,1); X_o_plot = plot(X_o,'color','g');
title(sprintf(['number of sweeps=%G, time range=(%G,%G)\nAverage of Odd Sweeps'],n,t1,t2));
xlabel('Time'); ylabel('Amplitude'); grid on
subplot(3,1,2); X_e_plot_ = plot(X_e,'color','c');title('Average of Even Sweeps');
xlabel('Time'); ylabel('Amplitude'); grid on
subplot(3,1,3); X_noise_p = plot(X_noise,'color','m');title('Average of Residual Noise');
xlabel('Time'); ylabel('Amplitude'); grid on

end
