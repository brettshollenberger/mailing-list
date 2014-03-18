angular
  .module('app')
  .directive('search', ['$timeout', function($timeout) {
    return {
      restrict: 'A',
      scope: {
        search: '@',
        model: '=',
        update: '=',
        fuzzy: '@'
      },
      link: function(scope, element, attrs) {
        var searchTimeout;

        element.on('keyup', function() {
          if (searchTimeout !== undefined) $timeout.cancel(searchTimeout);

          searchTimeout = $timeout(function() {

            var val = element.val();
            if (val !== undefined && val.length !== undefined && val.length > 0) {

              var query           = {};
              query.fuzzy         = scope.fuzzy || false;

              if (scope.search && scope.search.length > 0) {
                query[scope.search] = val;
              } else {
                query.any = val;
              }

              scope.model.where(query).then(function(response) {
                _.each(response, function(item) {
                  scope.update.nodupush(item);
                });
              });
            } else {
              scope.model.all().then(function(response) {
                scope.update = response;
              });
            }
          }, 200);
        });
      }
    }
  }]);
