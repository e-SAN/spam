@Items = new Meteor.Collection "items"

@Items.deny #
	update: (userId,doc,fieldNames,modifier)->
		#console.log userId
		fieldNames.indexOf("owner") > -1

###
@Items.allow
	insert: (userId,doc) -> true
	update: (userId,doc,fieldNames,modifier) ->
		_.all( doc, (d)-> true)

#!no allow is a deny!		
###

@Items.allow 
	# userId? and doc.creator is "guest"等等都行
	insert: (userId, doc) -> userId? and doc.owner is userId 
	remove: (userId, doc) -> userId? and doc.owner is userId
	update: (userId, doc, fieldNames, modifier) -> 
		#console.log fieldNames, modifier
		#console.log doc 
		_.all( doc, (d)-> d.owner is userId) # doc updateFor:[:d| d owner is: userId]


###
	 in Smalltalk it could be: 
	 Items allow
	 	insert:[:userId doc| userId and:[doc owner == userId]]; 
		remove:[];
		update:[];
		yourself
		or using a dictionary to store those three blocks
###	
