class Fortune
 include Cinch::Plugin
 match "fortune", :use_prefix => false
 def execute(m)
  m.reply [fortune].join(": ")
 end
 private
 def fortune
  fortune = `/usr/games/fortune`
  sanitize_fortune(fortune)
 end
 def sanitize_fortune(fortune)
  fortune.gsub(/[\n]/, " ").
  gsub(/[\t]/, " ").
  gsub("?A:", "? A:")
 end
end
$plugins.push(Fortune)
