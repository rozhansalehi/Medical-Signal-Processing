%% Part A
% Loading Data
data = load("ex2data.mat");
EEG = transpose(data.eeg);
INDF = data.indf;
INDD = data.indd;

figure(1)
[avg1_plot, avg2_plot, sync_avg_F, sync_avg_D ] = sync_avg(EEG, INDF,INDD );
