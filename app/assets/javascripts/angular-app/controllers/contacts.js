angular
  .module('app')
  .controller('ContactsCtrl', ['$scope', 'Contact', function($scope, Contact) {

    $scope.Contact = Contact;

    Contact.all().then(function(response) {
      $scope.contacts = response;
    });

    $scope.contact = Contact.new();

    Contact.after('$save', function(response) {
      $scope.contacts.push(response.instance);
      $scope.contact = Contact.new();
    });
  }]);
