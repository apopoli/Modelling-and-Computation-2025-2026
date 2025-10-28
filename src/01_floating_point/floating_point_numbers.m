clc % clear output
clear variables % clears all variables from workspace

% lab with floating point numbers

% printing variables
% realmax % ctrl(cmd) + r to comment a line
% disp(realmax)
fprintf("The largest real number is %g \n",realmax) % example of formatted output

fprintf("The smallest real number is %g \n",realmin) % smallest real number

% format %g prints the number using scientific notation if needed
fprintf("The machine precision is %g \n",eps)

% if we add a small number to a larger one...
x = 1E-6;
y = 1+x; % 1.000001

% how to plot more digits
fprintf("y = 1 + x = %.10g \n",y) % specifying the number of digits in the format of fprintf

format long % plot numbers with full number of available digits
disp(y)

% try to sum a very small number to 1
x = 1E-16; % smaller then eps
y = 1+x; % 1.0000000...1
disp(y)

% check if MATLAB is internally able to recognize that x+1 is not equal to
% one...
fprintf("Is x+1 equal to 1? \n %i \n",isequal(y,1)) %i is for integers

% numerical cancellation
a = 1E8 - 1E-5; % thirteen orders of magnitude of difference
b = 1E8;
disp(a-b) % expected -1E-5
fprintf("a - b: expected = -1E-5 \t MATLAB = %g \n",a-b);
fprintf("relative error: %g \n",(-1E-5 - (a-b))/(-1E-5));

% visualization
% define a function that "should" return 1 for every value of x
clear variables
x = logspace(-16,-6,1E3);
y = @(x) ((1+x)-1)./x;

semilogx(x,y(x),x,ones(1E3,1),'LineWidth',2)
% legend('y = ((1+x)-1)/x - numerical','y = ((1+x)-1)/x - exact')
legend('$y = \frac{(1+x)-1}{x}$ - numerical','$y = \frac{(1+x)-1}{x}$ - exact','interpreter','latex')
xlabel('$x$','Interpreter','latex')
ylabel('$y(x)$','Interpreter','latex')
fontsize(16,"points")

