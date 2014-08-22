if Meteor.isClient
  Template.login.creatingAccount = ->
    Session.get "creatingAccount"

  Template.newAccountForm.events
    'click #转向登录界面': (e,t)-> 
      Session.set "creatingAccount", false #set 之参数之间,一度误用 : 故无反应.应该用, 下同

    'click button':(e,t) ->
      Session.set "creatingAccount", false
      Accounts.createUser
        username: t.find("#username").value # 我一度混淆name和username故出现奇怪错误
        password: t.find("#password").value
        email:t.find("#email").value
        profile:
          name: t.find("#name").value

  Template.loginForm.events
    'click #转向新建账户界面': (e,t)->
      Session.set 'creatingAccount', true
    'click #登录':(e,t)->
      #Session.set "creatingAccount", false
      Meteor.loginWithPassword t.find("#username").value, t.find( "#password").value  #没有value则出错

  Template.loggedInForm.events
    'click #退出': (e,t)->
      Meteor.logout()

  #console.log "hello"