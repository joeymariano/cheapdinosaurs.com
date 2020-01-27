![cheap-dinosaurs](https://www.cheapdinosaurs.com/images/logo.png)

Cheap Dinosaurs
======
**CheapDionsaurs.com**

* Running on Heroku: [cheapdinosaurs.com](https://www.cheapdinosaurs.com)
	- queries the Songkick.com API for Cheap Dinosaurs concerts
	- has an email to database capture system
	- utilizes a redeemable code system for serving music files from our AWS S3 bucket
	- fresh tunes served daily

* copyright Joey Michalina Mariano 2018

# Specs

* Ruby version 2.5.1

* Sinatra Framework
  - Active Model connection to database

* Uses built in net/http Ruby methods for API calls

* Checks private ENV variable for code matches in download system

# Usage

* Install
  - clone / download
  - rake db:create
  - rake db:migrate
  - bundle exec rackup (starts dev server)
