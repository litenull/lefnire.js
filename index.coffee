argv = require("optimist").argv
mersenne = require("mersenne")
moment = require('moment')
lefnire = require("./lib/lefnire")
thisLefnire = new lefnire()
thisLefnire.introduce()

# TODO: Make laziness configurable
mersenne.seed parseInt(moment().format('X'))
doSomeWork = mersenne.rand(11)
if parseInt(doSomeWork) is 5

  # TODO: Add list of excuses for not working
  thisLefnire.say "Sorry, I'm busy fixing Derby bugs. Maybe next time."
  console.log "Execution stopped!"
  process.exit()
thisLefnire.say "Dunno what you want. Let me try and find you on IRC..."

# Initiate IRC sequence!
thisLefnire.trollIrc() if argv.troll or argv.irc
