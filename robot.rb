#!/usr/bin/ruby
$plugins = []
require 'cinch'
require 'cinch/plugins/memo'
require '/usr/irc/plugins/remind.rb'
require '/usr/irc/plugins/entertain.rb'
require '/usr/irc/plugins/fortune.rb'
require '/usr/irc/plugins/weather.rb'
require '/usr/irc/plugins/selfops.rb'
require '/usr/irc/plugins/stats.rb'
require '/usr/irc/plugins/wisdom.rb'
require '/usr/irc/plugins/info.rb'

if ARGV[0] == nil
$nickname = "Gort"
else
$nickname = ARGV[0]
File.open('/usr/irc/minions.log', 'a') do |minionfile|
 minionfile.puts $$
end
end

def largest_hash_key(hash)
 hash.max_by{|k,v| v}
end

$count = Hash.new
$plugins.push(Cinch::Plugins::Memo::Base)

Cinch::Plugins::Memo::Base.configure do |c|
  c.store   = :redis
  c.host    = 'localhost'
  c.port    = '6379'
end

bot = Cinch::Bot.new do
 configure do |c|
  c.server = "localhost"
  c.nick = $nickname
  c.user = $nickname
  c.realname = $nickname.capitalize + "us Domesticus"
  c.channels = ["#main"]
  c.plugins.plugins = $plugins
 end
 on :message, "wake up" do |m|
  m.channel.users.each_key do |key|
   m.reply "Wake up, #{key}" if key != m.bot.nick
  end
 end
 on :message, /\u0001ACTION STARES(.*)\u0001/ do |m|
  m.reply "\u0001ACTION STARES BACK (CHANGELESS)\u0001"
 end
end
bot.start
