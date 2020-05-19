# Interoperability between Python, MATLAB, R, etc.

Sanne asked the question _"I often switch during my analysis between different programs, such as Python, MATLAB, and R. How can I automate this and make easier analysis scripts that are easier to develop, run and maintain?"_

# Outline

- Simple: using wrappers
  - Quick and dirty: use the system() call
  - Intermediate: using glue code or API bindings
- Sophisticated: use an external execution environment

# Using wrappers

It is common for larger projects (or analysis pipelines) to have complex dependencies. A strategy to deal with them is to implement then in a modular fashion in which a distinction is made between high- and low-level code. See e.g. http://www.fieldtriptoolbox.org/development/module/. The distinction is more complex, since there is also even higher level code, or even lower level code. Think of the code being organized in layers, and that you can encapsulate low level code in a convenient wrapper.

This is for example used in FieldTrip for the forward computations using the external OpenMEEG software:

1. fieldtrip/ft_prepare_headmodel
2. fieldtrip/forward/ft_headmodel_openmeeg
3. fieldtrip/external/om_assemble
4. linux command line executables

or using the external SIMBIO software

1. fieldtrip/ft_prepare_headmodel
2. fieldtrip/forward/ft_headmodel_simbio
3. fieldtrip/external/simbio (mex files)

# Use the system() call

The simplest way to call one piece of software, while you are working in another software is often to use the `system()` call. This is available in Python as [os.system](https://docs.python.org/3/library/os.html#os.system), in MATLAB as the [system](https://nl.mathworks.com/help/matlab/ref/system.html) function, and in R also as [system](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/system).

In all cases the system call executes another program as a command-line application (as in the terminal on Linux and macOS). So if you write the analysis in the other language as a command-line application, you are good to go.

## Making your code separately executable

Imagine that you are doing your analysis using software A (where A can be either Python, MATLAB or R) and you want to execute an analysis step in software B. You can use a `system()` call to execute a command line application.

Using the [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) syntax you can make scripts in each of the languages directly executable.

# Making Python scripts executable

Your Python script `test.py` would start with

```bash
#!/usr/bin/env python

import argparse
from glob import glob
import numpy as np

# here comes your Python code that deals with
# 1. the command-line options and the input files
# 2. performs the computations
# 3. writes the results to the STDOUT output or (better) to an output file

```

# Making MATLAB scripts executable

Your MATLAB script `test.m` cannot start with `#!/usr/bin/env matlab`, since the MATLAB interpreter does not understand the `#` as a commented out line and would give an error. Also, the Instead you could use some helper code like this

```bash
#!/usr/bin/env matlab_runner.sh

% here comes your MATLAB code that deals with
% 1. the command-line options and the input files
% 2. performs the computations
% 3. writes the results to the STDOUT output or (better) to an output file

```

Where `matlab_runner.sh` would be a BASH script that strips the first line from the m-file and that in principle executes `matlab -r "strippedfile`. Furthermore, you should not run the stripped file just like that: if it contains an error MATLAB would halt but would not close and exit properly. So on top of this, you need another MATLAB code runner script with a `try-catch` to ensure that MATLAB always exits properly. Furthermore, you might want to set your path and present working directory in that MATLAB runner function.

TODO: share the `matlab_runner.sh` and `matlab_runner.m` files.

## Exchanging parameters and data between your code

TODO : explain input/output files


# Using glue code (or bindings)

In many programming (or data analysis) environments it is possible to execute code that is implemented in other programming languages. For example

- Python has an [API](https://docs.python.org/3/c-api/index.html) that allows programmers to extend it with C/C++ code
- MATLAB has [MEX files](https://nl.mathworks.com/help/matlab/call-mex-file-functions.html?s_tid=CRUX_lftnav) for C/C++ and Fortran code
- MATLAB can access existing [Java classes](https://nl.mathworks.com/help/matlab/using-java-libraries-in-matlab.html?s_tid=CRUX_lftnav)
- MATLAB can also execute functions and objects in [Python](https://nl.mathworks.com/help/matlab/call-python-libraries.html?s_tid=CRUX_lftnav)


# Using an execution environment

- GNU Make and [Makefiles](https://en.wikipedia.org/wiki/Makefile)
- nipype
- psom
- [LONI](http://pipeline.loni.usc.edu)
- [Taverna](https://taverna.incubator.apache.org)
- Galaxy
