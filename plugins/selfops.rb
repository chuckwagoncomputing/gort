class Kill
 include Cinch::Plugin
 match lambda {|m| "#{m.bot.nick}: kill your minions" }, :use_prefix => false
 def execute(m)
  File.open('/usr/ircfun/minions.log', 'r') do |minionfile|
   while line = minionfile.gets
    `kill #{line}`
   end
   `> /usr/ircfun/minions.log`
  end  
 end
end
$plugins.push(Kill)

class Die
 include Cinch::Plugin
 match lambda {|m| "#{m.bot.nick}: die" }, :use_prefix => false
 def execute(m)
  bot.quit
 end
end
$plugins.push(Die)

class Clone
 include Cinch::Plugin
 match "double trouble", :use_prefix => false
 def execute(m)
  randnick = ('a'..'z').to_a.shuffle[0,8].join
  `/usr/ircfun/robot.rb #{randnick}`
 end
end
$plugins.push(Clone)

class Rename
 include Cinch::Plugin
 match /^call yourself (.*)$/i, :use_prefix => false, :method => :execute
 def execute(m, *args)
  bot.nick = args[0]
 end
end
$plugins.push(Rename)

#Author: BenjiWiebe
#Date: 06/25/2013
class Reboot
 include Cinch::Plugin
 match /^reboot$/i, :use_prefix => false, :method => :reboot
 match lambda {|m| "#{m.bot.nick} reboot" }, :use_prefix => false, :method => :reboot
 def reboot(m)
  `/etc/init.d/ircbot restart`
 end
end
$plugins.push(Reboot)
