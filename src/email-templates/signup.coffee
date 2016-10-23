module.exports = ( args ) ->

  if !args or !args.to or !args.key
    return false

  return {
    from    : '"Raúl Salvador Andrade" <raul@alchimia.mx>'
    to      : args.to
    subject : 'Valida tu cuenta de correo electrónico'
    html    : "<h1>Test from templates</h1><br />Email: #{ args.to }<br />Key: #{ args.key }"
  }
