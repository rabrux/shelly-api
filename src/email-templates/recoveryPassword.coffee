module.exports = ( args ) ->

  if !args or !args.to or !args.key
    return false

  return {
    from    : '"Raúl Salvador Andrade" <raul@alchimia.mx>'
    to      : args.to
    subject : 'Cambio de contraseña'
    html    : "<h1>Cambio de contraseña</h1><br /><p>Se ha iniciado el proceso de recuperación de contraseña, para proceder accesa al siguiente link</p><br />Email: #{ args.to }<br />Key: #{ args.key }"
  }
