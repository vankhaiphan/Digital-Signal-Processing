
function [F0, timeF, lengthF0] = auto_f_frequency(y,Fs)

frame_time = 0.03;
frame_length = frame_time .* Fs; % Do dai mau tinh hieu

for i = 1:length(y)/frame_length
    area = (i-1) * frame_length + 1:i*frame_length;
    frame = y(area); %ham cua so chu nhat
    
    n = 2048; %so diem lay mau
    y_fft=abs(fft(frame,n)); %Ham FFT
    y_fft=y_fft(1:round((length(y_fft)/2))); %lay phan pho thuc
    y_fft=10.*log(y_fft); %dB
    F=0:Fs/n:Fs/2-1; %Vecto tan so;
    
    [pks,locs]=findpeaks(y_fft,'MinPeakDistance',75/(Fs/n),'MinPeakProminence',10,'MinPeakHeight',5); %tim tat ca cac dinh tren pho
    length(locs)
    %[pks,locs]=findpeaks(y_fft);
    m = 3;
    if (length(locs)<=m)
        F0(i)= NaN;
    else
        locs = locs(1:m+1); %Lay m mau dau tien
        for j=1:m
            locs(j)=(locs(j+1)-locs(j))*(Fs/n); %tinh khoang cach giua cac dinh
        end
        locs=locs(1:m);
        if (mean(locs)<=400)
            F0(i) = mean(locs); %tinh trung binh cac khoang cach => F0  
        else
            F0(i) = NaN;
        end
    end
    timeF(i) = i*frame_time;
end
lengthF0=length(F0);
end



% %Ve pho tin hieu
% n = 1024; %so diem lay mau
% y_fft=abs(fft(y,n));
% y_fft=y_fft(1:round((length(y_fft)/2))); %lay phan pho thuc
% y_fft=10.*log(y_fft);
% F=0:Fs/n:Fs/2-1; %Vecto tan so;
% subplot(3,1,3);
% plot(F, y_fft);
% title('Spectrum of Signal');
% xlabel('Hz');
% ylabel('dB');

