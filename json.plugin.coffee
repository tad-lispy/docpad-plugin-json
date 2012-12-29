module.exports = (BasePlugin) ->
  class Meta extends BasePlugin
    name: "json"
    serverExtend: (options) ->
      {server} = options
      docpad = @docpad

      # Get list of documents in collection
      server.get "/*/", (request, response, next) ->
        return next() unless request.accepts(["html", "json"]) is "json"
        collection = request.params[0]

        if not (collection of docpad.getCollections())
          response.status 404
          response.end()
          return

        list = []
        for document in docpad.getCollection(collection).toJSON()
          {url, title, meta} = document
          list.push {url, title, meta}

        response.json documents: list

      # Get metadata
      server.get "*", (request, response, next) ->
        return next() unless request.accepts(["html", "json"]) is "json"
        
        if not docpad.filesByUrl[request.path]
          response.status 404
          response.end()
          return
        
        document = docpad.getFileByUrl(request.path)
        response.json document.meta.attributes
      

    