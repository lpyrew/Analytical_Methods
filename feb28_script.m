%% Regression
clear
%predictor variables - this is/simulates a matrix of 5 predictor variables
%and 400 observations (participants/trials)
x = randn(400,5);

%true linear "forward" model - this are the true coefficients "q" of the
%following regression model: y = a + q1*x1 + q2*x2 + q3*x3 + q4*x4 + q5*x5
fwdmodel = rand(5,1); %random numbers between 0 and 1

%regression equation in matrix algebra (see slide 12, lecture):
%predictor variable multiplied with the "true coefficients" plusn noise to give the
%criterion variable/regressand
y = x * fwdmodel + randn(400,1);

% this looks for multi-collinearity of the predictor variable
figure;imagesc(corr(x));colorbar;

% plotting predictor variable, regressand and "forward model"
figure;plot(x);
figure;plot(y);
figure;plot(fwdmodel);

% REGSTATS: the matlab function doing all sorts of multiple regression - in fact most
% (parametric) statistical tests you are familiar with can be done with
% this! use the help to explore this a bit more

% start off with a bivariate regression of the 1st predictor var only and
% the criterion y
stats = regstats(y,x(:,1));
% this is the determination coefficient
stats.rsquare
% this is the subfield containing most/all the relevant information
stats.tstat
% the regression coefficients including the intercept as the first element
% (2nd to end are the slopes)
stats.tstat.beta
% the t-values belonging to each regression coefficient (slide 9) and the
% intercept
stats.tstat.t

% now use the first three regression variables
stats = regstats(y,x(:,1:3));

% here all five predictor variables are entered into the regression
stats = regstats(y,x(:,1:5));
%look at all of the stats
stats.tstat.beta

% plot the true forward model and the one inferred from the
% regression-analysis (based on the model-inversion)
figure;plot(fwdmodel,'b'); %the actual coefficients
hold on;plot(stats.tstat.beta(2:end),'r'); %the coefficients inferred from the reg model
legend('true fwd','inferred');
%the overlap between the blue and the red line is another way of showing
%the quality of the fit - if the lines are close together, the regression
%has accurately inferred the true fwd model



 
 
 



%% figures for lecture
x = randn(300,1);
noise = randn(300,1)/2;

% 1st figure - pure correlation plot

y = 0.5*x + noise;
figure;plot(x,y,'.');
set(gca,'FontSize',18);
set(gca,'XLim',[-3,3],'YLim',[-3,3]);
xlabel('x');ylabel('y');
title(['r = ',sprintf('%1.2f',corr(x,y))]);


% 2nd figure - regression line
y = 0.5*x + noise;
figure;plot(x,y,'.');
set(gca,'FontSize',18);
set(gca,'XLim',[-3,3],'YLim',[-3,3]);
xlabel('x');ylabel('y');
mystat = regstats(y,x,'linear');
hold on;plot(x,mystat.yhat,'.r');
title(['r = ',sprintf('%1.2f',corr(x,y)),'; b = ',sprintf('%1.2f',mystat.beta(2))]);

% 3rd figure - steeper slope, same statistical correlation
y = 1*x + 2*noise;
figure;plot(x,y,'.');
set(gca,'FontSize',18);
set(gca,'XLim',[-3,3],'YLim',[-3,3]);
xlabel('x');ylabel('y');
mystat = regstats(y,x,'linear');
hold on;plot(x,mystat.yhat,'.r');
title(['r = ',sprintf('%1.2f',corr(x,y)),'; b = ',sprintf('%1.2f',mystat.beta(2))]);


% 4th figure - shallower slope, stronger statistical correlation
y = 0.3*x + 1/7*noise;
figure;plot(x,y,'.');
set(gca,'FontSize',18);
set(gca,'XLim',[-3,3],'YLim',[-3,3]);
xlabel('x');ylabel('y');
mystat = regstats(y,x,'linear');
hold on;plot(x,mystat.yhat,'.r');
title(['r = ',sprintf('%1.2f',corr(x,y)),'; b = ',sprintf('%1.2f',mystat.beta(2))]);


% 5th figure - two separate regression lines x-> y; y -> x
y = x + 2*noise;
figure;plot(x,y,'.');
set(gca,'FontSize',18);
% set(gca,'XTickLabel',{''},'YTickLabel',{''});
set(gca,'XLim',[-3,3],'YLim',[-3,3]);
xlabel('x');ylabel('y');
title(['r = ',sprintf('%1.2f',corr(x,y))]);
mystat = regstats(y,x,'linear');
hold on;plot(x,mystat.yhat,'.r');
mystat = regstats(x,y,'linear');
hold on;plot(mystat.yhat,y,'.g');


%6th figure - steep and z-normalised
y = 1*x + 2*noise;
xz = zscore(x(:));yz = zscore(y(:));
figure;plot(xz,yz,'.');
set(gca,'FontSize',18);
set(gca,'XLim',[-3,3],'YLim',[-3,3]);
xlabel('x');ylabel('y');
mystat = regstats(yz,xz,'linear');
hold on;plot(xz,mystat.yhat,'.r');
title(['r = ',sprintf('%1.2f',corr(xz,yz)),'; b = ',sprintf('%1.2f',mystat.beta(2))]);


%6th figure - shallow but strong and z-normalised
y = 0.3*x + 1/7*noise;
xz = zscore(x(:));yz = zscore(y(:));
figure;plot(xz,yz,'.');
set(gca,'FontSize',18);
set(gca,'XLim',[-3,3],'YLim',[-3,3]);
xlabel('x');ylabel('y');
mystat = regstats(yz,xz,'linear');
hold on;plot(xz,mystat.yhat,'.r');
title(['r = ',sprintf('%1.2f',corr(xz,yz)),'; b = ',sprintf('%1.2f',mystat.beta(2))]);



%% heteroscedasticity
clear
Ax = randn(200,1);
Bx = randn(200,1)*1.8+5;
Ay = randn(200,1);
By = randn(200,1)*1.9+4;
figure;plot([Ax;Bx],[Ay;By],'.');
set(gca,'FontSize',18);
xlabel('x');ylabel('y');

Ax = randn(200,1);
Bx = randn(200,1);
Ay = Ax + randn(200,1);
By = Bx + randn(200,1);
figure;plot([Ax;Bx],[Ay;By],'.');
set(gca,'FontSize',18);
xlabel('x');ylabel('y');







