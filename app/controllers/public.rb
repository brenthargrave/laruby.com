class Public < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  def index
     @rss_feed = RSSFeed.new(:laruby)
    render
  end
  
end
