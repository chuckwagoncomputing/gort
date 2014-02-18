class Stats
 include Cinch::Plugin
 match /(.*)/, :use_prefix => false, :method => :add
 def add(m, *args)
   if $count[m.user.user] == nil
    $count[m.user.user] = 0
   end
   $count[m.user.user] += args.join(" ").length
 end

 match "status", :use_prefix => false, :method => :list
 def list(m)
  $count.each_key do |key|
   m.reply "#{key}: #{$count[key]}"
  end
 end

 match "who talks most", :use_prefix => false, :method => :most
 def most(m)
  m.reply largest_hash_key($count)[0]
 end
end
$plugins.push(Stats)
