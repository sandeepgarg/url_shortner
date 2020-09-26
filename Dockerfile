FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential curl git nodejs \
    && apt-get clean autoclean \
    && apt-get autoremove -y
RUN apt-get install git -y
RUN mkdir /app
WORKDIR /app
COPY Gemfile.lock /app/Gemfile.lock
COPY . /app
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD bundle exec rails s -p 3000 -b '0.0.0.0'

#### port ##
EXPOSE 3000
