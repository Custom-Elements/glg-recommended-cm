#similar-cm
*TODO* tell me all about your element.

    _ = require 'lodash'
    Polymer 'glg-similar-cm',

##Events
*TODO* describe the custom event `name` and `detail` that are fired.

##Attributes and Change Handlers
##Methods

##Event Handlers
    onChange: (evt) ->
      alert evt

##Polymer Lifecycle

    created: ->

    ready: ->

    attached: ->
      @refresh()

    refresh: ->
      @$.getcms.method="POST"
      @$.getcms.params="{\"COUNCIL_MEMBER_ID\":#{@cmid}}"
      @$.getcms.withCredentials="true"
      @$.getcms.url="https://query.glgroup.com/councilMember/similarcm/getRelationshipsByCMID.mustache"
      @$.getcms.go()

    addrel: (evt) ->
      if evt.detail.item && evt.detail.item.selected?
        @$.addcm.method="POST"
        @$.addcm.withCredentials="true"
        @$.addcm.params="{\"COUNCIL_MEMBER_ID\":#{@cmid},\"RELATED_CM_ID\":#{evt.detail.item.id}, \"CREATED_BY\":#{@createdby}}"
        @$.addcm.url="https://query.glgroup.com/councilMember/similarcm/addRelationship.mustache"
        @$.addcm.go()
        foo =
          detail:
            value:""
        @$.typeahead.clear()
        @$.nectar.loadResults(foo)

    removerel:  (evt) ->
      @$.removecm.method="POST"
      @$.removecm.withCredentials="true"
      @$.removecm.params="{\"COUNCIL_MEMBER_ID\":#{@cmid},\"RELATED_CM_ID\":#{evt.currentTarget.id}}"
      @$.removecm.url="https://query.glgroup.com/councilMember/similarcm/deleteRelationship.mustache"
      @$.removecm.go()

    change: (evt) ->

    domReady: ->

    detached: ->
