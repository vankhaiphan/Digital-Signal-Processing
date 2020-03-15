function y = HammingWindowFunction(y,frame_length)
for i = 1 : length(y)/frame_length
    area = (i-1)*frame_length + 1 : i*frame_length;
    frame = y(area);
        
    HammingWindow = hamming(length(frame),'periodic');
    frame = frame .* HammingWindow;
    y((i-1)*frame_length + 1 : i*frame_length) = frame;   
end
