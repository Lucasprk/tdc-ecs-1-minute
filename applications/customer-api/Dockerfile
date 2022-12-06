FROM adoptopenjdk/openjdk11:alpine

COPY build/distributions/*boot*.zip /customer-api.zip

RUN unzip -o customer-api && \
  rm -rf *.zip && \
  mv customer-api-* customer-api

ENTRYPOINT [ "/customer-api/bin/customer-api", "-Djava.security.egd=file:/dev/./urandom" ]