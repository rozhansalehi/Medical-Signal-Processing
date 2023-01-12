%% SNR of sweeps after applying BP FIR filter
% Loading Data
data = load("ex2data.mat");
EEG = transpose(data.eeg);
INDF = data.indf;
INDD = data.indd;

BPF = designfilt('bandpassfir', ...       % Response type
       'FilterOrder',15, ...            % Filter order
       'StopbandFrequency1',0.5, ...    % Frequency constraints
       'PassbandFrequency1',1, ...
       'PassbandFrequency2',20, ...
       'DesignMethod','ls', ...         % Design method ...
       'StopbandFrequency2',21, ...
       'SampleRate',250);               % Sample rate
EEG_BPF_FIR = filtfilt(BPF, EEG);

figure(1)
[~, ~, ~, SNR1] = SNR_func(EEG_BPF_FIR, INDF, 50, 15, 200)

figure(2)
[~, ~, ~, SNR2] = SNR_func(EEG_BPF_FIR, INDF, 100, 15, 200)

figure(3)
[~, ~, ~, SNR3] = SNR_func(EEG_BPF_FIR, INDF, 200, 15, 200)

figure(4)
[~, ~, ~, SNR4] = SNR_func(EEG_BPF_FIR, INDF,  300, 15, 200)

figure(5)
[~, ~, ~, SNR5] = SNR_func(EEG_BPF_FIR, INDF,  400, 15, 200)

figure(6)
[~, ~, ~, SNR6] = SNR_func(EEG_BPF_FIR, INDF,  420, 15, 200)

SNRs = sprintf(['SNR1 = %G,\nSNR2 = %G,' ...
         '\nSNR3 = %G,\nSNR4 = %G,' ...
         ' \nSNR5 = %G,\nSNR6 = %G '], ...
         SNR1,SNR2,SNR3,SNR4, SNR5, SNR6)
