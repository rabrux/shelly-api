# Shelly API

## Description ##

## Prerequisites ##

* Git
* NodeJS
* NPM
* Dev Dependencies
  * CoffeeScript

## Installation and Configuration ##

* Download Source Code
```bash
> git clone https://github.com/rabrux/shelly-api.git
```

* Go to Source Code Directory
```bash
> cd shelly-api
```

* Installing NPM Dependencies
```bash
> npm install
```
*To install dev dependencies (just coffeescript) run command `npm install -g coffee-script` it can be require root privileges*

* Execute API Server
```bash
> npm start
```
*Before execute command `npm start` you need to configure the `server.json` and `email.json` files, those files need to be stored in `src/conf` directory*

### Configuration ###

The configuration files are located on `src/conf` directory.

##### server.json example #####
```json
{
  "port"     : 8080,
  "secret"   : "your_secret_key",
  "database" : "mongodb://<user>:<password>@<host>:<port>/<database>"
}
```

##### email.json example #####
```json
{
  "host"   : "<smtp_host>",
  "port"   : 465,
  "secure" : true,
  "auth"   : {
    "user" : "<username>",
    "pass" : "<your_password>"
  }
}
```

## Todo ##

* Chat

## Last Update ##

Last update October 8, 2016
