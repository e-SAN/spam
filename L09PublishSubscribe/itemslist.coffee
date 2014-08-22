share.Items = new Meteor.Collection "items"




if Meteor.isClient
  Meteor.autosubscribe ->
    Meteor.subscribe "itemsChanel", Session.get "category"

  Template.name.events
    'keypress input': (e,t)-> 
      if e.keyCode is 13
        Session.set "category", e.currentTarget.value
        e.currentTarget.value = "" 
    
  Template.items.items = -> 
  	share.Items.find() 




if Meteor.isServer 
  Meteor.publish "itemsChanel",(aCategory) -> 
  	share.Items.find category: aCategory 
