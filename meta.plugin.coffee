module.exports = (BasePlugin) ->
  class Meta extends BasePlugin
    name: "meta"
    serverExtend: (options) ->
      __ = require "underscore.string"
      {server} = options

      server.get "*", (request, response, next) ->
        if request.path.match(/\.(\w+)$/)[1] is "json"
          response.send "It's JSON!"
        else next()
        
    