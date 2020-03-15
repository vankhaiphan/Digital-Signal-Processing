function F0_MEAN = MEAN(F0,lengthF0)
nF0_MEAN = 0;
F0_MEAN = 0;
for i = 1 : lengthF0
    if (F0(i)~= 0)
        F0_MEAN = F0_MEAN + F0(i);
        nF0_MEAN = nF0_MEAN + 1;
    end
end
F0_MEAN = F0_MEAN ./ nF0_MEAN;