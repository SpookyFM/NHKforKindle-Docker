docker build --no-cache -t nhk . ^
--build-arg SMTP_SERVER= ^
--build-arg SMTP_USER= ^
--build-arg SMTP_PASSWORD= ^
--build-arg MAIL_FROM= ^
--build-arg MAIL_TO=