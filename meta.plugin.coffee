module.exports = (BasePlugin) ->
  class Meta extends BasePlugin
    name: "meta"
    serverExtend: (options) ->
      {server} = options
      docpad = @docpad

      server.get "*", (request, response, next) ->
        return next() unless request.accepts(["html", "json"]) is "json"
        
        if not docpad.filesByUrl[request.path] 
          response.status 404
          response.end()
          return
      
        document = docpad.getFileByUrl(request.path)
        response.send JSON.stringify document.meta.attributes

        else next()
        
    