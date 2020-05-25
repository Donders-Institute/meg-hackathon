#! /bin/bash
# adapted from https://gist.github.com/dgleich/5805712 to execute a single MATLAB command
# (including a single MATLAB file)
# This version shows additional error output
# set -x # print the next step with expanded variables
matlab -nodisplay -nosplash -nodesktop -r "disp('BEGIN>>'); try, $1  $cmdterm catch me, fprintf(2,getReport(me)); exit(1); end, exit(0)" #| sed -e '1,/^BEGIN>>$/ d'
