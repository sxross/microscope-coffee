@p = (message) -> console.log(message)

Template.postEdit.created = ->
  Session.set 'postEditErrors', {}

Template.postSubmit.helpers
  errorMessage: (field) ->
    Session.get('postEditErrors')[field]

  errorClass: (field) ->
    if Session.get('postEditErrors')[field] then 'has-error' else ''

Template.postEdit.helpers
  errorMessage: (field) ->
    Session.get('postEditErrors')[field]

  errorClass: (field) ->
    if Session.get('postEditErrors')[field] then 'has-error' else ''

Template.postEdit.events
  'submit form': (e) ->
    e.preventDefault()

    currentPostId = @_id

    postProperties =
      url: $(e.target).find("[name=url]").val()
      title: $(e.target).find("[name=title]").val()

    errors = validatePost(postProperties)

    p "post validated, errors title: #{errors.title} url: #{errors.url}"

    return Session.set('postEditErrors', errors) if errors.title or errors.url

    Posts.update currentPostId,
      $set: postProperties
    , (error) ->
      if error

        # display the error to the user
        # throwError error.reason
        Errors.throw(error.reason)
      else
        Router.go "postPage",
          _id: currentPostId

  'click .delete': (e) ->
    e.preventDefault()

    if confirm('Delete this post?')
      currentPostId = @_id
      Posts.remove currentPostId
      Router.go 'postsList'
