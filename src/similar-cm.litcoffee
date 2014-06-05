#similar-cm
*TODO* tell me all about your element.

    _ = require 'lodash'
    Polymer 'similar-cm',

##Events
*TODO* describe the custom event `name` and `detail` that are fired.

##Attributes and Change Handlers

##Methods

##Event Handlers

##Polymer Lifecycle

    created: ->

    ready: ->

    attached: ->

      window.addEventListener 'results', (evt) =>
        @$.results.model = evt.detail
        Platform.performMicrotaskCheckpoint() 

    domReady: ->

    detached: ->
