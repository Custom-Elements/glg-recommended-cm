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
    onChange: (evt) ->
      alert evt

##Polymer Lifecycle

    created: ->

    ready: ->

    attached: ->
      template = @$.results
      typeahead = @$.ta
      ajax = @$.ca

      window.addEventListener 'results', (evt) =>
        template.model = evt.detail
        Platform.performMicrotaskCheckpoint() 
        console.log("template model updated", template.model)

      typeahead.addEventListener 'change', (evt) =>
        alert evt.detail.item.id
      
      ajax.addEventListener 'core-response', (evt) =>
        console.log(evt.detail.response);

      ajax.method="POST"
      ajax.params='{"COUNCIL_MEMBER_ID":"55"}'
      ajax.go()

    domReady: ->

    detached: ->
