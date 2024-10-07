% figure5_Born_eNeuro.m
%
% plot results from:
% Rosenthal, R. and Lawson, R., 1964. A longitudinal study of the effects
% of experimenter bias on the operant learning of laboratory rats. Journal
% of psychiatric research.
%
% RTB wrote it, 16 January 2024, snow-globe snow day!
% Limited to Table 2 data and revised for eNeuro paper, 07 October 2024

% Table 2, p. 67
x = categorical({'A', 'B', 'C', 'D', 'E'});
x_lab_group = reordercats(x, {'A', 'B', 'C', 'D', 'E'});
bright_mean_rank2 = [4.3, 4.9, 5.1, 3.7, 4.1];
dull_mean_rank2 = [5.3, 6.5, 5.8, 4.6, 6.0];

figure;
bar(x_lab_group, [bright_mean_rank2; dull_mean_rank2]);

xlabel('Lab group');
ylabel('Normalized mean rank');
legend({'"Bright"', '"Dull"'});
%title('Rosenthal & Lawson 1964, Table 2');
