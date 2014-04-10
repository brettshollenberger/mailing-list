angular
  .module('app')
  .directive('search', function($timeout) {
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

            var val   = element.val();
            var query = {} ;

            if (val !== undefined && val.length !== undefined && val.length > 0) {
              query.fuzzy = scope.fuzzy || false;

              if (scope.search && scope.search.length > 0) {
                query[scope.search] = val;
              } else {
                query.any = val;
              }
            }

            scope.model.query(query).$promise.then(function(response) {
              _.each(response, function(item) {
                var responseAlreadyCached = _.find(scope.update, {id: item.id});
                if (!responseAlreadyCached) scope.update.push(item);
              });

              _.remove(scope.update, function(item) {
                return !_.find(response, {id: item.id});
              });
            });
          }, 200);
        });
      }
    };
  });
