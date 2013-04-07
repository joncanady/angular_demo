app = angular.module("Raffler", ["ngResource", "RafflerRouter"])

angular.module("RafflerRouter", []).config ["$routeProvider", ($routeProvider) ->
  $routeProvider.when("/entries",
    templateUrl: "partials/entries/index.html"
    controller: @RaffleIndexCtrl
  ).when("/entries/:id",
    templateUrl: "partials/entries/show.html"
    controller: @RaffleShowCtrl
  ).otherwise redirectTo: "/entries"
]

app.factory "Entry", ($resource) ->
  $resource("/entries/:id", {id: "@id", "api_version": 2}, {update: {method: "PUT"}})

@RaffleShowCtrl = ($scope, $routeParams, Entry) ->
  $scope.entry = Entry.get(id: $routeParams.id)

@RaffleIndexCtrl = ($scope, Entry) ->
  $scope.entries = Entry.query()

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push(entry)
    $scope.newEntry = {}

  $scope.drawWinner = ->
    pool = []

    angular.forEach $scope.entries, (entry) ->
      pool.push(entry) unless entry.winner

    if pool.length > 0
      entry = pool[Math.floor(Math.random() * pool.length)]
      entry.winner = true
      entry.$update()
      $scope.lastWinner = entry

  $scope.resetWinners = ->
    $scope.lastWinner = null
    angular.forEach $scope.entries, (entry) ->
      if entry.winner
        entry.winner = false
        entry.$update()

  $scope.declareWinner = (entry) ->
    unless entry.winner
      $scope.lastWinner = entry
      entry.winner = true
      entry.$update()

  $scope.deleteEntry = (entry) ->
    $scope.lastWinner = null if entry is $scope.lastWinner
    entry.$delete()
    index = $scope.entries.indexOf(entry)
    $scope.entries.splice(index, 1)

