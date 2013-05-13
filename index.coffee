argv = require("optimist").argv
mersenne = require("mersenne")
moment = require('moment')
lefnire = require("./lib/lefnire")
util = require('util')

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

# 1-in-10 chance of trolling even though you just wanted to IRC
if argv.irc and thisLefnire.maybe 10
  argv.troll = true
  thisLefnire.seriousTrolling = true
  thisLefnire.say "Nah, dude, I'm too busy to go on IRC...oh snap, my phone's on...let's see...how do I turn it off?"
else
  thisLefnire.say "Dunno what you want. #{suffix}"

# Initiate IRC sequence!
thisLefnire.trollIrc() if argv.troll or argv.irc
