angular
  .module('app')
  .controller('ContactsCtrl', ['$scope', 'Contact',
    function($scope, Contact) {
    $scope.contacts = Contact.query();
    $scope.Contact  = Contact;
  }]);
