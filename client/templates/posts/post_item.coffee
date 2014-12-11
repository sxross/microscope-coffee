Template.postItem.helpers
  ownPost: ->
    @userId is Meteor.userId()

  domain: ->
    a = document.createElement('a')
    a.href = @url
    a.hostname

  upvotedClass: ->
    userId = Meteor.userId()
    if userId and !_.include(@upvoters, userId)
      return 'btn-primary upvotable'
    else
      return 'disabled'

Template.postItem.events
  'click .upvotable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id
