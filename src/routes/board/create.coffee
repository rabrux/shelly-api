module.exports = ( router, schemas ) ->

  router.post '/board/create', ( req, res ) ->

    if not req.body.name
      return res.send
        success : false
        err     : 'INVALID_DATA'

    newBoard = new schemas.Board( req.body )
    newBoard.owner = req.user.id
    newBoard.contributors.push req.user.id

    newBoard.save ( err ) ->
      if err
        return res.send
          success : false
          err     : err
      else
        req.user.boards.push newBoard.id
        req.user.save ( err ) ->
          if err
            return res.send
              success : false
              err     : err
          else
            return res.send
              success : true
              data    : newBoard
