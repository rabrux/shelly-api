module.exports = ( router, schemas ) ->

  router.get '/boards', ( req, res ) ->

    user = req.user

    schemas.User.findOne { _id: user._id }, ( err, me ) ->
      if err then throw err
      if me
        return res.send
          success : true
          data    : me.boards
    .populate
      path : 'boards'
      populate : [
        {
          path : 'owner'
          select : 'email username -_id'
        }
        {
          path : 'contributors'
          select : 'email username -_id'
        }
      ]
