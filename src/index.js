require('./index.html')

require('ace-css/css/ace.css')

require('./css/main.css')

var howlerPorts = require('./Native/howler')

var Elm = require('./Main.elm')
var mountNode = document.getElementById('main')

var app = Elm.Main.embed(mountNode)

howlerPorts(app)

app.ports.title.subscribe(function (title) {
  document.title = title
})
