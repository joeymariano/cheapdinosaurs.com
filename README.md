![cheap-dinosaurs](https://www.cheapdinosaurs.com/images/logo.png)

Cheap Dinosaurs
======
**CheapDionsaurs.com** queries Songkick.com Cheap Dinosaurs concerts, has an email to database capture system, and a redeemable code system for serving music files from AWS.

* Running on Heroku: [show-finder.com](https://www.show-finder.com)

* copyright Joey Michalina Mariano 2018

# Specs

* Ruby version 2.5.1rak

* Sinatra Framework
  - Active Model conncection to database

* Uses built in net/http Ruby methods for API calls

* Checks ENV variable for code matches in download system

# Usage

* Install
  - clone / download
  - rake db:create
  - rake db:migrate
  - bundle exec rackup (starts dev server)
