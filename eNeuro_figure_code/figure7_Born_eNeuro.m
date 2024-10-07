% figure7_Born_eNeuro.m
%
% Originally, this was a function:
% coinTossStatistics: simulates coin tosses and calculates runs and
% switches
%
% [maxRuns, nTransitions] = coinTossStatistics(nTosses,nSims,pFlag)
%
% e.g. [maxRuns, nTransitions] = coinTossStatistics(100,2000,1);
%
% Inputs:
% - nTosses: # of tosses to simulate in each trial (default = 100)
% - nSims: # of trials to simulate (default = 2000)
% - pFlag: 1 = plot results (default)
%
% Outputs:
% - maxRuns: length of the maximum run in each trial
% - nTransitions: # of switches (H-to-T or vice versa) in each trial
%
% from Gelman & Nolan, Teaching Statistics (A Bag of Tricks), 8.3.2, Real
% vs. fake coin flips. pp. 119-121
% 
% Tests students' intuition about random sequences
% Idea is to divide class in half and have one group generate a sequence of
% 0s and 1s by actually tossing a coin 100 times and the other to come up with their
% own random sequence of 0s and 1s without using a coin or a rng.
%
% RTB wrote it, 10 September 2017, about to go searching for Memphre
% Adapted for eNeuro piece on confirmation bias (figure 10) 9/23/2024

% simulate 50 coin tosses (panel A):
cStr = 'HT';
y = datasample(cStr,50);
display(y)

% panel B:
pFlag = 1;
nSims = 2000;
nTosses = 100;

% random sequences of 0s and 1s
allTosses = round(rand(nTosses,nSims));

allTransitions = abs(diff(allTosses));
nTransitions = sum(allTransitions);

% This works for a vector, but 'find' will not work along colums.
% maxRuns = max(diff(find(allTransitions)));
maxRuns = zeros(1,nSims);
maxRunLength = 10;
binCtrs = 1:maxRunLength;
cumRunCounts = zeros(1,maxRunLength);
for k = 1:nSims
    allRuns = diff(find(allTransitions(:,k)));
    runCounts = hist(allRuns,binCtrs);
    cumRunCounts = cumRunCounts + runCounts;
    maxRuns(k) = max(allRuns);
end

if pFlag
    % jitter each variable randomly over [-0.25 to +0.25]
    xJitter = ((rand(size(nTransitions)) - 0.5)/2) + nTransitions;
    yJitter = ((rand(size(maxRuns)) - 0.5)/2) + maxRuns;
    %figure, plot(xJitter,yJitter,'k.');
    figure
    scatterhist(xJitter,yJitter,'Kernel','on','Location','Northwest',...
        'Direction','out','Marker','.');
    hold on
    hp = plot(median(nTransitions),median(maxRuns),'rs','LineWidth',2,'MarkerSize',10);
    xlabel('Number of switches');
    ylabel('Length of longest run');
    tStr = sprintf('%d simulations of %d coin tosses',nSims,nTosses);
    title(tStr);
    legend('Individual sims','Median');
    
    figure
    h1=bar(binCtrs,cumRunCounts ./ sum(cumRunCounts));
    hold on
    xlabel('Run length'); ylabel('Probability');
    title('Distribution of runs of heads');
%     Note that we are looking at the probability of getting z heads before
%     we get one tail, which is the negative binomial distribution with a
%     parameter of one. In our case, a run of 'one' corresponds to a 'z' of
%     zero. This special case of nbinpdf is the geometric distribution:
%     pGeom = p * (1-p)^(k-1), where p = 0.5 and k is the run length.
    yVals = nbinpdf(binCtrs-1,1,0.5);
    h2=plot(binCtrs,yVals,'ro-','MarkerFaceColor','r');
    
    legend([h1,h2],{'Empirical','Geometric'});
    
end

