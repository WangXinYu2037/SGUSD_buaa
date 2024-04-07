function [isCollided] = checkCollision(PM_Now, PN_Now)

isCollided = 0;

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

% 先矩阵检查相等，然后查看是否[1 1]是检查结果的成员
tmp = intersect(PM_Now, PN_Now, 'rows');

if ~isempty(tmp)
    isCollided = 1;
    return
end


