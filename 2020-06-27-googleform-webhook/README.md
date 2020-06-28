# Using a Google form and a webhook to execute a script on the DCCN compute cluster

In the previous weeks we explored how to automate processes, e.g. using webhooks. The specific example we worked on was to automate the process of participant enrollment for [dancing classes](http://www.swingoutmaastricht.com).

The following outlines one specific sol;ution to automate the processing of a google form, using the DCCN compute cluster. Conceptually it consists of multiple parts

1. the google form
2. a piece of javascript code that calls the webhook
3. the DCCN HPC webhook server that receives the HTTP post request
4. a piece of Bash or Python code that is executed upon each call to the webhook

```
Google Form -> Google Apps Script -> HPC webhook server -> Python code
```

## Make a google form

Sign in to yout account and go to <http://forms.google.com/>

Create a new form, name it "Participant enrollment".

## Register a webhook on the DCCN HPC cluster

The following makes use of the <https://github.com/Donders-Institute/hpc-webhook> and requires that you have an account on the DCCN compute cluster.

Log in on the DCCN cluster and make a script with the name `googleform.sh` and the following content

```bash
#!/bin/bash

# send an email with the date and time of execution
(date ; hostname) | mail -s webhook yourname@example.com
```

Make the script executable:

    chmod +x googleform.sh

Register the script as a webhook

    hpcutil webhook create googleform.sh

This should print something like

    INFO[0000] webhook created successfully with URL: https://hpc-webhook.dccn.nl:443/webhook/xxxx-xxxx-xxxx-xxxx

You can check it with

    hpcutil webhook list

Note the URL that is printed, it is important. If you POST a http request on it, your script will be executed. It is very important that you keep this long URL secret, since otherwise others would be able to execute code on the compute cluster on your behalf.

You can test the processing of the webhook on the command line:

    curl -X POST https://hpc-webhook.dccn.nl:443/webhook/xxxx-xxxx-xxxx-xxxx

Curl should print `Payload delivered successfully` and you should soon receive an email (you might have to check your spam folder). It shows when and on which compute node the job was executed. You can also see the details how the job was queued on teh Torque compute cluster with:

    qstat -an1

which shows you all recently scheduled and executed jobs on the cluster.

In the `$HOME/.webhook/xxxx-xxxx-xxxx-xxxx` directory you can find the STDOUT and STDERR log files of the job execution. Furthermore, it contains the `script` file that points to your script, and the `payload` file with the data that was posted. So far it is still empty, but we'll change that later.

## Attach a piece of javascript to your form that calls the webhook

Go to the upper right corner and select in the menu (three vertical dots) the script editor. Paste the following javascript code:

```javascript
function onFormSubmit(e) {
  var data = {
    form: {
      id: e.source.getId(),
      title: e.source.getTitle() ? e.source.getTitle() : "Untitled Form",
      is_private: e.source.requiresLogin(),
      is_published: e.source.isAcceptingResponses(),
    },
    response: {
      id: e.response.getId(),
      timestamp: e.response.getTimestamp(),
      payload: e.response
        .getItemResponses()
        .map(function (y) {
          return {
            h: y.getItem().getTitle(),
            k: y.getResponse(),
          };
        }, this)
        .reduce(function (r, y) {
          r[y.h] = y.k;
          return r;
        }, {}),
    },
  };

  var options = {
    method: "post",
    payload: JSON.stringify(data, null, 2),
    contentType: "application/json; charset=utf-8",
  };

  UrlFetchApp.fetch(
    "https://hpc-webhook.dccn.nl:443/webhook/xxxx-xxxx-xxxx-xxxx",
    options
  );
}
```

Save it and give the project the name "Participant enrollment".

Click in the toolbar on the "Current projects' triggers" button (the stopwatch); this brings you to the Google Apps Script page. Click "Add trigger", choose which function to run (onFormSubmit), select the event type (on form submit) and save it. At that moment the google authentication window will pop up, since you have to grant explicit permission to this script that it is allowed to access the data from the form.

If you now open the form (preferably in an another browser) and submit the form, the javascript code is executed, a HTTP POST request is made to the webhook, and your `googleform.sh` script is queued and executed on the compute cluster.

## Parse and process the content of the payload

For further testing you can extend the previous script a little bit and also have it send the payload by email.

```bash
#!/bin/bash

(date ; hostname ; cat $HOME/.webhook/xxxx-xxxx-xxxx-xxxx/payload ) | mail -s webhook yourname@example.com
```

In your `googleform.sh` you can now implement the logic to parse the JSON content of the `$HOME/.webhook/xxxx-xxxx-xxxx-xxxx/payload` file. Perhaps it is enough to use `grep`, `awk`, etcetera, but you can also implement it using Python, MATLAB, R, Julia or any other processing tool of your choice.

## Final remarks

### Testing the parser on the compute cluster

To implement the script that parses and processes the payload, you don't have to trigger the webhook over and over again. Just trigger it once to get a representative payload file and then implement your script by repeatedly parsing that payload.

### Testing the payload content

For more detailled control over the webhook at the data that gets posted to it, you can use specialized software such as <https://www.postman.com> or an online service like <https://reqbin.com> to craft specific POST messages. This bypasses the google form.

### Testing the webhook delivery

You can use a service like <https://webhook.site> to create a dynamic webhook on the fly, to which you can subsequently send your webhook request. This bypasses the DCCN HPC webhook server.

### Alternatives to the javascript code on Google Apps Script

Instead of the piece of javascript code on the Google Apps Script service, you can also IFTTT to link the Google form to a webhook. In your Google form you have to specify that new entries are automatically added to a google sheet. Then you go to <https://ifttt.com/>, sign up, connect to the [Google sheets](https://ifttt.com/google_sheets) service, and connect to the [Maker webhook](https://ifttt.com/maker_webhooks) service. Subsequently you can make a new applet "If New row added to google sheet, then trigger a webhook call".

Alternatives to IFTTT are [Zapier](https://zapier.com) and [Automate.io](https://automate.io); these all allow you to connect a webhook to your online services (like Google forms and sheets) without any programming.

### Concurrency and queueing

The DCCN webhook server and queueing on the compute cluster all take some time. If a new webhook request comes in prior to the previous being processed, the file payload will be overwritten! Hence you should only use this for events that you don't expect to happen too often. If it is about processing forms: you could add to the form that people will receive a confirmation email that you can send from your script. If people don't get the confirmation, it apparently failed and they will have to fill it out again (or contact you).
