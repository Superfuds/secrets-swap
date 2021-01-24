FROM python:3.8-slim

LABEL maintainer="#dev_ops"

RUN pip install awscli
RUN pip install s3keyring

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
