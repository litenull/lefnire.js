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

if argv.troll or argv.irc
  suffix = "Let me try and find you on IRC..."
else
  suffix = "Shoot me a G+"
thisLefnire.say "Dunno what you want. #{suffix}"

# Initiate IRC sequence!
thisLefnire.trollIrc() if argv.troll or argv.irc
