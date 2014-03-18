angular
  .module('app')
  .factory('Contact', ['ActiveResource', function(ActiveResource) {
    function Contact(attributes) {
      this.string('first_name');
      this.string('last_name');
      this.string('email');
      this.string('join_date');
      this.string('last_contacted');
    };

    Contact.inherits(ActiveResource.Base);
    Contact.api.set('http://localhost:3000/api/v1').format('json');
    return Contact;
  }]);
