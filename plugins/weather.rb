class Weather
 include Cinch::Plugin
 match /weather (.+)/, :use_prefix => false
 def execute(m, zipcode)
  m.reply `curl --silent 'http://xml.weather.yahoo.com/forecastrss?p=#{zipcode}&u=f' | grep -E '(Current Conditions:|F<BR)' | sed -e 's/Current Conditions://' -e 's@<br />@@' -e 's/<b>//' -e 's@</b>@@' -e 's@<BR />@@' -e 's/<description>//' -e 's@</description>@@' | tail -n 1`
 end
end
$plugins.push(Weather)
