#glg-nectar
This element provides access to GLG's nectar search service, listening for the specified 
event and retrieving data from the configured indexes. Use it to wrap a particular element 
that you'd like to trigger data retrieval.

    _ = require('../node_modules/lodash/dist/lodash.js')
    Polymer 'glg-nectar',

##Attributes and Change Handlers
####trigger
The name of the event that the element will listen for to trigger data retrieval. 
This event currently needs to expose a `value` property on the event details that's sent along as the query
####entities
The nectar entities/indexes to load data from.  Can either be an array or a string.
####urls
The urls to the server, can be either a single or array of urls if client-side load balancing is needed.

      triggerChanged: (oldVal,newVal) ->
        @removeEventListener oldVal, @loadResults if oldVal
        @addEventListener newVal, @loadResults

      entitiesChanged: ->
        e = @entities
        e = JSON.parse(e) if e[0] is '['
        @entitiesParsed = e        

##Methods
####loadResults
This method should only ever really be called by event handling specified by the `trigger` attribute. 

      loadResults: (evt) ->
        if evt.detail.value.length > 0 
          query = 
            entity: @entitiesParsed, 
            query: evt.detail.value
            options:  
              howMany: @limit
              interleave: false

          @$.socket.send query, (response) =>
            @results = response.results
            @resultset = _.map response.results, (results,type) -> { type, results }
            @fire 'results', { query: query, results: @results, resultset: @resultset }
        else 
          query=
            entity: null,
            query: "",
            options:
              howMany: 0
              interleave: false

          @results = null
          @resultset = []
          @fire 'results', { query: query, results: @results, resultset: @resultset }
          