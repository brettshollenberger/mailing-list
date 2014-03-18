angular
  .module('app')
  .controller('ContactsCtrl', ['$scope', 'Contact', 'ResourceContact', function($scope, Contact, ResourceContact) {

    // $scope.Contact = Contact;

    // Contact.all().then(function(response) {
    //   $scope.contacts = response;
    // });

    $scope.contacts = ResourceContact.query();
    $scope.Contact  = ResourceContact;
  }]);
