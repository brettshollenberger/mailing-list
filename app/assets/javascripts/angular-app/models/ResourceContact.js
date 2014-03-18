angular
  .module('app')
  .factory('ResourceContact', function($resource) {
    var ResourceContact = $resource('http://localhost:3000/api/v1/contacts', {});

    return ResourceContact;
  });
