class Calendar  
  ICAL = {
    # http://www.google.com/calendar/ical/up437j171tsavlnammjrbnbpak%40group.calendar.google.com/public/basic.ics
    :laruby => "http://www.google.com/calendar/ical/laruby.com_ohffusb1f8u53j0ord0jlnpqm8%40group.calendar.google.com/public/basic.ics"
  }
  
  def initialize(ical_name)
    uri = URI.parse(ical_url(ical_name))
    ics_file = uri.read
    @calendar = Icalendar.parse(ics_file).first
  end
  
  def ical_url(calendar_name)
    ICAL[calendar_name.to_sym]
  end
  
  def events
    @calendar.events
  end
  
  def events_by_start
    @calendar.events.sort { |x,y| y.start <=> x.start }
  end
  
end


class Icalendar::Event
  
  def localized_start(timezone=nil)
    timezone ||= 'America/Los_Angeles'
    utc_start = self.start
    TZInfo::Timezone.get(timezone).utc_to_local(utc_start)
  end
  
  def pretty_date
    self.localized_start.strftime("%A, %b %d, %Y")
  end
  
  def pretty_time
    self.localized_start.strftime("%l:%M %p")
  end
  
  def pretty_datetime
    self.localized_start.strftime("%A, %b %d, %Y %l:%M %p")
  end
  
  def business
    self.location.match(/\(.*\)/)[0].gsub(/(\(|\))/,'')
  end
  
  def address
    self.location.match(/\(.*\)/).pre_match.strip
  end
  
  def street
    self.address.match(/,/).pre_match.strip
  end
  
  def city_state
    self.address.match(/,/).post_match.strip
  end
  
end