% figure6A_Born_eNeuro.m
%
% generate plot of binomial distribution for assigning 20 mice at random
%
% RTB wrote it, fall 2024, for eNeuro article on confirmation bias

% make a plot of the binomial probabilities of assigning different numbers
% of animals to treatment group (fig. 9A of my article)
y = binopdf(0:20,20,0.5);
bar(0:20,y);
hold on
% now color in the bars corresponding to 8:12
y = binopdf(8:12,20,0.5);
bar(8:12,y);
xlabel('# of subjects in placebo group')
ylabel('probability')

% probability of getting exactly 10 animals in each group:
p10 = binopdf(10,20,0.5);
display(p10)

% What if we'll tolerate some uneveness, say at least 8 animals in each
% group:
p_success = binocdf(12,20,0.5) - binocdf(7,20,0.5);
display(p_success)  % ans. = 0.7368 success rate
% or calculate failures directly
p_fail = binocdf(7,20,0.5) * 2;
display(p_fail)     % ans. = 0.2632 failure rate