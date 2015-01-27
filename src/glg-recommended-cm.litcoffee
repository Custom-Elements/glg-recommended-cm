#recommended-cm
Query for council members, and store them as a managed list.

    Polymer 'glg-recommended-cm',

##Attributes and Change Handlers
#
###cmid
Store the list linkage for this council member.

###createdby
This is our employee that is currently editing.


###cmlist
These are the stored linkages, bound and shown on the UI.

###limit
Number of name matches to show in the typeahead.

##resultset
Data binding buffer for name matches in the typeahead, hooked up to
[nectar](https://github.com/glg/nectar).


##Methods

    refresh: ->
      @$.getcms.method="POST"
      @$.getcms.params="{\"COUNCIL_MEMBER_ID\":#{@cmid}}"
      @$.getcms.withCredentials="true"
      @$.getcms.url="https://query.glgroup.com/councilMember/recommendedcm/getRelationshipsByCMID.mustache"
      @$.getcms.go()

    addrel: (evt) ->
      if evt.detail.id
        @$.addcm.method="POST"
        @$.addcm.withCredentials="true"
        @$.addcm.params="{\"COUNCIL_MEMBER_ID\":#{@cmid},\"RELATED_CM_ID\":#{evt.detail.id}, \"CREATED_BY\":#{@createdby}}"
        @$.addcm.url="https://query.glgroup.com/councilMember/recommendedcm/addRelationship.mustache"
        @$.addcm.go()

        @$.typeahead.clear()
        @resultset = []

    removerel:  (evt) ->
      @$.removecm.method="POST"
      @$.removecm.withCredentials="true"
      @$.removecm.params="{\"COUNCIL_MEMBER_ID\":#{@cmid},\"RELATED_CM_ID\":#{evt.currentTarget.id}}"
      @$.removecm.url="https://query.glgroup.com/councilMember/recommendedcm/deleteRelationship.mustache"
      @$.removecm.go()

##Event Handlers
    handleerr: (evt) ->
      alert "Relationship already exists" if evt.currentTarget.id = "addcm" && evt.detail.response.match("PRIMARY KEY")

    loading: ->
      @$.loading.start()

    loaded: ->
      @$.loading.stop()

##Polymer Lifecycle

    created: ->

    domReady: ->
      @refresh()

    attached: ->

    ready: ->

    detached: ->
