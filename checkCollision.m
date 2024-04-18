function [isCollided] = checkCollision(PM_Now, PN_Now, alpha, beta)

isCollided = 0;

[PM_Now, PN_Now] = changePosition(PM_Now, PN_Now, alpha, beta);

collision1 = length(PN_Now) - length(unique(PN_Now, 'rows'));

%fprintf("collison1:%d;\n", collision1);
if collision1 ~= 0
    isCollided = 1;
    return
end
collision2 = length(PM_Now) - length(unique(PM_Now, 'rows'));
%fprintf("collison1:%d; collision2: %d;\n", collision1, collision2);
if collision2 ~= 0
    isCollided = 1;
    return
end

% 对行向量取交集，然后看是否是空集
tmp = intersect(PM_Now, PN_Now, 'rows');

if ~isempty(tmp)
    isCollided = 1;
    return
end


