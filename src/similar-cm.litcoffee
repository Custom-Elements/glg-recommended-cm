#similar-cm
*TODO* tell me all about your element.

    _ = require 'lodash'
    Polymer 'similar-cm',

##Events
*TODO* describe the custom event `name` and `detail` that are fired.

##Attributes and Change Handlers
    triggerChanged: (oldVal,newVal) ->
        @removeEventListener oldVal, @loadResults if oldVal
        @addEventListener newVal, @loadResults

    entitiesChanged: ->
      e = @entities
      e = JSON.parse(e) if e[0] is '['
      @entitiesParsed = e        

##Methods

##Event Handlers

##Polymer Lifecycle

    created: ->

    ready: ->

    attached: ->
      template = @$.results

      window.addEventListener 'results', (evt) =>
        template.model = evt.detail
        Platform.performMicrotaskCheckpoint() 
        console.log("template model updated", template.model);
    domReady: ->

    detached: ->
