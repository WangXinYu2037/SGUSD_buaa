% 输入是无人机现在的坐标，采取的行动和无人机的高度
% 计算时相关的参数都在此函数中定义
function [ut] = utilityCompute(PM_Now, PN_Now, alpha, beta, PK)

% 获取UAV数量
h = 20; % meter
M = length(alpha); 
N = length(beta);


% 改变位置
[PM_Now, PN_Now] = changePosition(PM_Now, PN_Now, alpha, beta);

% 检查碰撞情况，如果出界，设ut为0
% isCollided = checkCollision(PM_Now, PN_Now);
% if isCollided == 1
%     ut = 0;
%     return
% end

% 检查出界的情况，如果出界，需要直接设置ut为0，来将此情况pass
% isOut = checkOut(PM_Now, PN_Now);
% if isOut == 1
%     ut = 0;
%     return;
% end

% 至少会有一个解，也就是[0 0]
% 需要考虑用户的最低信道容量，暂时先不设定，看看实验结果

% -------------- 接下来正常地计算每个系统的总体表现 ------------------
% 定义常量
fc = 2000; %Hz
Pn = 0.5; % UAV BS的发射功率，瓦
Pm = 0.2; % UAV 干扰者功率，瓦
uNLOS = 23; %dB
uLOS = 3; %dB
c = 300000000; 
b1 = 0.36; b2 = 0.21;
n0 = -170; % dBm/Hz
B = 1000000; %带宽1M Hz
epsilon = 0.1; % 干扰加权


uNLOS = 10 ^(uNLOS / 10);
uLOS = 10 ^ (uLOS / 10);
Ko = (4 * pi * fc / c) ^ 2;




% --------------第一次遍历用户k，和UAV进行匹配，并预处理一些变量-------------

% 存储K个用户对应的无人机序号
K = length(PK);
deltaK = zeros(K, 1);
% 计算UAV n连接的用户总数，时分多址
lambdaN = zeros(N, 1);
for k = 1:K
    % 寻找当前用户的服务者
    user = PK(k, :);
    % 该函数返回一个最近的UAV n坐标
    uav_n = findUAV(user, PN_Now);
    deltaK(k) = uav_n;
    lambdaN(uav_n) = lambdaN(uav_n) + 1; 
end

% --------------第二次遍历用户k，计算Lk，求和得到ut-----------
sigma = n0 * B; % dBm
sigma = (10 ^(sigma / 10)) * 0.001; % 瓦

ut = 0;
% 存储K个用户的效用

for k = 1: K
    user = PK(k, :);    % 用户坐标
    uav_n = deltaK(k);  % 匹配的UAV n
    nPosition = PN_Now(uav_n, :);
    tmp = user - nPosition;
    
    % 正式开始计算接收功率
    dnk2 = h^2 + sum( tmp .^2);
    theta_nk = asin(h / sqrt(dnk2));
    if theta_nk < pi / 12
        PLos = 0;
    else
    PLos = b1 * (180 / pi * theta_nk - 15) ^ b2;
    end
    PNLos = 1 - PLos;
    Pnk = Pn / (Ko * dnk2 * (uNLOS * PLos+ uLOS * PNLos));
    
    % 计算干扰
    
    Ik = 0;
    for m = 1 : M
        mPosition = PM_Now(m, :);
        tmp = user - mPosition;
        dmk2 = h^2 + sum(tmp .^ 2);
        theta_mk = asin(h / sqrt(dmk2));
        if theta_mk < pi/12
            PLos = 0;
        else
            PLos = b1 * (180 / pi * theta_mk - 15) ^ b2;
        end
        PNLos = 1 - PLos;
        Pmk = Pm / (Ko * dmk2 * (uNLOS * PLos+ uLOS * PNLos));
        Ik = Ik + Pmk;
    end
    
    gamma_nk = Pnk / (Ik + sigma ^2);
    Cnk = B * log2(1 + gamma_nk);
    Lk = 10 * Cnk / lambdaN(uav_n); % 时间间隔是10s
    Lk_K(k) = Lk;
    ut = ut + Lk;
end

% 这里单位是bit


