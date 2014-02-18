class Entertain
 include Cinch::Plugin
 match "entertain us", :use_prefix => false
 match "im bored", :use_prefix => false
 match "entertain me", :use_prefix => false
 match "let the show begin", :use_prefix => false
 match "bring in the clowns", :use_prefix => false
 match "argue", :use_prefix => false
 def execute(m)
  files = Dir["/usr/ircfun/scripts/*"]
  `/usr/ircfun/blimlimb.rb #{files[rand(files.size)]}`
 end
end
$plugins.push(Entertain)

class StopEntertain
 include Cinch::Plugin
 match "stop blimlimb", :use_prefix => false
 match "kill blimlimb", :use_prefix => false
 def execute(m)
  `killall blimlimb.rb`
 end
end
$plugins.push(StopEntertain)
