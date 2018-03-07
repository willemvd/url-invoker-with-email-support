# Simple URL invoker and output checker
Docker image that is used to invoke a web service and validate the output

The following (required) environment variables need to be set in order to run everything smoothly:

```properties
INVOKE_URL=<the url to invoke>
OUTPUT=<the expected output text>

# Email settings
ENABLE_ERROR_MAIL=<should an email be send when something goes wrong? other then true will disable this>
ERROR_MAIL_SUBJECT=<subject of the mail, e.g. Failed to run database backup>
SMTP_HOST=<SMTP host e.g. smtp.office365.com>
SMTP_PORT=<SMTP port number, mostly 587 or 25>
SMTP_STARTTLS=<should TLS be used? other then true will disable this>
SMTP_AUTH=<type of auth, login>
SMTP_AUTH_USER=<username to login to the SMTP server>
SMTP_AUTH_PASSWORD=<password for the SMTP user>
SMTP_FROM=<name and email of the sender in the format: Name <full email adres> >
SMTP_TO=<email address to send to, multiple addresses can be used with a comma seperated list>

ALWAYS_EXIT_ZERO=<when true, always return 0 as exit code to prevent failure detection by other scripts (prevent restarts and spam mailing)>
```
