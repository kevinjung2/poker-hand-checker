# README

## Takes input of card names to build a poker hand and returns that hands rank.

### To run on your local machine:

in the terminal first clone the repo

```git clone git@github.com:kevinjung2/poker-hand-checker.git```

next install dependencies

```bundle install```

setup the database

```rails db:migrate```
```rails db:seed```

run the server

```rails s```

then navigate to localhost:3000 in your browser

### TROUBLESHOOTING NOTICE

if you get a webpack error after all these steps are complete run the command:

```bundle exec rake webpacker:install```

then restart the server and refresh your localhost window.

card names are reffered to by their number (or first letter on their name if a facecard/ace) and the first letter of their suit.
