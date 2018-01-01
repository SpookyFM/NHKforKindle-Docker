FROM python:3

#Set up the arguments for sendmail.py
ARG SMTP_SERVER
ARG SMTP_PORT=587
ARG SMTP_USER
ARG SMTP_PASSWORD
ARG MAIL_FROM
ARG MAIL_TO

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

# COPY . .

# Get and unpack kindlegen
RUN curl http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz \
  | tar -xz
  
# Get NHKforKindle
RUN git clone https://github.com/SpookyFM/NHKforKindle.git
RUN mv NHKforKindle/* /usr/src/app
RUN chmod +x /usr/src/app/kindle.sh

# Set up the SMTP arguments
RUN sed -i s/"YOUR SMTP SERVER HERE"/${SMTP_SERVER}/g /usr/src/app/sendmail.py
RUN sed -i s/587/${SMTP_PORT}/g /usr/src/app/sendmail.py
RUN sed -i s/"YOUR SMTP USER HERE"/${SMTP_USER}/g /usr/src/app/sendmail.py
RUN sed -i s/"YOUR SMTP PASSWORD HERE"/${SMTP_PASSWORD}/g /usr/src/app/sendmail.py
RUN sed -i s/"SENDER MAIL ADDRESS"/${MAIL_FROM}/g /usr/src/app/sendmail.py
RUN sed -i s/"RECIPIENT MAIL ADDRESS"/${MAIL_TO}/g /usr/src/app/sendmail.py

# Install cron
RUN apt-get update && apt-get install -y cron

# Setup cron
# Add crontab file in the cron directory
ADD crontab /etc/cron.d/nhk-cron
 
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/nhk-cron
 
# Run the command on container startup
#CMD ["cron", "-f"]
CMD /usr/src/app/kindle.sh
