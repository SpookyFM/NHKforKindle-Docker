# NHKforKindle-Docker

With the supplied Dockerfile, a Docker container can be created that will run my fork of the "NHK News download" Python script originally by vebaev (https://github.com/vebaev/NHKforKindle).

The container will run the file daily (the frequency can be changed by changing the crontab file.

You must provide SMTP login details as arguments when building using Docker.