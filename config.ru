ENV['USERNAME'] = "laxruby"
ENV['RUBYLIB'] = "/home/#{ENV['USERNAME']}/local/lib/ruby/site_ruby/1.8"
ENV['GEM_PATH'] = "/home/#{ENV['USERNAME']}/local/lib/ruby/gems/1.8"
ENV["RACK_ENV"] = "production"


require 'rubygems'

#
# There were a few problems on loading merb-core at the first time after Passenger pid has been killed. 
# These codes below were added to fix.
#

["/home/#{ENV['USERNAME']}/gems/abstract-1.0.0/bin", 
"/home/#{ENV['USERNAME']}/gems/abstract-1.0.0/lib", 
"/home/#{ENV['USERNAME']}/gems/erubis-2.6.2/bin", 
"/home/#{ENV['USERNAME']}/gems/erubis-2.6.2/lib", 
"/home/#{ENV['USERNAME']}/gems/json_pure-1.1.3/bin", 
"/home/#{ENV['USERNAME']}/gems/json_pure-1.1.3/lib", 
"/home/#{ENV['USERNAME']}/gems/rspec-1.1.8/bin", 
"/home/#{ENV['USERNAME']}/gems/rspec-1.1.8/lib", 
"/home/#{ENV['USERNAME']}/gems/mime-types-1.15/bin", 
"/home/#{ENV['USERNAME']}/gems/mime-types-1.15/lib", 
"/home/#{ENV['USERNAME']}/gems/merb-core-0.9.9/bin", 
"/home/#{ENV['USERNAME']}/gems/merb-core-0.9.9/lib"].each do |path|
  $LOAD_PATH << path
end

require 'merb-core'

#
# For some reason when merb tries to load under Passanger on Dreamhost
# it fails, a NoMethod Errors is thrown for Time#to_date
# The Below code fixes that.
#
class Time
  attr_accessor :to_date
end


Merb::Config.setup(:merb_root => ".", :environment => ENV["RACK_ENV"])
                   
Merb.environment = Merb::Config[:environment]

Merb.root = Merb::Config[:merb_root]

Merb::BootLoader.run

run Merb::Rack::Application.new
