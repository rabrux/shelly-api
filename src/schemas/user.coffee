randomstring = require 'randomstring'
moment       = require 'moment-timezone'

module.exports = ( mongoose, bcrypt, mailing ) ->

  userSchema = new mongoose.Schema
    email :
      type     : String
      required : true
      unique   : true
    password :
      type     : String
      required : true
    username :
      type : String
    key :
      type     : String
      required : true
    status :
      type    : String
      default : 'EMAIL_PENDING_VALIDATE'
    boards : [
      {
        type : mongoose.Schema.Types.ObjectId
        ref  : 'board'
      }
    ]
    createdAt :
      type : Number
      default : moment( new Date() ).format( 'x' )
    updatedAt :
      type    : Number
      default : moment( new Date() ).format( 'x' )
  , { strict : true }

  # Generate user hash key
  userSchema.pre 'validate', ( next ) ->
    user = @
    if @isNew
      user.key = randomstring.generate
        length  : 32
        charset : 'alphanumeric'
      next()
    else
      next()

  # Hash password
  userSchema.pre 'save', ( next ) ->
    user = @
    user.updatedAt = moment( new Date() ).format( 'x' )
    if @isModified( 'password' ) or @isNew
      bcrypt.genSalt 10, ( err, salt ) ->
        if err then return next err
        bcrypt.hash user.password, salt, ( err, hash ) ->
          if err then return next err
          user.password = hash
          next()
    else
      return next()

  # Send validation email
  userSchema.post 'save', ( doc ) ->
    # Load and prepare email template
    user = @
    if user.status == 'EMAIL_PENDING_VALIDATE'
      email = require( '../email-templates/signup' )
        to  : doc.email
        key : doc.key
      # Send email
      if email
        mailing email, ( err, done ) ->
          if err then return console.log err
          console.log 'Success send email'

  userSchema.methods.comparePassword = ( passw, cb ) ->
    bcrypt.compare passw, @password, ( err, isMatch ) ->
      if err then return cb err
      cb null, isMatch

  return mongoose.model 'user', userSchema, 'users'
