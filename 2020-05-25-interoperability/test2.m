#!/usr/bin/env bash

MATLAB=/Applications/MATLAB_R2020a.app/bin/matlab

TEMPSCRIPT=$(mktemp ${TMPDIR}matlabXXXXX).m
SCRIPTDIR=$(dirname ${TEMPSCRIPT})
SCRIPTNAME=$(basename ${TEMPSCRIPT} .m)

echo MATLAB=$MATLAB
echo TEMPSCRIPT=$TEMPSCRIPT
echo SCRIPTDIR=$SCRIPTDIR
echo SCRIPTNAME=$SCRIPTNAME

# pass the first 4 command line options as MATLAB string variables
if [ -n $1 ]; then echo arg1 = \'$1\'\; >> ${TEMPSCRIPT}; fi
if [ -n $2 ]; then echo arg2 = \'$2\'\; >> ${TEMPSCRIPT}; fi
if [ -n $3 ]; then echo arg3 = \'$3\'\; >> ${TEMPSCRIPT}; fi
if [ -n $4 ]; then echo arg4 = \'$4\'\; >> ${TEMPSCRIPT}; fi

cat << EOF >> ${TEMPSCRIPT}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB CODE BEGINS

ver('matlab')
plot(randn(10))
pause(5)

% MATLAB CODE ENDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EOF

MATLABCMD=$(printf 'addpath(%s%s%s); %s' "'" "$SCRIPTDIR" "'"  "$SCRIPTNAME")

${MATLAB} -batch "${MATLABCMD}"
