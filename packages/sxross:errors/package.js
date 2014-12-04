Package.describe({
  name: 'sxross:errors',
  summary: 'A pattern to display application errors to the user',
  version: '1.0.0',
  git: ' /* Fill me in! */ '
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use(['minimongo', 'mongo-livedata', 'templating'], 'client');
  api.addFiles(['errors.coffee', 'errors_list.html', 'errors_list.coffee'], 'client');
  if (api["export"]) {
    return api["export"]('Errors');
  }
});

Package.onTest(function(api) {
  api.use('sxross:errors', 'client');
  api.use(['tinytest', 'test-helpers'], 'client');
  api.addFiles('errors_tests.js', 'client');
});
