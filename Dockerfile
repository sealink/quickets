FROM jruby:1.7
RUN \
  apt-get update && \
  apt-get -y install cups-pdf cups-bsd && \
  apt-get clean
COPY . /quickets
WORKDIR quickets
ENTRYPOINT ["containers/self/entrypoint"]
