share.List = new Meteor.Collection "list"
list = share.List

if Meteor.isClient
  add = (value) ->
    list.insert text: value
    ###
    list = Session.get "list"
    list.push item
    Session.set "list", list
    ###
  remove = (item) ->
    id = (list.findOne item)._id 
    list.remove( {_id: id} )
    
  #Session.set "list", ["one", "two"]
  
  Template.list.items = ->
    list.find()
    
  Template.list.events
    'keypress input': (e,t) ->
      if e.keyCode is 13
        input = t.find "input"
        add input.value
        input.value = ""

  Template.item.events
    'click': (e,t)->
      console.log t.data
      remove(t.data)

  Template.item.rendered = ->
    console.log "#{@data} rendered"
  Template.item.created = ->
    console.log @data, "#{@.data} created"
  Template.item.destroyed = ->
    console.log "#{} destroyed", @data  

if Meteor.isServer 
  Meteor.startup ->
    # code to run on server at startup

