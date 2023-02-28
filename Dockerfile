FROM alpine:3.14
RUN apk update && apk upgrade
RUN apk add --no-cache python3 py3-pip gcc python3-dev musl-dev
RUN pip install --upgrade openai


ENTRYPOINT ["tail", "-f", "/dev/null"]