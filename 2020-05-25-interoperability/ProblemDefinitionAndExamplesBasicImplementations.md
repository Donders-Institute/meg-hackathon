# Interoperability between Python, MATLAB, R, etc.

Sanne (me) asked the question: _"I often switch during my analysis between different programs, such as Python, MATLAB, Julia, and R. How can I automate this and make easier analysis scripts that are easier to develop, run and maintain?"_

I have encountered this now several times and will list my experiences here

## Outline
- Reasons to switch between programs/languages
- Examples of some implementations

## Reasons to switch
- Specific toolboxes are only available in different programs/languages
- Coding itself just easier for a specific task in a different language
	- I find statistics more intuitively implemented in R
	- I find the figures nicer in Python/R than MATLAB 

## Examples
### Example 1: Doing statistics in R from MATLAB output

This piece of code is for a project in which I wanted to run linear mixed models in R. I created a separate matrix and variable file in MATLAB and used the R.matlab toolbox to import the data in R.

```r
library(lme4)
library(R.matlab)

# read in the .mat file
Matout = readMat(<location .mat matrix file>)
varnames = readMat(<location .mat file containing variable names>)
summary(Matout)

# create R dataframe
ACCmat <- data.frame(matrix(unlist(Matout), nrow = 17400))
vn <-unlist(varnames)
colnames(ACCmat) <- vn
ACCmat$accuracy <- as.factor(ACCmat$accuracy)
ACCmat$sound <- as.factor(ACCmat$sound)
ACCmat$ass <- as.factor(ACCmat$ass)
ACCmat$block <- as.factor(ACCmat$block)
ACCmat$pp <- as.factor(ACCmat$pp)
str(ACCmat)

# run the statsistics:
ACCmat.nul = glmer(accuracy ~ (1|pp), data=ACCmat, family = binomial(link = "logit"))
ACCmat.mod1 = glmer(accuracy ~ sound + ass + block + sound*ass + sound*block + ass*block + ass*block*sound + (1|pp), data=ACCmat, family = binomial(link = "logit")
```

### Example 2: Running Freesurfer segmentations (windows 10)
This piece of code is for a project in which I used Freesurfer to do segmentations on a windows 10 OS without using a virtual machine. This is now possible on windows 10 using a linux distributor (https://docs.microsoft.com/en-us/windows/wsl/install-win10). 
Not fully happy with as it still requires copy/pasting, but it was too much of a time investment/benefit tradeoff to solve it in the linux distributor via MATLAB.

```matlab

restoredefaultpath();
addpath('\\fieldtrip-20180712');
addpath('\\spm12');

locMRIs = <location MRI files>;

%% read in the pre niftis
mri = ft_read_mri([locMRIs '/pre.nii.gz']);

%% convert to acpc space
cfg           = [];
cfg.method    = 'interactive';
mri_ctf =ft_volumerealign(cfg, mri);
mri_acpc = ft_convert_coordsys(mri_ctf, 'acpc',1);

% save the mri_acpc as a nifti:
cfg           = [];
cfg.filename  = [locMRIs '/MR_acpc'];
cfg.filetype  = 'nifti';
cfg.parameter = 'anatomy';
ft_volumewrite(cfg, mri_acpc);

%% freesurfer of the data
% only for linux, now installed on windows 10 via linux distribution
% this will take like 10 hours!!
fshome     = <location freesurfer, something like: 'C:/Users/<user>/AppData/Local/Packages/CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc/LocalState/rootfs/usr/local/freesurfer/'>;
subdir     = <location subjects in freesurfer, something like: 'C:/Users/<user>/AppData/Local/Packages/CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc/LocalState/rootfs/usr/local/freesurfer/subjects/<subname>>;
mkdir(subdir);
mrfile     = [subdir '/MR_acpc.nii'];
% copy acpc file to subdir
copyfile([locMRIs ppnames{p} '/MR_acpc.nii'], mrfile)

% now run Ubuntu Linux Distributor and type the following:
%['export SUBJECTS_DIR=/usr/local/freesurfer/subjects/<subname>]
%['cd $SUBJECTS_DIR']
%['recon-all -i MR_acpc.nii -s FS -all']

% if error permission denied run the following:
% ['sudo chmod -R 777 /usr/local/freesurfer/subjects/<subname>']
% ['sudo chmod -R 777 /usr/local/freesurfer/subjects/']
```

### Example 3: Running Java using MATLAB system() call
I wanted to extract semantic relatedness using the disco toolbox (http://www.linguatools.de/disco/) which runs under java. Below an example for a single word. In the original script I looped through many words.

```matlab
% change java heap space to 4068: On the Home tab, in the Environment section, click  Preferences. Select MATLAB > General > Java Heap Memory.
% and you need the disco-3.0.0-all installed + german word space

locf = <location of the disco files>;

word1 = 'Hund'; 
word2 = 'Katze';

[status cmdout] = system(sprintf(['java -jar ' locf 'disco-3.0.0-all.jar ' locf 'de-general-20150421-lm-word2vec-sim.denseMatrix -s ' word1 ' ' word2 ' COSINE']));
similarity = str2double(cmdout);
```

## Evaluation
- If I want to script in a language using system is very tedious and the scripts become difficult to read.
- But it is very useful when I need a single functionality from a toolbox.
- Often the input still needs to be converted for different toolboxes (this is even so within a language)
- In an ideal future I have one script, but can easily switch between scripting languages.

