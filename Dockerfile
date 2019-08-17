FROM ruby:2.6.3

WORKDIR /blog
COPY . .
RUN bundle install
EXPOSE 4000
CMD jekyll build

