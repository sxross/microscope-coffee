Template.header.helpers
  activeRouteClass: (routes...) ->
    active = _.any(routes, (name) ->
      return Router.current()?.route.getName() is name
      )
    return 'active' if active
