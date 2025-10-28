% define a polynomial function
% f(x) = 2x^4 + 3x^3 + x^2 + 0.5x + 3
% df/dx = 8x^3 + 9x^2 + 2x + 0.5

% using anonymous functions (or function handles)
f = @(x) 2*x.^4 + 3*x.^3 + x.^2 + 0.5*x + 3;
df_dx_e = @(x) 8*x.^3 + 9*x.^2 + 2*x + 0.5;

x = linspace(0,2,100);

plot(x,f(x),x,df_dx_e(x),'LineWidth',2)
xlabel("x"); ylabel("f(x) || df/dx(x)")
fontsize(16,"points")
legend("f(x)","df/dx - exact")

% plots with two y-axes
figure
yyaxis left % whatever follows will be plotted in the left y-axis
plot(x,f(x),'LineWidth',2);
xlabel("x"); ylabel("f(x)")
yyaxis right % whatever follows will be plotted in the right y-axis
plot(x,df_dx_e(x),'LineWidth',2)
ylabel("df/dx")
fontsize(16,"points")

%% compare the exact and finite difference derivatives in a single point
clc 

x = 1;
dx = 1E-3;

df_dx_FW = @(x,dx) (f(x+dx)-f(x))./dx; % forward finite difference approx. of df/dx
df_dx_BW = @(x,dx) (f(x)-f(x-dx))./dx; % backward finite difference approx. of df/dx
df_dx_C = @(x,dx) (f(x+dx)-f(x-dx))./(2*dx); % centered finite difference approx. of df/dx

format long

disp(df_dx_e(x))
disp(df_dx_FW(x,dx))
disp(df_dx_BW(x,dx))
disp(df_dx_C(x,dx)) % truncation error still expected since df/dx third-order polynomial, df_dx_C is second-order accurate

%% test the accuracy of FD formulas for different values of dx

dx = logspace(-1,-16,16);

T = table(df_dx_e(x)*ones(16,1),...
    dx',df_dx_FW(x,dx)',...
    df_dx_BW(x,dx)',...
    df_dx_C(x,dx)',...
    'VariableNames',["exact","dx","FW","BW","C"]);
disp(T)

% plot the errors (using arrays)

dx = logspace(-1,-16,250);
err = abs([df_dx_e(x)-df_dx_FW(x,dx)' df_dx_e(x)-df_dx_BW(x,dx)' df_dx_e(x)-df_dx_C(x,dx)']); % absolute error

figure
loglog(dx,err,'LineWidth',2) % logarithmic plot
xlabel('dx');
ylabel('absolute error of the finite difference formula')
legend('FW','BW','C')
fontsize(16,"points")