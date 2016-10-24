module.exports = ( router, schemas ) ->

  router.post '/board/:id/detag', ( req, res ) ->

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
        index = board.tags.indexOf req.body.tag
        if index > -1
          board.tags.splice index, 1
          board.save ( err ) ->
            if err then throw err
            return res.send
              success : true
              data    : board.tags
        else
          return res.send
            success : false
            err     : 'TAG_NOT_FOUND'
