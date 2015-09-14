## Initial Setup

Take a look at `config/application.yml.example` to see which kinds of API keys you'd need to have. Then, duplicate it into the file `config/application.yml` so the app will be able to use its settings.

## Docker and Docker Compose

This project uses Docker and Docker Compose to isolate the development dependencies and generally make the application self-contained and easy to start hacking on.

See:

* https://docs.docker.com/installation/ubuntulinux/
* https://docs.docker.com/compose/install/

Follow instructions on how to add yourself to the `docker` user group `usermod -a -G docker ${USER}`

You might need to logout and log back in; alternatively you can run `exec su -l $USER` or `newgrp docker`

Prepare the database using

* `docker-compose run web rake db:create db:schema:load` for the dev db
* `docker-compose run -e RAILS_ENV=test web rake db:create db:schema:load` for the test db

You can then run `docker-compose build` to build the image and `docker-compose run --service-ports web` to run the application (this is to enable the interactive debugging from guard-pry)

## Guard

This project uses guard, guard-rspec and guard-rails to make TDD easier. If you're not running Docker Compose, you can manually start the guard watcher.

In your terminal:

    $ guard

and it will show something like the following:

    11:41:13 - INFO - Guard::RSpec is running
    11:41:13 - INFO - [Guard::Rails] will start the default web server on port 3000 in development.
    11:41:13 - INFO - Starting Rails...

    => Booting WEBrick
    => Rails 4.2.4 application starting in development on http://localhost:3000
    => Run `rails server -h` for more startup options
    => Ctrl-C to shutdown server
    [2015-08-27 11:41:15] INFO  WEBrick 1.3.1
    [2015-08-27 11:41:15] INFO  ruby 2.1.5 (2014-11-13) [x86_64-linux]
    [2015-08-27 11:41:15] INFO  WEBrick::HTTPServer#start: pid=17599 port=3000
    11:41:16 - INFO - Rails started, pid 17599

    11:41:16 - INFO - Guard is now watching at '/home/user/prelauncher'

it will automatically start a rails development server you can visit at ` http://localhost:3000` as well as watch your files for changes and automatically run tests against them.
