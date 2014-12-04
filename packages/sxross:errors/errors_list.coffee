Template.meteorErrors.helpers
  errors:
    Errors.collection.find()

Template.meteorError.rendered = ->
  error = @data
  Meteor.setTimeout ->
    Errors.collection.remove error._id
  , 3000
