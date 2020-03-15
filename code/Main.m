close all;
clear all;
clc;

[y,Fs] = audioread("I_Khai.wav");
F0_thucong = 128.2051;
% Standardize the signal
max_value = max(abs(y));
y = y/max_value;
t = 1/Fs : 1/Fs : length(y)/Fs ;
y1 = y;
t1 = t;

% Display the signal
subplot(2,1,2);
plot(t,y);
axis([0 length(y)/Fs -1 1]);
title("Signal");
xlabel("Time(s)");
ylabel("Amplitude");

frame_time = 0.03; 
frame_length = Fs*frame_time;
% Hamming Window
y = HammingWindowFunction(y,frame_length);

% Auto Correlation Function
[F0, timeF0, lengthF0]  = AutoCorrelationFunction(y,Fs);

% Median Filter
N = 7;
F0 = MedianFilter(F0,N);

% Display result
subplot(2,1,1);
plot(timeF0,F0,'*');
axis([0 length(y)/Fs 0 400]);
xlabel("Time(s)");
ylabel("Hz");

F0(isnan(F0)) = 0;
F0_MEAN = MEAN(F0,lengthF0);
F0_RMSE = RMSE(F0,lengthF0,F0_thucong);
title(['Time Domain F0 mean = ' num2str(F0_MEAN) ' (Hz) F0 RMSE = ' num2str(F0_RMSE) ' (Hz)']);

figure(2);
% Display the signal
subplot(2,1,2);
plot(t1,y1);
axis([0 length(y)/Fs -1 1]);
title("Signal");
xlabel("Time(s)");
ylabel("Amplitude");

% Auto Find Fundametal Frequency on Frequency Domain Function
[F1, timeF1, lengthF1]  = auto_f_frequency(y,Fs);

% Median Filter
N = 7;
F1 = MedianFilter(F1,N);

% Display result
subplot(2,1,1);
plot(timeF1,F1,'*');
axis([0 length(y)/Fs 0 400]);
xlabel("Time(s)");
ylabel("Hz");

F1(isnan(F1)) = 0;
F1_MEAN = MEAN(F1,lengthF1);
F1_RMSE = RMSE(F1,lengthF1,F0_thucong);
title(['Frequency Domain F0 mean = ' num2str(F1_MEAN) ' (Hz) F0 RMSE = ' num2str(F1_RMSE) ' (Hz)']);
