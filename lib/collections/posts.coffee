@Posts = new Mongo.Collection("posts")

Posts.allow
  update: (userId, post) -> ownsDocument(userId, post)
  remove: (userId, post) -> ownsDocument(userId, post)

Posts.deny
  update: (userId, post) -> _.without(fieldNames, 'url', 'title').length > 0

  update: (userId, post, fieldNames, modifier) ->
    errors = validatePost modifier.$set
    return errors.title or errors.url

postExists = (url) ->
  postWithSameLink = Posts.findOne(url: url)
  if postWithSameLink
    return (
      postExists: true
      _id: postWithSameLink._id
    )

@validatePost = (post) ->
  errors = {}
  errors.title = "Please fill in a headline" unless post.title
  errors.url = "Please fill in a url" unless post.url
  errors

Meteor.methods
  postInsert: (postAttributes) ->
    check @userId, String
    check postAttributes,
      title: String
      url: String

    existing = postExists(postAttributes.url)
    return existing if existing?

    user = Meteor.user()
    post = _.extend(postAttributes,
      userId: user._id
      author: user.username
      submitted: new Date()
      commentsCount: 0
    )
    postId = Posts.insert(post)
    {_id: postId}
