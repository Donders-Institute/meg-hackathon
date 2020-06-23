# Continuous integration and event-driven automating

## Background

### Notes while Robert presents Fieldtrip

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

### Notes Phillip on CI (two examples)

how to set up a test for CI: test that fails with old version and pass with new version (?)

ci is biderectional (webhooks not, github "do not reply back" )

Terminology related to this:

- continuous _integration_, ensure that code in a repository remains consistent
- continuous _deployment_, eusure that repository content is translated into a website
- continuous _distribution_, ensure that something (e.g. new iOS app) is distributed ovel all devices

How to execute some piece of code:

- you can run it manually
- you can run it at a specific time of day (cron)
- you can run it based on an event (external)

### Running code on the MPI cluster (using Sun/Oracle/Open Grid Engine)

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

## Automating participant enrollment using an online form and Python code

### Problem definition of the toy example

For a dance organization I am part of (if you are interested: www.swingoutmaastricht.com) we use google forms to gain registration information.

Participants need to feel out the form and fill out some information. Then automatically google updates an excel sheet.

The goal is to automatically e-mail the participants about their registration while performing some checks. Checks that need to be performed:

- Check if the class is full
- Check inbalance in roles (lead or follow), max of 3 difference is allowed

If class is completely full:

- Email that they are not in the class

If class is not full, but too much inbalance:

- Email that they are on a waiting list

If the participant is allowed in the class:

- Email that they are in the class
- Update the google sheets to enroll them in the class. (This is needed for the check at the earlier stage).

Then there are some similar issues regarding checking payments. But this is more of the same...

I have been trying around a bit on <https://github.com/sannetenoever/2019_SOM_AutReg> but it is far from finished.

Documentations on interaction between google docs etc:

- Explanation how to read from the google excel sheet: <https://developers.google.com/sheets/api/samples/reading>
- I used python so far: <https://developers.google.com/sheets/api/quickstart/python>

For me personally.. Anything else would be fine as long as it has these functionalities and I can interact in some language
Where I got stuck:

- I can send emails by running my scripts, however it was not doing something continuous. That is where I need something like an if/then statement that will always run in the background.

### Broadening the scope beyond the toy example

More broadly interesting for our colleagues would be to consider

- participants signing up (for dancing lessons, or for an experiment)
  - some actions need to be triggered (e.g. schedule in the agenda, confirmation email, send information booklet, etc)
- participant cancels
- reseaercher updates some code (more similar to github CI)
  - some computation needs to be restarted)
- new data becomes available (DCCN rdm workflow)
  - some computation needs to be started

Investigate (research) services that we use offer which type of integration:

- github (webhook, integration)
- gitlab.socsci.ru.nl
- Sona
- CastorEDC
- calendar bookings (in the DCCN project database)
- calendar bookings (in google calendar)
- Google forms
- email received on RU Exchange
- email received on Gmail
- a HPC job (or batch) computation completes (gridengine=email, torque=postamble script)

### Some considerations that need later investigation

- What happens if you change the google form, and people continue filling it out?
- How to deal with credentials if the code has to be shared on github or a cloud server.
- Is it possible to create a new google form through a programmatic API?
- Input validation, how to ensure that the data has the right structure
- Where to store data _persistently_

Google docs and sheet has a Python API, see <https://developers.google.com/sheets/api/quickstart/python>. Google email also has a Python API. Both APIs require credentials to be configured.

### Considerations for the architecture

When to execute the automated code?

- When someone fills out the form
- When a row is added to the sheet
- Once in a while

It is also possible to execute off-the-shelf recipes. These are limited in their business logic, but very convenient to set up.

- IFTTT
- Google
- Zapier
- Automate.io

Where to execute your own automated code?

1. On your local desktop/laptop computer (not always on)
2. On a local server, e.g. a Raspberry Pi in the basement or the DCCN compute cluster
3. Execute it on AWS Lambda, or serverless.com, or webtask.io (only small snippet of code)
4. Execute it on Heroku (virtual machine gets started when needed, switches off automatically)
5. Execute it on a general purpose cloud computer (always on, 24x7)

Option 1 does not lend itself for full automation, because your desktop or laptop is not always on.

Option 2 is convenient, because it allows for a similar development as on your own laptop, but it is always on.

Both for option 1 and 2 you have to consider that your home modem/router includes a firewall that restricts external access to internal computers. You can usually set up port forwwarding (for specific services, such as http/80 and ssh/22) or a DMZ (where all incoming trafic is redirected to one computer in your house). Another thing to consider is that with most home internet subscriptions you don't get a fixed IP address; a service like duckdns.org can help solve that.

Option 3, 4, and 5 allow for a service to be implemented that is always available and that processes the automation immediately, regardless of when the participant fills out t he form (e.g. in the middle of the night).

Where to store persistent data?

- Google forms store tyhe data in some sort of internal database; on the administrative view of the form you can look at each submission or get a summary.
- Google sheets can be used to store data.
- With a local computer (laptop or raspberry pi server) you would store the (sensitive) data simply on the local storage
- Virtual machines or Docker images that run in the cloud (like Amazon ECC - Elastic Cloud Computing) typically do not have a persistent storage, but can be extended with persistent storage (like Amazon S3 - Simple Storage Service). This is like having a file server in the cloud.
- [Serverless computing](https://en.wikipedia.org/wiki/Serverless_computing) services (like Amazon Lambda) usually have a small storage area or database (e.g. for storing API keys or other secret information that you would not want to be hard-coded in your Python scripts).

### Architecture

The automation starts when someone enters data on the google form. This triggers a chain of events, indicated by arrows, where the events can be implemented in different ways (e.g. as [webhooks](https://en.wikipedia.org/wiki/Webhook)).

    google form --webhook--> heroku --PythonAPI--> google sheet

    shiny form  --webhook--> heroku --PythonAPI--> google sheet

    google form --webhook--> heroku --webhook--> some other service

    google form --internal--> google sheet --IFTTT--> some other service

    google form --internal--> google sheet --IFTTT-webhook--> heroku --PythonAPI--> google sheet
