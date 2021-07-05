function [pvalues] = CAROM(regulators, genelist, features, featurenames, feature_rows)

% genelist is a list of gene identifiers in the model (yids for yeast and
% bnumbers for ecoli). 
% regulators is a binary matrix with each column denoting each regulator.
% The rows correspond to each gene in the genelist variable. 
% For the example data, column 1 contains targets inferred from
% transcriptomics, 2 is proteomics, 3 - acetylomics and 4 phosphoproteomics. IF some genes are not regulated, the corresponding
% columns can be all 0 in the regulator matrix. 
% features - a matrix of various reaction properties - precomputed for
% ecoli and yeast. corrsponding column names are in featuresnames. the
% rownames are in feature_rows
% EXAMPLE: 
% load yeast_carom_inputs1 regulators genelist features featurenames feature_rows
% [pvalues] = CAROM(regulators, genelist, features, featurenames, feature_rows);
% this reproduces figures in the manuscript for yeast. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [ix pos] = ismember(feature_rows, genelist);
yrxntable_geneko_biom_val = features(ix,:);
genelist1 = genelist(pos(ix));
 yrxntableR = regulators(pos(ix),:);


yrxntable1 = yrxntable_geneko_biom_val(yrxntableR(:,1) ~= 0,:); % these are all the ones that are trans regulated. 
yrxntable1g = ones(sum(yrxntableR(:,1) ~= 0),1);

yrxntable11 = yrxntable_geneko_biom_val(yrxntableR(:,2) ~= 0,:); % these are prot regulated.  
yrxntable11g = ones(sum(yrxntableR(:,2) ~= 0),1)*2;

yrxntable111 = yrxntable_geneko_biom_val(yrxntableR(:,3) ~= 0,:); % acet
yrxntable111g = ones(sum(yrxntableR(:,3) ~= 0),1)*3;

yrxntable1111 = yrxntable_geneko_biom_val(yrxntableR(:,4) ~= 0,:); % phos
yrxntable1111g = ones(sum(yrxntableR(:,4) ~= 0),1)*4;

ix = (yrxntableR(:,4) == 0) & (yrxntableR(:,3) == 0)  & (yrxntableR(:,2) == 0) & (yrxntableR(:,1) == 0) ; sum(ix) %1231

yrxntable11111 = yrxntable_geneko_biom_val(ix,:); % 
yrxntable11111g = ones(sum(ix),1)*5;

yrxntable2 = [yrxntable1;yrxntable11;yrxntable111;yrxntable1111;yrxntable11111; ];
yrxntable2g = [yrxntable1g;yrxntable11g;yrxntable111g;yrxntable1111g;yrxntable11111g; ];

% plot data for each category and report pvalues. 
%% 1. Impact of gene knockout on biomass production, ATP synthesis, and viability across 87 different conditions 

figure;
implist = [1:3]; %first three are related to gene/reaction impact on fitness
 for i = 1:length(implist)
 subplot(1,3,i)
    ii = implist(i);
 pv = anova1(yrxntable2(:,ii),yrxntable2g,'off');
pvalues(ii) = pv;
  boxplot(yrxntable2(:,ii),yrxntable2g,'orientation','vertical','symbol','');

grid('on')
    set(gca,'fontsize',11)
set(findobj(gca,'Type','text'),'FontSize',11)
set(findobj(gca,'Type','line'),'linewidth',1.2)%,'color','k')
 set(gca,'TickDir', 'out')
 set(gca,'xticklabel',{'Tr','Pr','Ac','Ph','Un'})
    str2 = strcat(regexprep(featurenames(ii),'_',' '), {' p = '}, regexprep(num2str(pv,'%10.2e'),'e',' x 10^{'),'}');
 title([str2],'FontSize',11)
     ylim([prctile(yrxntable2(:,ii),0.05),  prctile(yrxntable2(:,ii),99.95)])
 end
suptitle('Distribution based on gene KO on growth/ATP') 
 set(gcf, 'Position', get(0, 'Screensize'));

 

%% 2. The total pathways each reaction is involved in, its Degree, Closeness and PageRank

figure;
implist = [4:8]; %first three are related to gene/reaction impact on fitness
 for i = 1:length(implist)
 subplot(2,3,i)
    ii = implist(i);
 pv = anova1(yrxntable2(:,ii),yrxntable2g,'off');
pvalues(ii) = pv;
  boxplot(yrxntable2(:,ii),yrxntable2g,'orientation','vertical','symbol','');

grid('on')
    set(gca,'fontsize',11)
set(findobj(gca,'Type','text'),'FontSize',11)
set(findobj(gca,'Type','line'),'linewidth',1.2)%,'color','k')
 set(gca,'TickDir', 'out')
 set(gca,'xticklabel',{'Tr','Pr','Ac','Ph','Un'})
    str2 = strcat(regexprep(featurenames(ii),'_',' '), {' p = '}, regexprep(num2str(pv,'%10.2e'),'e',' x 10^{'),'}');

 title([str2],'FontSize',11)
     ylim([prctile(yrxntable2(:,ii),0.05),  prctile(yrxntable2(:,ii),99.95)])
 end
 
 suptitle('Distribution based on reaction connectivity') 
set(gcf, 'Position', get(0, 'Screensize'));

%% 3. Flux through the network measured through Flux Variability analysis and PFBA, reaction reversibility 

figure;
implist = [9:12]; %first three are related to gene/reaction impact on fitness
 for i = 1:length(implist)
 subplot(2,2,i)
    ii = implist(i);
 pv = anova1(yrxntable2(:,ii),yrxntable2g,'off');
pvalues(ii) = pv;
  boxplot(yrxntable2(:,ii),yrxntable2g,'orientation','vertical','symbol','');

grid('on')
    set(gca,'fontsize',11)
set(findobj(gca,'Type','text'),'FontSize',11)
set(findobj(gca,'Type','line'),'linewidth',1.2)%,'color','k')
 set(gca,'TickDir', 'out')
 set(gca,'xticklabel',{'Tr','Pr','Ac','Ph','Un'})
    str2 = strcat(regexprep(featurenames(ii),'_',' '), {' p = '}, regexprep(num2str(pv,'%10.2e'),'e',' x 10^{'),'}');
 title([str2],'FontSize',11)
     ylim([prctile(yrxntable2(:,ii),0.05),  prctile(yrxntable2(:,ii),99.95)])
 end
  suptitle('Distribution based on reaction flux') 
set(gcf, 'Position', get(0, 'Screensize'));


  %% 4. Enzyme molecular weight and catalytic activity 

figure;
implist = [13:14]; %first three are related to gene/reaction impact on fitness
 for i = 1:length(implist)
 subplot(1,2,i)
    ii = implist(i);
 pv = anova1(yrxntable2(:,ii),yrxntable2g,'off');
pvalues(ii) = pv;
  boxplot(yrxntable2(:,ii),yrxntable2g,'orientation','vertical','symbol','');

grid('on')
    set(gca,'fontsize',11)
set(findobj(gca,'Type','text'),'FontSize',11)
set(findobj(gca,'Type','line'),'linewidth',1.2)%,'color','k')
 set(gca,'TickDir', 'out')
 set(gca,'xticklabel',{'Tr','Pr','Ac','Ph','Un'})
    str2 = strcat(regexprep(featurenames(ii),'_',' '), {' p = '}, regexprep(num2str(pv,'%10.2e'),'e',' x 10^{'),'}');
 title([str2],'FontSize',11)
     ylim([prctile(yrxntable2(:,ii),0.05),  prctile(yrxntable2(:,ii),99.95)])
 end
  suptitle('Distribution based on enzyme properties') 
set(gcf, 'Position', get(0, 'Screensize'));

  
 end