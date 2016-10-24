Array::unique = ->
  copy = @concat()
  result = []
  while item = copy.shift()
    if result.indexOf( item ) == -1
      result.push item
  result
