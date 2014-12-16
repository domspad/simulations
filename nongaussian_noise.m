%I've coded up a small experiment to basically test the hypothetical linear regression I mentioned above. 
%In the following code, for each of three distributions (normal, uniform, and exponential), 
%I've generated 500 samples (trying to stay around 0 - 1) and computed for each their corresponding y as y(i)=2x(i)+ϵ, 
%where epsilon is normally distributed with mean 0 and var 0.05. 
%Then I fit with linear regression (normal equations) the best fit line for each set of X, y and computed their error. 
%The lines look to be basically equally good fit, regardless of distribution x was drawn from. Also the final training errors are similar. 
%The code can be run from the octave command line:

%% Initialization
clear ; close all; clc

m = 500;

Xnorm = normrnd(0.5,0.25,m,1);
Xuni = unifrnd(0,1,m,1);
Xexp = exprnd(0.25,m,1);

ynorm = 2*Xnorm + normrnd(0,0.05,m,1);
yuni = 2*Xuni + normrnd(0,0.05,m,1);
yexp = 2*Xexp + normrnd(0,0.05,m,1);


Xnorm = [ones(m,1), Xnorm];
Xuni = [ones(m,1), Xuni];
Xexp = [ones(m,1), Xexp];

thetanorm = pinv(Xnorm' * Xnorm) * Xnorm' * ynorm;
thetaexp = pinv(Xexp' * Xexp) * Xexp' * yexp;
thetauni = pinv(Xuni' * Xuni) * Xuni' * yuni;

prednorm = Xnorm * thetanorm;
Jnorm = 1/(2*m) * (prednorm - ynorm)' * (prednorm - ynorm);
preduni = Xuni * thetauni;
Juni = 1/(2*m) * (preduni - yuni)' * (preduni - yuni);
predexp = Xexp * thetaexp;
Jexp = 1/(2*m) * (predexp - yexp)' * (predexp - yexp);

figure; % open a new figure window
plot(Xnorm(:,2),ynorm,'b.','MarkerSize',10);
str = sprintf('For x normally distributed, y = %f + %fx \n J = %f', thetanorm(1), thetanorm(2), Jnorm);
title(str);
hold on;
plot(Xnorm(:,2), Xnorm*thetanorm, '-')
legend('Training data', 'Linear regression')
hold off;

figure; % open a new figure window
plot(Xuni(:,2),yuni,'b.','MarkerSize',10);
str = sprintf('For x uniformly distributed, y = %f + %fx \n J = %f', thetauni(1), thetauni(2), Juni);
title(str);
hold on;
plot(Xuni(:,2), Xuni*thetauni, '-')
legend('Training data', 'Linear regression')
hold off;

figure; % open a new figure window
plot(Xexp(:,2),yexp,'b.','MarkerSize',10);
str = sprintf('For x exponentially distributed, y = %f + %fx \n J = %f', thetaexp(1), thetaexp(2), Jexp);
title(str);
hold on;
plot(Xexp(:,2), Xexp*thetaexp, '-')
legend('Training data', 'Linear regression')
hold off;