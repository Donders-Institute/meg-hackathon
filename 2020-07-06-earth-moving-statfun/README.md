# Statistical testing of EEG topographies

Yang, Philip and Robert had a look at the statistical analysis of Yang, who has question whether the spatial topopgraphy of the source-reconstructed EEG power in alpha is different from that in beta. She had already identified the [Earth mover's distance](https://en.wikipedia.org/wiki/Earth_mover%27s_distance) or EMD as statistic of interest.

Under the null-hypothesis the EMD between the alpha and beta distributions would not be different for the observed assignment of the data over the two frequencies, compared to the randomization distribution of the EMD. The EMD can be used to quantify how different the distributions are, so we compute the randomization distribution of the EMD.

## The analysis script

Let's start by simulating some (random) data that resembles the spatial source-level topographies for the alpha and the beta power.

Using the `inside` field we can specify the region opf interest. Normally that is inside the brain, but it can also be inside a region of interest according to some anatomical or functional atlas.

```matlab
% the source positions are the same for all subjects
% take random positions
% pos = randn(100,3);

% take positions on a regular grid
[X, Y, Z] = ndgrid(1:10, 1:11, 1:12);
pos = [X(:) Y(:) Z(:)];
dim = [10 11 12];

% inside can be used to select the ROI
inside = false(prod(dim),1);
inside(1:650) = true;

nsubj = 10;
alpha = {};
beta = {};

% make one data structure per subject, per frequency
% this is according to FT_DATATYPE_SOURCE
for i=1:nsubj
  alpha{i} = [];
  alpha{i}.pos = pos;
  alpha{i}.dim = dim;
  
  alpha{i}.pow = randn(prod(dim),1);
  alpha{i}.powdimord = 'pos';
  alpha{i}.inside = inside;
  
  beta{i} = [];
  beta{i}.pos = pos;
  beta{i}.pow = randn(prod(dim),1)+1; % add a bit difference
  beta{i}.powdimord = 'pos';
  beta{i}.inside = inside;
end
```

The number of subjects is not so large, hence we can take all permutations, rather than taking a Monte-Carlo sampling approach (which would take a random subset).

The EMD is a positive number, hence `cfg.tail=1`.

There is no correction for multiple comparisons needed, since we use a multivariate summary statistic which only returns a single number. Clustering is also multivatiate, but there can be multiple clusters, hence in thath case we usually take the max. So in this case `cfg.correctm='no'` would be fine. However, using the work-around `cfg.correctm='max'` in the script below we get the same statistic, but `ft_sourcestatistics` will also return the (maxium) randomization distribution, which happens to be *the* randomization distribution. You will see that it also computes the distribution of the positive (rightmost) extreme and negative (leftmost) extreme, which in this case are also identical.

```matlab
cfg = [];
cfg.parameter = 'pow';
cfg.ivar = 1;
cfg.uvar = 2;
cfg.design = [
  1 1 1 1 1 1 1 1 1 1  2 2 2 2 2 2 2 2 2 2   % condition=ivar
  1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10  % subject=uvar
  ];
cfg.method = 'montecarlo';
cfg.statistic = 'ft_statfun_emd';
cfg.numrandomization = 'all';
cfg.correctm = 'max';
cfg.tail = 1; % only positive (rightmost) side of distribution

% these are needed for data selection inside the statfun
cfg.pos = pos;
cfg.inside = inside;

% the data in each subject in each condition ends up as a column in the "dat" matrix
stat = ft_sourcestatistics(cfg, alpha{:}, beta{:});

```

## The statfun

This function is called repeatedly: the first time to compute the statistical value (which is either a vector or a single scalar number) for the observed distrubution of the data over the conditions, subsequently for each of the random permutations between the conditions.

Using `keyboard` or the MATLAB debugger you can stop in the code and see what happens. Pay notice to the design matrix, which changes between subsequent calls.

```matlab
function s = ft_statfun_emd(cfg, dat, design)

% FT_STATFUN_EMD
%
% This requires that cfg.pos and cfg.inside are specified

% for massive univariate, this is how the output would look like for a paired t-test
% s.stat = randn(size(dat,1),1);
% besides the "stat" field, you can return other features, which will be passed on to the output

% for multivariate the statistic is a single number, regardless of the dimensions of the data
s.stat = randn(1);

% select the data in the two experimental conditions
alphadata = dat(:, design(cfg.ivar,:)==1);
betadata  = dat(:, design(cfg.ivar,:)==2);

% use cfg.uvar to ensure that the data is matched within units-of-observation (subjects)
alphasubject = design(cfg.ivar,:)==1;
betasubject  = design(cfg.ivar,:)==2;

% ensure subjects are sorted from 1 to N
[alphasubject, order] = sort(alphasubject);
alphadata = alphadata(:, order);
 
% ensure subjects are sorted from 1 to N
[betasubject, order] = sort(betasubject);
betadata = betadata(:, order);

if ~isequal(alphasubject, betasubject)
  error('this is unexpected')
end

% select only the data in the region of interest
pos = cfg.pos(cfg.inside,:);
alphadata = alphadata(cfg.inside, :);
betadata  = betadata(cfg.inside, :);

% FIXME compute the earth-movers-distance and return it
keyboard

```
