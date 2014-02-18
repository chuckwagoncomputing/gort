require 'redis'
class Info
 include Cinch::Plugin
 match "info", :use_prefix => false, :method => :info
 listen_to :join, :method => :joinf
 listen_to :part, :method => :partf
 $h = Hash.new

 def joinf(m)
  $h["#{m.user.nick}/join"] = `date +%m/%d/%y@%H:%M`.chop
 end

 def partf(m)
   $h["#{m.user.nick}/part"] = `date +%m/%d/%y@%H:%M`.chop
 end

 def info(m)
  $h.each do |key|
   nick = key[0].split("/")[0]
   uaction = key[0].split("/")[1]
   if uaction == "join"
    action = "Joined"
   elsif uaction == "part"
    action = "Parted"
   end
   m.reply "#{nick} #{action}: #{key[1]}" unless m.channel.has_user?(nick)
  end
 end
end
$plugins.push(Info)
