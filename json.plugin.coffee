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

      # Get single document
      server.get "*", (request, response, next) ->
        return next() unless request.accepts(["html", "json"]) is "json"
        
        if not docpad.filesByUrl[request.path]
          response.status 404
          response.end()
          return
        
        document = docpad.getFileByUrl(request.path)
        console.dir document
        result =
          meta: document.meta.attributes
          content: document.attributes.content
        response.json result