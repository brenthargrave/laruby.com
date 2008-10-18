require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class RSS::Rss
  def to_html
    max_description_length = 1024

    html = String.new
    html << "<div id=\"rss-content\">"
    html << "<small>Updated on #{channel.date.strftime('%m/%d/%Y')}</small>" \
            if channel.date
    html << "<p>#{channel.description}</p>"
    html << "<ol>"

    channel.items.each do |i|
      html << "<li><strong><a href='#{i.link}'>#{i.title}</a></strong><br/>"
      html << "<small>Added on #{i.date.strftime("%m/%d/%Y")} at \
#{i.date.strftime("%I:%M%p")}</small><br/>" if i.date
      desc_text = i.description.gsub(/<[^>]+>/,"").squeeze(" ").strip
      if desc_text.length > max_description_length
        desc_text = desc_text[0,max_description_length] + "&hellip;"
      else
        desc_text = i.description
      end
      html << "#{desc_text}"
      html << "</li>"
    end

    html << "</ol>"
    html << "</div>"
    html
  end
end

class RSSFeed
  FEED = {
    :laruby => "http://rss.groups.yahoo.com/group/LARuby/rss"
  } 
  
  def initialize(feed_name)
    content = "" # raw content of rss feed will be loaded here
    open(feed_url(feed_name)) {|s| content = s.read }
    @rss = RSS::Parser.parse(content, false)
  end
  
  def feed_url(feed_name)
    FEED[feed_name.to_sym]
  end
  
  def to_html
    @rss.to_html
  end
end
