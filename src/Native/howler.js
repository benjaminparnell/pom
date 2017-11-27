var Howl = require('howler')

var sounds = {
  end: new Howl.Howl({
    src: [ require('../end.mp3') ]
  })
}

module.exports = function (app) {
  function playSound (sound) {
    if (sounds[sound]) {
      sounds[sound].play()
    }
  }

  app.ports.playSound.subscribe(playSound)
}
