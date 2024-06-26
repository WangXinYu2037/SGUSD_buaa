function [isOut] = checkOut(PM_Now, PN_Now, alpha, beta)
% 这里需要声明任务区域
a = 0; b = 50;
c = 0; d = 50; %取[0,100]*[0,100]*[100]的布点区域；

isOut = 0;
M = length(PM_Now);
N = length(PN_Now);

% 计算未来的情况
[PM_Now, PN_Now] = changePosition(PM_Now, PN_Now, alpha, beta);

for m = 1:M
    if PM_Now(m, 1) < a || PM_Now(m, 1) > b
        isOut = 1;
        return
    elseif PM_Now(m, 2) < c || PM_Now(m, 2) > d
        isOut = 1;
        return
    end
end

for n = 1:N
    if PN_Now(n, 1) < a || PN_Now(n, 1) > b
        isOut = 1;
        return
    elseif PN_Now(n, 2) < c || PN_Now(n, 2) > d
        isOut = 1;
        return
    end
end
