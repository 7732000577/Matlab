% data for censored fitting problem.
randn('state',0);

n = 20;  % dimension of x's
M = 25;  % number of non-censored data points
K = 100; % total number of points
c_true = randn(n,1);
X = randn(n,K);
y = X'*c_true + 0.1*(sqrt(n))*randn(K,1);

% Reorder measurements, then censor
[y, sort_ind] = sort(y);
X = X(:,sort_ind);
D = (y(M)+y(M+1))/2;
y = y(1:M);

x = X(1:1:n, 1:1:M );

cvx_begin
    variable C(n,1);
    variable Y(K,1);
    minimize((Y'-C'*X)*(Y'-C'*X)');
    %minimize(sum_square(Y'- C'*X));
    subject to
    for i=M+1: K
        Y(i) > D;
    end 
    for i= 1:M
        Y(i) == y(i);
    end

cvx_end


cvx_begin
    variable c_ls(n,1)
    
    minimize((y' - c_ls'*x )*(y'- c_ls'*x)');
    
    
        
cvx_end

first = norm(c_true - c_ls, 2)/ norm(c_true,2)
second = norm(c_true - C, 2)/ norm(c_true,2)