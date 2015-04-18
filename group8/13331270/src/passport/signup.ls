require! {'bcrypt-nodejs', 'passport-local', User: '../models/user'}
LocalStrategy = passport-local.Strategy

hash = (password)-> bcrypt-nodejs.hash-sync password, (bcrypt-nodejs.gen-salt-sync 10), null

module.exports = (passport)!-> passport.use 'signup', new LocalStrategy pass-req-to-callback: true, (req, username, password, done)!->
  User.find-one {username: username, role: req.param 'role'}, (error, user) -> 
    return (console.log "Error in signup: ", error ; done error) if error

    if user
      console.log msg = "User: #{username} as a #{user.role} already exists"
      done null, false, req.flash 'message', msg
    else
      new-user = new User {
        username  : username
        password  : hash password
        email     : req.param 'email'
        role      : req.param 'role'
      } 
      new-user.save (error)->
        if error
          console.log "Error in saving user: ", error
          throw error
        else
          console.log "User registration success"
          done null, new-user 
