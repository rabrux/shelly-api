module.exports = ( router, schemas ) ->

  require( './create' )( router, schemas )
  require( './getAll' )( router, schemas )
  require( './addTag' )( router, schemas )
  require( './removeTag' )( router, schemas )
