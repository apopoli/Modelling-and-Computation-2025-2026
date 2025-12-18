clear variables
close all

v0 = 10;
y0 = 0;
g = 9.81;

% settings
dt = 0.1;
t = 0:dt:2.1;

y_ex = y0 + v0*t - g*t.^2/2; % exact solution
plot(t,y_ex) % visualize exact solution

% initialize arrays to store numerical solution
y = zeros(length(t),1);
v = zeros(length(t),1);

% initial conditions
y(1) = y0;
v(1) = v0;

% position array for each method, same initial condition
y_E = y;
y_EC = y;
y_MP = y;

for k=1:length(t)-1
    v(k+1) = v(k) - g*dt;

    % Euler
    y_E(k+1) = y_E(k) + v(k)*dt;

    % Euler-cromer
    y_EC(k+1) = y_EC(k) + v(k+1)*dt;

    % midpoint
    y_MP(k+1) = y_MP(k) + 1/2*(v(k)+v(k+1))*dt;
end

plot(t,y_E,...
    t,y_EC,...
    t,y_MP,...
    t,y_ex,'o','linewidth',1)
yline(0,'label','ground level');
xlabel('t (s)');
ylabel('y (m)');
legend('Euler','Euler-cromer','Midpoint','Exact');
fontsize(16,"points")