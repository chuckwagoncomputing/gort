class Wisdom
 include Cinch::Plugin
 match /\btry\b/, :use_prefix => false
 def execute(m)
  m.reply "Do or do not, there is no try"
 end
end
$plugins.push(Wisdom)
