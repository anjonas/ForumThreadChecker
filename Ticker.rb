require 'nokogiri'
require 'rubygems'
require 'rest_client'


class Ticker
  def initialize(minutes, url)
    @minutes = minutes
    @url = url
  end
	
	
  def start_ticker()
    ticker()
  end

  def ticker()
  
    loop do
      sleep(@minutes*60)
      checkSite()
    end
  end

  def check_site()
    doc = Nokogiri::HTML(RestClient.get("http://forum.bodybuilding.com/showthread.php?t=139217483"))
	puts doc 
  end
end

def test
  ticker = Ticker.new(1, "lol")
  ticker.check_site
  puts "testing"
end

test
			 