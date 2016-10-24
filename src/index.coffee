# Prototypes
require './prototypes/Array'
# / Prototypes

# Required packages
express    = require 'express'
app        = express()
bodyParser = require 'body-parser'
morgan     = require 'morgan'
mongoose   = require 'mongoose'
passport   = require 'passport'
config     = require './conf/server.json'
port       = process.env.PORT or config.port
jwt        = require 'jwt-simple'
bcrypt     = require 'bcrypt'
logger     = require 'winston'
mailing    = require './lib/email'
# / Required packages

# Schemas
schemas    =
  User    : require('./schemas/user')( mongoose, bcrypt, mailing )
  Board   : require('./schemas/board')( mongoose )
  Todo    : require('./schemas/todo')( mongoose )
  Note    : require('./schemas/note')( mongoose )
  History : require('./schemas/history')( mongoose, mailing )

# Logger config
logger.remove logger.transports.Console
logger.add logger.transports.Console,
  colorize: true
  timestamp: true

# Get our request parameters
app.use bodyParser.urlencoded( { extended: false } )
app.use bodyParser.json()

# Coords
app.use (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  res.header 'Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS'
  next()

# Log to console
app.use morgan( 'dev' )

# Passport package
app.use passport.initialize()

app.get '/', ( req, res ) ->
  res.send "Hello from api"

# Connect to database
mongoose.connect config.database

require( './conf/passport' )( passport )

# Hooks
require( './hooks/getAuthorization' )( app, config, schemas, jwt )

# Router
router = express.Router()
require( './routes/system/index' )( router, config, schemas, jwt, mailing )
require( './routes/board/index' )( router, schemas )

app.use '/', router

app.listen port

logger.info "Magic happends on #{ port }"
