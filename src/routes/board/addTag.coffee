module.exports = ( router, schemas ) ->

  router.post '/board/:id/tag', ( req, res ) ->

    user = req.user

    if not req.body or not req.body.tag
      return res.send
        success : false
        err     : 'INVALID_DATA'

    schemas.Board.findOne { _id : req.params.id, contributors : { $in : [ user._id ] } }, ( err, board ) ->
      if err then throw err
      if not board
        return res.send
          success : false
          err     : 'BOARD_NOT_FOUND'
      else
        board.tags = board.tags.concat( String( req.body.tag ) ).unique()

        board.save ( err ) ->
          if err then throw err
          return res.send
            success : true
            data    : board.tags
