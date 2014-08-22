@People = new Meteor.Collection("people") # 注意用 @People,传导变量到外面
if Meteor.isClient
  Template.personList.people = ->
    @People.find()

  
  Template.personForm.events
    'click button': (e,t) => # 注意注意: 要用=>来传外面的this. this就像smalltalk的self会随环境变化
      #console.log "click button"
      element = t.find("#name")
      if element.value isnt ""
        @People.insert name: element.value
        element.value = ""

  Template.person.events
    'click .name': (e,t) -> # 这里没用到 this 所以不必传变量,所以用 ->
      Session.set "editting #{t.data._id}", true
    'keypress input': (e,t) => # 用了this 所以需要用 => 来传递外面的this变量, 如同[:@self| @self 如何]
      if e.keyCode is 13
        @People.update t.data._id, $set: name: e.currentTarget.value #tutsplus 视频用 t.data,不行
        Session.set "editting #{t.data._id}", false
    'click .delete': (e,t) =>
      console.log t.data
      @People.remove t.data._id

  Template.person.rendered = ->
    input = this.find("input")
    if input? then input.focus()     

  Template.person.editting = ->
    Session.get "editting #{@._id}"


if Meteor.isServer
  Meteor.startup ->
