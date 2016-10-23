randomstring = require 'randomstring'
moment       = require 'moment-timezone'

module.exports = ( mongoose ) ->

  noteSchema = new mongoose.Schema
    name :
      type     : String
      required : true
    owner :
      type : mongoose.Schema.Types.ObjectId
      ref  : 'user'
    tags : [
      {
        type : mongoose.Schema.Types.ObjectId
        ref  : 'tag'
      }
    ]
    note :
      type     : String
      required : true
    todo : [
      {
        type : mongoose.Schema.Types.ObjectId
        ref  : 'todo'
      }
    ]
    referrals : [
      {
        title : String
        href  : String
      }
    ]
    history : [
      {
        type : mongoose.Schema.Types.ObjectId
        ref  : 'history'
      }
    ]
    createdAt :
      type : Number
      default : moment( new Date() ).format( 'x' )
    updatedAt :
      type    : Number
      default : moment( new Date() ).format( 'x' )
  , { strict : true }

  # Hash password
  noteSchema.pre 'save', ( next ) ->
    if not @isNew
      @updatedAt = moment( new Date() ).format( 'x' )
    next()

  return mongoose.model 'note', noteSchema, 'notes'
