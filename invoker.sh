#!/bin/sh

set -e

handleFailureExitCode() {
    if [ "x$ALWAYS_EXIT_ZERO" = "xtrue" ]; then
        exit 0
    fi

    # abort
    exit 1
}

handleError() {
    MSG="Failed to invoke url '$INVOKE_URL'"

    echo ${MSG}

    if [ "x$ENABLE_ERROR_MAIL" = "xtrue" ]; then

        OPTS=""
        if [ "x$SMTP_STARTTLS" = "xtrue" ]; then
            OPTS="-S smtp-use-starttls";
        fi

        echo ${MSG} | \
        mailx -v -s "$ERROR_MAIL_SUBJECT" \
        -S smtp="$SMTP_HOST:$SMTP_PORT" \
        ${OPTS} \
        -S smtp-auth=$SMTP_AUTH \
        -S smtp-auth-user="$SMTP_AUTH_USER" \
        -S smtp-auth-password="$SMTP_AUTH_PASSWORD" \
        -r "$SMTP_FROM" \
        $SMTP_TO || handleFailureExitCode
    fi

    handleFailureExitCode
}

echo "Start invoking URL '$INVOKE_URL'"

curl -vo output $INVOKE_URL || handleError

OUTPUT=`cat output`

echo "Expecting '$EXPECTED_OUTPUT'"
echo "Got output '$OUTPUT'"

if [ "x$EXPECTED_OUTPUT" = "x$OUTPUT" ]; then
    echo "Output does match expected value"

    exit 0
else
    echo "Output does not match expected value"

    handleError
fi


