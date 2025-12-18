clear variables
close all

% units: AU, years, solar masses
G = 4*pi^2;
M_sun = 1;

% time grid
T  = 1;
dt = T/50;
t  = 0:dt:T;
N  = length(t);

% acceleration (component-wise)
d = @(x,y) sqrt(x^2 + y^2);
a = @(r,d) -G*M_sun*r/d^3;   % component-wise acceleration

% EULER
x_E = zeros(N,1); y_E = zeros(N,1);
vx  = zeros(N,1); vy  = zeros(N,1);

x_E(1) = 0; y_E(1) = 1;
vx(1)  = -sqrt(G*M_sun/y_E(1));
vy(1)  = 0;

for k = 1:N-1
    r  = d(x_E(k), y_E(k));
    vx(k+1) = vx(k) + dt*a(x_E(k), r);
    vy(k+1) = vy(k) + dt*a(y_E(k), r);

    x_E(k+1) = x_E(k) + vx(k)*dt;
    y_E(k+1) = y_E(k) + vy(k)*dt;
end

% EULER CROMER
x_EC = zeros(N,1); y_EC = zeros(N,1);
vx   = zeros(N,1); vy   = zeros(N,1);

x_EC(1) = 0; y_EC(1) = 1;
vx(1)   = -sqrt(G*M_sun/y_EC(1));
vy(1)   = 0;

for k = 1:N-1
    r  = d(x_EC(k), y_EC(k));
    vx(k+1) = vx(k) + dt*a(x_EC(k), r);
    vy(k+1) = vy(k) + dt*a(y_EC(k), r);

    x_EC(k+1) = x_EC(k) + vx(k+1)*dt;
    y_EC(k+1) = y_EC(k) + vy(k+1)*dt;
end

% MIDPOINT
x_MP = zeros(N,1); y_MP = zeros(N,1);
vx   = zeros(N,1); vy   = zeros(N,1);

x_MP(1) = 0; y_MP(1) = 1;
vx(1)   = -sqrt(G*M_sun/y_MP(1));
vy(1)   = 0;

for k = 1:N-1
    r  = d(x_MP(k), y_MP(k));
    vx(k+1) = vx(k) + dt*a(x_MP(k), r);
    vy(k+1) = vy(k) + dt*a(y_MP(k), r);

    x_MP(k+1) = x_MP(k) + 0.5*(vx(k)+vx(k+1))*dt;
    y_MP(k+1) = y_MP(k) + 0.5*(vy(k)+vy(k+1))*dt;
end

% LEAPFROG
x_LF = zeros(N,1);
y_LF = zeros(N,1);

x_LF(1) = 0;
y_LF(1) = 1;

vx_half = -sqrt(G*M_sun/y_LF(1));
vy_half = 0;

% rewind velocity by half step
r0 = d(x_LF(1), y_LF(1));
vx_half = vx_half - 0.5*dt*a(x_LF(1), r0);
vy_half = vy_half - 0.5*dt*a(y_LF(1), r0);

for k = 1:N-1

    % acceleration at current position
    r = d(x_LF(k), y_LF(k));
    ax = a(x_LF(k), r);
    ay = a(y_LF(k), r);

    % kick: advance velocity to next half-step
    vx_half = vx_half + ax*dt;
    vy_half = vy_half + ay*dt;

    % drift: advance position to next full step
    x_LF(k+1) = x_LF(k) + vx_half*dt;
    y_LF(k+1) = y_LF(k) + vy_half*dt;
end

plot(0,0,'y*','LineWidth',10)
hold on
plot(x_E,y_E, x_EC,y_EC, x_MP,y_MP, x_LF, y_LF,'LineWidth',1)

% exact circular orbit
th = linspace(0,2*pi,200);
plot(cos(th),sin(th),'k--')

hold off
legend('Sun','Euler','Euler–Cromer','Midpoint','Leapfrog','Exact','NumColumns',2)
axis equal
xlim([-2 2]); ylim([-2 2])
xlabel('x (AU)'); ylabel('y (AU)')
grid on
