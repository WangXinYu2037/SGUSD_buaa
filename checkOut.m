function [isOut] = checkOut(PM_Now, PN_Now)
% 这里需要声明任务区域
a = 0; b = 100;
c = 0; d = 100; %取[0,100]*[0,100]*[100]的布点区域；

isOut = 0;
M = length(PM_Now);
N = length(PN_Now);

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
