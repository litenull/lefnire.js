args = require("optimist").argv
mersenne = require("mersenne")
lefnire = require("./lib/lefnire")
thisLefnire = new lefnire()
thisLefnire.introduce()

# TODO: Make laziness configurable
doSomeWork = mersenne.rand(11)
if doSomeWork is 5

  # TODO: Add list of excuses for not working
  thisLefnire.say "Sorry, I'm busy fixing Derby bugs. Maybe next time."
  console.log "Execution stopped!"
  exit
thisLefnire.say "Dunno what you want. Shoot me a G+ hangout invite."
