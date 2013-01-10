JSON Plugin for Docpad  
======================

Supersimple plugin for DocPad[1] to send document meta and content as JSON when requested.

How to use it?
--------------

Just place it in your plugins directory and make requests, eg

    ``` bash
    curl -H "Accept: application/json" http://localhost:9778/
    ```

You should get:

    ``` javascript
    {
      meta: {}      // your document's metadata
      content: ""   // your content, not rendered
    }
    ```

[1]: https://docpad.org/ "DocPad - a next generation web framework"