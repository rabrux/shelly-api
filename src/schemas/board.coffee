randomstring = require 'randomstring'
moment       = require 'moment-timezone'

module.exports = ( mongoose ) ->

  boardSchema = new mongoose.Schema
    name :
      type     : String
      required : true
    owner :
      type     : mongoose.Schema.Types.ObjectId
      ref      : 'user'
      required : true
    contributors : [
      {
        type     : mongoose.Schema.Types.ObjectId
        ref      : 'user'
      }
    ]
    tags : [ String ]
    notes : [
      {
        type : mongoose.Schema.Types.ObjectId
        ref  : 'note'
      }
    ]
    color :
      type    : String
      default : 'white'
    history : [
      {
        type : mongoose.Schema.Types.ObjectId
        ref  : 'history'
      }
    ]
    open :
      type    : Boolean
      default : false
    createdAt :
      type : Number
      default : moment( new Date() ).format( 'x' )
    updatedAt :
      type    : Number
      default : moment( new Date() ).format( 'x' )
  , { strict : true }

  # Hash password
  boardSchema.pre 'save', ( next ) ->
    if not @isNew
      @updatedAt = moment( new Date() ).format( 'x' )
    next()

  return mongoose.model 'board', boardSchema, 'boards'
