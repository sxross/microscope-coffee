@COMMENT_SUBMIT_ERRORS = 'commentSubmitErrors'

Template.commentSubmit.created = ->
  Session.set COMMENT_SUBMIT_ERRORS, {}

Template.commentSubmit.helpers
  errorMessage: (field) ->
    Session.get(COMMENT_SUBMIT_ERRORS)[field]
  errorClass: (field) ->
    if Session.get(COMMENT_SUBMIT_ERRORS)[field]
      'has-error'
    else
      ''

Template.commentSubmit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $body = $(e.target).find('[name=body]')
    comment =
      body: $body.val()
      postId: template.data._id

    errors = {}
    unless comment.body
      errors.body = "Please write some content"
      return Session.set(COMMENT_SUBMIT_ERRORS, errors)

    Meteor.call 'commentInsert', comment, (error, commentId) ->
      if error
        throwError error.reason
      else
        $body.val('')
