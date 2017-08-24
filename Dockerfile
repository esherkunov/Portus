FROM library/rails:4.2.2
MAINTAINER Steve Shipway <s.shipway@auckland.ac.nz>

ENV RAILS_ENV=production
ENV COMPOSE=1
ENV CATALOG_CRON="5.minutes"

WORKDIR /portus

EXPOSE 3000

ADD . .

COPY Gemfile* ./
RUN bundle install --retry=3

RUN mkdir -p /etc/nginx/conf.d
VOLUME /etc/nginx/conf.d

# Run this command to start it up
ENTRYPOINT ["/bin/bash","/portus/startup.sh"]
# Default arguments to pass to puma
CMD ["-b","tcp://0.0.0.0:3000","-w","3"]
