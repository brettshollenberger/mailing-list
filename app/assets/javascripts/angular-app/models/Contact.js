angular
  .module('app')
  .factory('Contact', function($resource) {
    var Contact = $resource('http://localhost:3000/api/v1/contacts', {});

    return Contact;
  });
