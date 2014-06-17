#similar-cm
Query for council members, and store them as a managed list.

    _ = require 'lodash'
    Polymer 'glg-similar-cm',

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
      @$.getcms.url="https://query.glgroup.com/councilMember/similarcm/getRelationshipsByCMID.mustache"
      @$.getcms.go()
      @$.loading.start()

    addrel: (evt) ->
      if evt.detail.item && evt.detail.item.selected?
        @$.addcm.method="POST"
        @$.addcm.withCredentials="true"
        @$.addcm.params="{\"COUNCIL_MEMBER_ID\":#{@cmid},\"RELATED_CM_ID\":#{evt.detail.item.id}, \"CREATED_BY\":#{@createdby}}"
        @$.addcm.url="https://query.glgroup.com/councilMember/similarcm/addRelationship.mustache"
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
      @$.removecm.url="https://query.glgroup.com/councilMember/similarcm/deleteRelationship.mustache"
      @$.removecm.go()
      @$.loading.start()
    
    getCookie: () ->
      value = "; " + document.cookie
      parts = value.split("; glgSAM =")
      if parts.length is 2 then parts.pop().split(";").shift() else 'mhuggins'


    getBetaUsers: () ->
      @$.betalist.url="https://kvstore.glgroup.com/kv/bmp_data?callback="
      @$.betalist.go()


##Event Handlers
    handleerr: (evt) ->
      alert "Relationship already exists" if evt.currentTarget.id = "addcm" && evt.detail.response.match("PRIMARY KEY")
    

    checkperms: (evt) ->
      if window.location.hostname.match('localhost')? &&  window.location.hostname.match('localhost').length > 0
        @getBetaUsers()
      else
        @.admin = ""
    
    getbetagroup: (evt) ->
      console.log("in getbetagroup")
      group = evt.detail.response.groups.filter (word) ->
        'similar_cm_admin'.indexOf(word.name) isnt -1
      user = @getCookie()
      debugger;

      if group.length and group[0].users.length > 1
        user = $.grep(group[0].users, (e) ->
          e is username[0].toLowerCase()
          )
        if username[0].toLowerCase() and user[0] is username[0].toLowerCase()
          @.admin = "display: none"
        else
          @.admin = ""

    change: (evt) ->

##Polymer Lifecycle

    created: ->

    ready: ->

    attached: ->
      @refresh()
      @checkperms()
      @addEventListener 'nectarQuery', =>
        @$.loading.start()

    domReady: ->

    detached: ->
