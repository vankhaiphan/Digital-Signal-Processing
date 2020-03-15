function [new_signal] = MedianFilter(y,N) % Tin hieu vao y, do dai khung loc la N. Ket qua tra ve [new_signal].
    a = y; % khoi tao gia tri tin hieu a. 
    M = length(a); % M la do dai cua tin hieu a. 
    tmp = ceil((N - 1) / 2); % tmp la so phan tu can them vao dau va cuoi tin hieu a
    M1 = M + N - 1; % so phan tu cua mang moi
    b = 1 : M1; % tao truc thoi gian cho mang b co do dai M1
    d = 1 : M; % tao truc thoi gian cho mang d co do dai M
    % Tao mang b
    for i = 1 : tmp % vong lap chay tu 1 den tmp de them tmp phan tu 0
        b(i) = 0;  
    end
    
    for i = tmp + 1 : tmp + M % vong lap chay tu tmp+1 den tmp+M
        b(i) = a(i - tmp);    % tao ra mang b co cac gia tri theo mang a
    end

    for i = M + tmp + 1 : M1 % vong lap chay tu tmp+M den M1 de them tmp phan tu 0 vao mang b
        b(i) = 0;            
    end

    tmp2 = 1; % gan gia tri tmp2 ban dau la 1
    tmp1 = (N - 1) / 2 + 1; % gia tri can lay sau khi sap xep

    for i = 1 : M % vong lap chay tu 1 den M
        ptu = 0;  % gan gia tri ptu ban dau la 0
        for j = tmp2 : tmp2 + N - 1 % vong lap chay tu tmp2 den tmp2+N-1 
            ptu = ptu + 1;  % dem so luong ptu
        end
        c = 1 : ptu; % tao truc thoi gian cho mang c
        ptu = 0;     % gan gia tri ptu ban dau la 0
        for j = tmp2 : tmp2 + N - 1 % vong lap chay tu tmp2 den tmp2+N-1 
            ptu = ptu + 1; % tang gia tri ptu len 1
            c(ptu) = b(j); % gan gia tri phtu tai c bang gia tri cua b tai j
        end
   
        tmp2 = tmp2 +1;  % tang gia tri tmp2 len 1 don vi.
        c = sort(c);     % sap xep mang c theo thu tu tang dan
        d(i) = c (tmp1); % ket qua tai vi tri i la gia tri tai vi tri tmp1 cua mang c.
    end

    new_signal = d;      % Gan ket qua tra ve bang gia tri cua mang d da tao d??c
end