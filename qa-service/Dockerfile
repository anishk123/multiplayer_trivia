# Base image
FROM ruby:3.0.0-alpine

# Install required packages and tools
RUN apk add --no-cache --update build-base nano nodejs=14.16.0-r0 npm postgresql-client postgresql-dev tzdata
# Extra packages 
# sqlite sqlite-dev chromium chromium-chromedriver
RUN npm install -g yarn

# Setup the entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# Command entrypoint
ENTRYPOINT ["entrypoint.sh"]

# Specify that everything will happen inside /project directory
WORKDIR /project
# Verifies that versions of the package dependencies in the current project’s package.json match those in yarn’s lock file.
RUN yarn install --check-files
# We copy these files from our current application to the /project container
COPY Gemfile Gemfile.lock ./
# We install all the dependencies
RUN bundle config set --local path '/project/vendor'
RUN bundle install
# We copy all the files from our current application to the /project container
COPY . /project
# We expose the port
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

