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

    cmid: (id) ->
      @cmid = id
      ajax = @$.aj
      ajax.params = {"COUNCIL_MEMBER_ID":@cmid]}

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

      window.addEventListener 'results', (evt) =>
        template.model = evt.detail
        Platform.performMicrotaskCheckpoint() 
        console.log("template model updated", template.model);

      typeahead.addEventListener 'change', (evt) =>
        alert evt.detail.item.id


    domReady: ->

    detached: ->
