randomstring = require 'randomstring'
moment       = require 'moment-timezone'

module.exports = ( mongoose, mailing ) ->

  historySchema = new mongoose.Schema
    message :
      type     : String
      required : true
    performedBy :
      type : mongoose.Schema.Types.ObjectId
      ref  : 'user'
    performedAt :
      type : Number
      default : moment( new Date() ).format( 'x' )
  , { strict : true }

  # Hash password
  historySchema.pre 'save', ( next ) ->
    if not @isNew
      @updatedAt = moment( new Date() ).format( 'x' )
    next()

  return mongoose.model 'history', historySchema, 'histories'
