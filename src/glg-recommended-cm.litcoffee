#recommended-cm
Query for council members, and store them as a managed list.

    _ = require 'lodash'
    Polymer 'glg-recommended-cm',

##Attributes and Change Handlers
#
###cmid
Store the list linkage for this council member.

###createdby
This is our employee that is currently editing.


###cmlist
These are the stored linkages, bound and shown on the UI.

    cmlistChanged: ->
      @$.loading.stop()

###limit
Number of name matches to show in the typeahead.

##resultset
Data binding buffer for name matches in the typeahead, hooked up to
[nectar](https://github.com/glg/nectar).

    resultsetChanged: ->
      @$.loading.stop()

##Methods

    refresh: ->
      @$.getcms.method="POST"
      @$.getcms.params="{\"COUNCIL_MEMBER_ID\":#{@cmid}}"
      @$.getcms.withCredentials="true"
      @$.getcms.url="https://query.glgroup.com/councilMember/recommendedcm/getRelationshipsByCMID.mustache"
      @$.getcms.go()
      @$.loading.start()

    addrel: (evt) ->
      if evt.detail.item && evt.detail.item.selected?
        @$.addcm.method="POST"
        @$.addcm.withCredentials="true"
        @$.addcm.params="{\"COUNCIL_MEMBER_ID\":#{@cmid},\"RELATED_CM_ID\":#{evt.detail.item.id}, \"CREATED_BY\":#{@createdby}}"
        @$.addcm.url="https://query.glgroup.com/councilMember/recommendedcm/addRelationship.mustache"
        @$.addcm.go()
        @$.loading.start()
        foo =
          detail:
            value:""
        @$.typeahead.clear()
        @$.nectar.loadResults(foo)

    removerel:  (evt) ->
      @$.removecm.method="POST"
      @$.removecm.withCredentials="true"
      @$.removecm.params="{\"COUNCIL_MEMBER_ID\":#{@cmid},\"RELATED_CM_ID\":#{evt.currentTarget.id}}"
      @$.removecm.url="https://query.glgroup.com/councilMember/recommendedcm/deleteRelationship.mustache"
      @$.removecm.go()
      @$.loading.start()

##Event Handlers
    handleerr: (evt) ->
      alert "Relationship already exists" if evt.currentTarget.id = "addcm" && evt.detail.response.match("PRIMARY KEY")

    change: (evt) ->

##Polymer Lifecycle

    created: ->

    domReady: ->

    attached: ->
      @refresh()
      @addEventListener 'nectarQuery', =>
       ## @$.loading.start()

    ready: ->

    detached: ->
