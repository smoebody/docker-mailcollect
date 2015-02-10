# docker-dev-mailcollect

## What is this image intended for?

This Image can be used to create a container which offers a smtp service to other docker containers and collects all mails in one place.
This service is not intented to send mails to their receipients. Its a service that helps developers to build mail-sending applications
without mockups on application layer.

All sent mails appear in one developer inbox as they would appear in a real receipients inbox.

## How to use this image

To run the Container do

    docker run --name mailcollect -d -p 127.0.0.1:143:143 smoebody/mailcollect

this starts the container named _mailcollect_ and listens on localhost port 143 for your mail client.

To access all mails you have to set up your mail client to connect to the imap service the container provides:

* server: `localhost` or `127.0.0.1`
* port: `143` (the default imap port)
* username: `dev`
* password: `dev`

All settings to send mails are regardless since this container only delivers mail. If you have to fill in something, 
feel free to make them up and hope your mail client does not verify them.

## Alternative access via Maildir

Since the service is configured to save the emails in _Maildir_ format you can easily access this folder via dockers volume sharing. 
Therefore you have to run the container with the parameter `-v /path/to/local/Maildir:/home/dev/Maildir` to bind your hosts folder which
is accessable by the developer to the _Maildir_ folder of the containers user all mail is sent to.

After that you can configure your mail client which obviously needs to be cabable to access mails in _Maildir_ format to access that folder.
Therefore you can omit the port redirection parameter which binds the imap port to your local interface.

## Usage in other containers

In order to receive all mails at one place that mails have to be sent in the first place, right? So how does that work?

The container - once up - has to be linked into the container that shall use its smtp service. to do so you have to run your mail sending container
with the parameter 

    `--link mailcollect:smtp`

this tells docker to expose the - already up and running - container _mailcollect_ to the container you are intended to start.
once up you can reach the smtp service on 

* host _smtp_, the alias you specified as above
* port _25_, the default smtp port

you can now configure your application to use this as smtp

neither is there a login required, nor are other security related mechanism at work. this service is not to be meant secure.

there is at least one image that makes use of this image for development purposes: `useltmann/dev-dotdeb` which is a 
development testing environment for php/mysql applications.

