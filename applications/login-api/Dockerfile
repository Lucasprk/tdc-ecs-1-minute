FROM adoptopenjdk/openjdk11:alpine

COPY build/distributions/*boot*.zip /login-api.zip

RUN unzip -o login-api && \
  rm -rf *.zip && \
  mv login-api-* login-api

ENTRYPOINT [ "/login-api/bin/login-api", "-Djava.security.egd=file:/dev/./urandom" ]