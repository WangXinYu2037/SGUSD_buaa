% 这里的PM,PN代表所有无人机的坐标
% alpha 和 beta代表无人机移动
function [PM_Now, PN_Now] = changePosition(PM_Now, PN_Now, alpha, beta)
% 对行动进行编码
% 0->(0,0); 1->(0, 10); 2->(10,0); 3 ->(0, -10); 4->(-10,0)
M = length(PM_Now);
N = length(PN_Now);

for m = 1: M
    if alpha(m) == 0
        PM_Now(m, :) = PM_Now(m, :) + [0 0];
    elseif alpha(m) == 1
        PM_Now(m, :) = PM_Now(m, :) + [0 1];
    elseif alpha(m) == 2
        PM_Now(m, :) = PM_Now(m, :) + [1 0];
    elseif alpha(m) == 3
        PM_Now(m, :) = PM_Now(m, :) + [0 -1];
    elseif alpha(m) == 4
        PM_Now(m, :) = PM_Now(m, :) + [-1 0];
    end
end

for n = 1:N
    if beta(n) == 0
        PN_Now(n, :) = PN_Now(n, :) + [0 0];
    elseif beta(n) == 1
        PN_Now(n, :) = PN_Now(n, :) + [0 1];
    elseif beta(n) == 2
        PN_Now(n, :) = PN_Now(n, :) + [1 0];
    elseif beta(n) == 3
        PN_Now(n, :) = PN_Now(n, :) + [0 -1];
    elseif beta(n) == 4
        PN_Now(n, :) = PN_Now(n, :) + [-1 0];
    end
end


% 这里的PM,PN代表所有无人机的坐标
% alpha 和 beta代表无人机移动
function [PM_Now] = changePositionPM(PM_Now, alpha)
% 对行动进行编码
% 0->(0,0); 1->(0, 10); 2->(10,0); 3 ->(0, -10); 4->(-10,0)
M = length(PM_Now);
for m = 1: M
    if alpha(m) == 0
        PM_Now(m, :) = PM_Now(m, :) + [0 0];
    elseif alpha(m) == 1
        PM_Now(m, :) = PM_Now(m, :) + [0 1];
    elseif alpha(m) == 2
        PM_Now(m, :) = PM_Now(m, :) + [1 0];
    elseif alpha(m) == 3
        PM_Now(m, :) = PM_Now(m, :) + [0 -1];
    elseif alpha(m) == 4
        PM_Now(m, :) = PM_Now(m, :) + [-1 0];
    end
end

function [PN_Now] = changePositionPN(PN_Now, beta)
% 对行动进行编码
% 0->(0,0); 1->(0, 10); 2->(10,0); 3 ->(0, -10); 4->(-10,0)
N = length(PN_Now);
for n = 1:N
    if beta(n) == 0
        PN_Now(n, :) = PN_Now(n, :) + [0 0];
    elseif beta(n) == 1
        PN_Now(n, :) = PN_Now(n, :) + [0 1];
    elseif beta(n) == 2
        PN_Now(n, :) = PN_Now(n, :) + [1 0];
    elseif beta(n) == 3
        PN_Now(n, :) = PN_Now(n, :) + [0 -1];
    elseif beta(n) == 4
        PN_Now(n, :) = PN_Now(n, :) + [-1 0];
    end
end
