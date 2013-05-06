var args = require('optimist')
  .argv;

var mersenne = require('mersenne'),
  lefnire = require('./lib/lefnire');

var thisLefnire = new lefnire();

// TODO: Make laziness configurable
var doSomeWork = mersenne.rand(11);

if (doSomeWork == 5) {
  // TODO: Add list of excuses for not working
  thisLefnire.say("Sorry, I'm busy fixing Derby bugs. Maybe next time.");
  console.log("Execution stopped!");
  return;
}

thisLefnire.say("Dunno what you want. Shoot me a G+ hangout invite.");
