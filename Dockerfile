# Image reference
ARG code_version=latest
FROM alpine:${code_version}

# Additional information
LABEL maintainer="Rodrigo Carvalho <rdgacarvalho@gmail.com>"
LABEL version="1.0.2"
LABEL environment="test"

RUN apk update apk && \
 apk add python3 py3-pip curl wget

RUN pip install Flask jaeger-client

# Ports to be open
EXPOSE 5000

# Copying frontend assets
COPY app /app

ENV FLASK_APP=/app/api.py
ENV FLASK_ENV=production

USER nobody

CMD flask run --host 0.0.0.0 --reload
