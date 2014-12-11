UI.registerHelper 'pluralize', (n, thing) ->
  return "1 #{thing}" if n is 1
  return "#{n} #{thing}s"
