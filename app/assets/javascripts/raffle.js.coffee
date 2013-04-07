app = angular.module("Raffler", ["ngResource"])

app.factory "Entry", ($resource) ->
  $resource("/entries/:id", {id: "@id"}, {update: {method: "PUT"}})

@RaffleCtrl = ($scope, Entry) ->
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

