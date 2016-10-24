validator = require 'validator'

module.exports = ( router, schemas ) ->

  router.post '/signup', ( req, res ) ->
    if !req.body.email or !req.body.password
      res.send
        success : false
        err     : 'INVALID_DATA'
    else

      if not validator.isEmail( req.body.email )
        return res.send
          success : false
          err     : 'INVALID_EMAIL_ADDRESS'

      newUser = new schemas.User( req.body )

      # Save user
      newUser.save ( err ) ->
        if err
          switch err.code
            when 11000
              return res.send
                success : false
                err     : 'DUPLICATE_USER'
            else
              return res.send { success: false, err: err }
        res.send
          success : true
          code    : 'SUCCESSFULLY_CREATE_USER'
