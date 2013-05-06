// Because obviously lefnire is a class. And he will not be subject to class-naming conventions!

function lefnire () {
  this.textPrefix = "lefnire says: ";
}

lefnire.prototype.say = function (text) {
  console.log(this.textPrefix + text);
}

module.exports = lefnire;
