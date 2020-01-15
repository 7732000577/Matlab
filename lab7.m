randn('seed', 1); 
T = 96; % 15 minute intervals in a 24 hour period
t = (1:T)'; 
p = exp(-cos((t-15)*2*pi/T)+0.01*randn(T,1)); 
u = 2*exp(-0.6*cos((t+40)*pi/T) -0.7*cos(t*4*pi/T)+0.01*randn(T,1));
%plot(t/4, p); 
%hold on
%plot(t/4,u,'r');
Q = [0:30:150];
C = 3;
D = 3;

ans = zeros(length(Q));

for j=1:length(Q)
    cvx_begin
    variable c(T,1)
    variable q(T,1)
    minimize(p'*(u+c));
    subject to
       % c >= -D; 
        %c <= C;
       % q >=0 ;
       % q <= Q;
        
        for i=1:T
            u(i,1) + c(i,1) >= 0;
            c(i,1) >= -D;
            c(i,1) <= C;
            q(i,1) >= 0;
            q(i,1) <= Q(j);
        end
        
        for i=1:T-1
            q(i+1,1) == q(i,1) + c(i,1);
        end
        
        q(1,1) == q(T,1) + c(T,1);
        
        
cvx_end

ans(j) = p'*(u+c);
end 

plot(Q, ans, 'bo-');
hold on

C= 1;
D =1;


ans1 = zeros(length(Q));

for j=1:length(Q)
    cvx_begin
    variable c(T,1)
    variable q(T,1)
    minimize(p'*(u+c));
    subject to
       % c >= -D; 
        %c <= C;
       % q >=0 ;
       % q <= Q;
        
        for i=1:T
            u(i,1) + c(i,1) >= 0;
            c(i,1) >= -D;
            c(i,1) <= C;
            q(i,1) >= 0;
            q(i,1) <= Q(j);
        end
        
        for i=1:T-1
            q(i+1,1) == q(i,1) + c(i,1);
        end
        
        q(1,1) == q(T,1) + c(T,1);
        
        
cvx_end

ans1(j) = p'*(u+c);
end 

plot(Q, ans1, 'go-')


%plot(t/4, c, 'g');
%plot(t/4, q,'b')

%legend( 'u', 'c' ,'q');