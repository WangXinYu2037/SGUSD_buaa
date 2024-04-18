clear all;
%%% Part1 %%%
Lambda = 234;  % Lambda:poisson(Lambda)
u = unifrnd(0,1);
pointNums = 0;
while u >= exp(-Lambda)%判定条件
    u = u * unifrnd(0,1);
    pointNums = pointNums+1;
end 
%获取点个数

%%% Part2 %%%
a = 0; b = 100;
c = 0; d = 100; %取[0,100]*[0,100]的布点区域；
Nall = pointNums;
A = zeros(pointNums, 1);
B = zeros(pointNums, 1);
while pointNums > 0         %scatter in the [0,100]*[0,100]
    pointNums = pointNums - 1;
    u1 = unifrnd(0,1);
    A(Nall-pointNums) = (b-a)*u1;
    u2 = unifrnd(0,1);
    B(Nall-pointNums) = (d-c)*u2;
    figure(1)
    %u3 = unifrnd(0,1);
    %plot3(A(Nall-M),B(Nall-M),C(Nall-M),'r^');
    %hold on;
    %plot(A(Nall-pointNums),B(Nall-pointNums),'b.')
end
scatter(A, B, 'b', 'filled');
grid on;