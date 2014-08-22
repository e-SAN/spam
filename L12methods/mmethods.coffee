Items = new Meteor.Collection "items"

if Meteor.isClient
	Template.list.items = ->
		Items.find()

Meteor.methods
	createItem: (text)=> #因为下面block内需要用self所以..=>
		if @isSimulation # only on the client side
			console.log "sending #{text} to server"
		else # on the server
			Items.insert text: text
			return 'this is returned too the client callback'
		# on the client Meteor.call "createItem", (err, res)-> res

#if Meteor.isServer
	#nothing
