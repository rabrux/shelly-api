randomstring = require 'randomstring'
moment       = require 'moment-timezone'

module.exports = ( mongoose ) ->

  todoSchema = new mongoose.Schema
    task :
      type     : String
      required : true
    deadline : Number
    done :
      type    : Boolean
      default : false
    addedBy  :
      type : mongoose.Schema.Types.ObjectId
      ref  : 'user'
    endedBy  :
      type : mongoose.Schema.Types.ObjectId
      ref  : 'user'
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
  todoSchema.pre 'save', ( next ) ->
    if not @isNew
      @updatedAt = moment( new Date() ).format( 'x' )
    next()

  return mongoose.model 'todo', todoSchema, 'todos'
