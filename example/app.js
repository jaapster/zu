angular.module('zu.directives', [])
	.directive('list', function () {
		return {
			restrict : 'E',
			templateUrl: './tmpl/list.html',
			replace: true,
			link: function($scope) {
				var list = zu.list();
				var ots = zu.dbllist();

				$scope.add = function() {
					var id = Math.round(Math.random() * 1000);
					var r = zu.ot.add(list, {id: id});
					list = r[0];
					ots = ots.push(r[1])
					$scope.list = zu.list.array(list);
				};

				$scope.undo = function () {
					if (!undolist.empty()) {
						var r = zu.ot.undo(list, undolist.val());
						ots = ots.next();
						if (r) {
							list = r[0];
							$scope.list = zu.list.array(list);
						}
					}
				};

				$scope.redo = function () {
					ots = ots.prev();
					var r = zu.ot.do(list, undolist.val());
					if (r) {
						list = r[0];
						$scope.list = zu.list.array(list);
					}
				};

				$scope.list = zu.list.array(list);
			}
		};
	});

angular.module('zu', ['zu.directives']);