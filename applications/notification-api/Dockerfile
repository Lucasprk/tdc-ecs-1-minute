FROM adoptopenjdk/openjdk11:alpine

COPY build/distributions/*boot*.zip /notification-api.zip

RUN unzip -o notification-api && \
  rm -rf *.zip && \
  mv notification-api-* notification-api

ENTRYPOINT [ "/notification-api/bin/notification-api", "-Djava.security.egd=file:/dev/./urandom" ]