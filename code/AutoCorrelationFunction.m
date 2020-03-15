function [F0, timeF0, lengthF0]  = AutoCorrelationFunction(y,Fs)
frame_time = 0.03; 
frame_length = Fs*frame_time;
lengthF0 = 1;
for i = 1 : length(y)/frame_length
    area = (i-1)*frame_length + 1 : i*frame_length;
    frame_current = y(area);
    max_amplitude = max(frame_current);
    
    % Display Auto Correlation Function
    [r,lags] = xcorr(frame_current,frame_current);
    % r(-i) = r(i) => (-oo;+oo) -> (0;+oo);
    r = r(frame_length : end);
    lags = lags(frame_length : end);
    
    r(find(r < 0)) = 0;
    j = 1;
    for k = 1 : 3
        [value_peak,location_peak] = max(r(1 : end));
        location(j) = location_peak;
        end_of_peak_center = find(r(location(j) + 1:end) == 0 , 1);
        r(1 : location(j) + end_of_peak_center) = 0;
        j = j + 1;
    end
    for j = 1 : 2
        T(j) = location(j+1) - location(j);
    end
    error = 5;
    if (T(1) < T(2) + error) || (T(1) == T(2)) || (T(2) < T(1) + error)
        fundamental_period = abs(T(1))/Fs; 
        fundamental_frequency = 1/fundamental_period;
        if (max_amplitude > 0.05) && (fundamental_frequency < 401) && (fundamental_frequency > 74)
            F0(lengthF0) = fundamental_frequency;
        else
            F0(lengthF0) = NaN;
        end
    else
    end  
    timeF0(lengthF0) = i*frame_time;
    lengthF0 = lengthF0 + 1;
end
lengthF0 = lengthF0 - 1;