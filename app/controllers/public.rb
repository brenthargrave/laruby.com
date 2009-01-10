class Public < Application
  
  def index
    @rss_feed = RSSFeed.new(:laruby)
    
    @calendar = Calendar.new(:laruby)
    @meetups = @calendar.events_by_start
    @next_meetup = @meetups.first
    
    render
  end
  
end
