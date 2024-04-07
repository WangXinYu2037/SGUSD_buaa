% 该函数将 k 映射到距离其最近的UAV n
% 输入k, N。随后返回 n
function [delta_k] = findUAV(user, PN_Now)
tmp = repmat(user, length(PN_Now), 1);

tmp = PN_Now - tmp;

result = sum(tmp .* tmp, 2);

[~, delta_k] = min(result);

