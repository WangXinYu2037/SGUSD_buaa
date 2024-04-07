clear all;
% ---------------- Part 1 声明变量 ----------------------------------
a = 0; b = 100;
c = 0; d = 100; %取[0,100]*[0,100]*[100]的布点区域；
e = 0; f = 100;
omega = [a, b, c, d, e, f]; % mission area

% nums and positions of UAV
N = 5; M = 2;
h = 20; % meter
PN = zeros(N, 2);
PM = zeros(M, 2);
PN_equi = zeros(N, 2);
PM_equi = zeros(M, 2);

% 读取生成服从泊松点过程用户坐标
PK = xlsread("./groundUser");

R = 1; % round
T = 50; % seconds

% -------------------- Part 2 预处理，优化算法速度 ------------------------
% 这里是先获取一些常量，以优化算法运行速度
% 获取malicious UAV的策略集合
AM = zeros(5^M, M);
for m = 0: 5^M - 1
    alpha = zeros(1, M);  % alpha [0~4, 0~4]
    tmp = m;               
    i = M;                  % 下标计数器
    while tmp > 0
        alpha(i) = mod(tmp, 5);
        i = i - 1;
        tmp = floor(tmp / 5);
    end
    AM(m + 1,:) = alpha;
end

% 获取normal UAV的策略集合
A = zeros(5^N, N);
for n = 0: 5^N - 1
    beta = zeros(1, N);   % beta [0~4, 0~4, ..., 0~4]
    tmp = n;                 % mod计算
    i = N;                   % 下标计数器
    while tmp > 0
        beta(i) = mod(tmp, 5);
        i = i - 1;
        tmp = floor(tmp / 5);
    end
    A(n + 1, :) = beta;
end


% --------------------- Part 3 开始进入博弈算法主体，求解均衡 -------------
% 外循环迭代
PN_Now = repmat(PN, 1, 1); % 复制一份
PM_Now = repmat(PM, 1, 1);

%PN_Final = zeros(R, 2);
%PM_Final = zeros(R, 2);
for r = 1:R
%     fprintf("r:%d\n", r);
%     % initialize position 随机化初始位置
%     while 1
%         PN_Now = 100 * rand(N, 2);
%         PM_Now = 100 * rand(M, 2);
%         % check collision 检查碰撞
%         isCollided = checkCollision(PM_Now, PN_Now);
%         %fprintf("isCollided: %d\n", isCollided);
%         if isCollided == 0
%             break
%         end
%     end
    fprintf("初始的无人机状态\n");
    PM_Now = [30.8334   50.3261;
   60.9257   40.3198]
    PN_Now = [  20.2032   15.1912;
   40.8060   95.2782;
   50.8887   52.5274;
    4.1984   37.6248;
   77.8100   63.9239]
   
    % 定义一些用于存储中间值的变量，仿真模拟用
    uT = zeros(T, 1);
    PMT = zeros(T * M, 2);
    PNT = zeros(T * N, 2);
    alphaT = zeros(T , M);
    betaT = zeros(T, N);

    % 系统运行T轮（秒）
    for t = 1:T
        fprintf("t:%d\n", t);
        
        % 存储5^M个效用 和 对应的5^M 个beta
        utilityM = zeros(5^M, 1);
        betaM = zeros(5^M, N);
        for m = 1: 5^M
            alpha = AM(m, :);
            
            % 对于M越界的情况，要特殊处理
            %[PM_Now] = changePositionPM(PM_Now, alpha);
            
            % 5^N个效用 和 beta
            utilityN = zeros(5^N, 1);
            
            for n = 1: 5^N
                %fprintf("进度: %d\n", 5^N * (m - 1) + n);
                beta = A(n, :);
                
                % 得到了alpha和beta，计算payoff
                % 计算效用的同时要检查是否满足约束函数
                
                ut = utilityCompute(PM_Now, PN_Now, alpha, beta, PK);
                utilityN(n) = ut;
                %fprintf("ut: %d\n", ut);
            end
            [utilityMax, pos] = max(utilityN);  % 获取最大的payoff
            beta = A(pos, :);               % 获取对应的最优响应beta
            %fprintf("utilityMax and beta")
            %utilityMax
            %beta
           
            % 存储此 m 对应的最大payoff 和 n
            utilityM(m) = utilityMax;
            betaM(m, :) = beta;
        end
        
        % 最大值中取最小值
        % 获取第t轮运行的Stackelberg Equilibrium point。
        % 也即第t轮的alpha, beta
        [utilityMin, pos] = min(utilityM);
        alpha = AM(pos, :);
        beta = betaM(pos, :);
        % 输出，存储
        fprintf("utilityMin and alpha ,beta\n")
        uT(t) = utilityMin;
        alphaT(t, :) = alpha;
        betaT(t, :) = beta;
        
        % 改变当前UAV的位置
        [PM_Now, PN_Now] = changePosition(PM_Now, PN_Now, alpha, beta);
        PMT((t - 1) * M + 1 : t * M, :) = PM_Now;
        PNT((t - 1) * N + 1: t * N, :) = PN_Now;
    end
    %PM_Final(r, :) = PM_Now;
    %PN_Final(r, :) = PN_Now;
    fprintf("第r = %d轮，最后的无人机状态\n",r);
    PM_Now
    PN_Now
end