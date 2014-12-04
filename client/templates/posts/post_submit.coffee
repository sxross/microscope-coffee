Template.postSubmit.created = ->
  Session.set 'postSubmitErrors', {}

Template.postSubmit.helpers
  errorMessage: (field) ->
    Session.get('postSubmitErrors')[field]

  errorClass: (field) ->
    if Session.get('postSubmitErrors')[field] then 'has-error' else ''

Template.postSubmit.events "submit form": (e) ->
  e.preventDefault()
  post =
    url: $(e.target).find("[name=url]").val()
    title: $(e.target).find("[name=title]").val()

  errors = validatePost(post)

  return Session.set('postSubmitErrors', errors) if errors.title or errors.url

  Meteor.call 'postInsert', post, (error, result) ->
    # return throwError(error.reason) if error?
    Errors.throw(error.reason) if error?

    if result.postExists?
      throwError 'This link has already been posted'

    Router.go "postPage", result
