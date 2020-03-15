function F0_RMSE = RMSE(F0,lengthF0,F0_thucong)
nF0_Real = 0;
for i = 1 : lengthF0
    if (F0(i)~= 0)
        nF0_Real = nF0_Real + 1;
        F0_Real(nF0_Real) = F0(i);
    end
end

F0_RMSE = 0;
for i = 1 : nF0_Real
    F0_RMSE = F0_RMSE + (F0_thucong - F0_Real(i))^2;
end
F0_RMSE = F0_RMSE / nF0_Real;
F0_RMSE = sqrt(F0_RMSE);