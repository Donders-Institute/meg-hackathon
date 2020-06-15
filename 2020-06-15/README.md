# Continuous integration and event-driven automating 

## Notes while Robert presents Fieldtrip

<https://github.com/fieldtrip/fieldtrip/tree/master/test>

<http://www.fieldtriptoolbox.org/development/testing/>

test scripts in fieldtrip are an example for continuous integration (integration of multiple functions)

different examples of testing at different levels (no errors, one specific reference output, on expected precise output)

Unit vs. integration test in meme format: <https://twitter.com/withzombies/status/829716565834752000>

fieldtrip is ci time-dependent and not commit-dependent

for the fieldtrip wepage it is ci commit-dependent: fetch commit from github and then modify the website

cron job: schedule your tests
for fieldtrip webpage they use webhooks (post when something happened)

travis ci for the "fieldtrip playground" (advanced version of webhook)

## Notes Phillip on CI (two examples)

how to set up a test for CI: test that fails with old version and pass with new version (?)

ci is biderectional (webhooks not, github "do not reply back" )

Terminology related to this:

-   continuous _integration_, ensure that code in a repository remains consistent
-   continuous _deployment_, eusure that repository content is translated into a website
-   continuous _distribution_, ensure that something (e.g. new iOS app) is distributed ovel all devices

How to execute some piece of code:

-   you can run it manually
-   you can run it at a specific time of day (cron)
-   you can run it based on an event (external)

## Problem definition of toy example CI using Google forms:

For a dance organization I am part of (if you are interested: www.swingoutmaastricht.com) we use google forms to gain registration information.

Participants need to feel out the form and fill out some information. Then automatically google updates an excel sheet.

The goal is to automatically e-mail the participants about their registration while performing some checks. Checks that need to be performed:

-   Check if the class is full
-   Check inbalance in roles (lead or follow), max of 3 difference is allowed

If class is completely full:

-   Email that they are not in the class

If class is not full, but too much inbalance:

-   Email that they are on a waiting list

If the participant is allowed in the class:

-   Email that they are in the class
-   Update the google sheets to enroll them in the class. (This is needed for the check at the earlier stage).

Then there are some similar issues regarding checking payments. But this is more of the same...

I have been trying around a bit on <https://github.com/sannetenoever/2019_SOM_AutReg> but it is far from finished.

Documentations on interaction between google docs etc:

-   Explanation how to read from the google excel sheet: <https://developers.google.com/sheets/api/samples/reading>
-   I used python so far: <https://developers.google.com/sheets/api/quickstart/python>

For me personally.. Anything else would be fine as long as it has these functionalities and I can interact in some language
Where I got stuck:

-   I can send emails by running my scripts, however it was not doing something continuous. That is where I need something like an if/then statement that will always run in the background.


## Broadening the scope beyond the toy example 

More broadly interesting for our colleagues would be to consider

-   participants signing up (for dancing lessons, or for an experiment)
    -   some actions need to be triggered (e.g. schedule in the agenda, confirmation email, send information booklet, etc)
-   participant cancels
-   reseaercher updates some code (more similar to github CI)
    -   some computation needs to be restarted)
-   new data becomes available (DCCN rdm workflow)
    -   some computation needs to be started

Investigate (research) services that we use offer which type of integration:

-   github (webhook, integration)
-   gitlab.socsci.ru.nl
-   Sona
-   CastorEDC
-   calendar bookings (in the DCCN project database)
-   calendar bookings (in google calendar)
-   Google forms
-   email received on RU Exchange
-   email received on Gmail
-   a HPC job (or batch) computation completes (gridengine=email, torque=postamble script)

Grid engine example:

    #!/bin/sh
    #$ -N sub002-preproc
    #$ -cwd
    #$ -q multi.q
    #$ -p 0
    #$ -S /bin/bash
    #$ -M name@mpi.nl
    #$ -m beas
    #$ -o gridoutput/$JOB_NAME-$JOB_ID.out
    #$ -e griderrors/$JOB_NAME-$JOB_ID.err
    conda activate mne-v0.18
    python preproc.py sub002
