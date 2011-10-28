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
	count = 0
    docc = Nokogiri::HTML(RestClient.get("http://forum.bodybuilding.com/showthread.php?t=113190661"))
	docc.css('span/a[@class = "popupctrl"]').each do |link|
	  puts link.text
	  #Trying to get the page counter, but I also get a lot of junk
	end
	doc = Nokogiri::HTML(RestClient.get(@url))
	doc.css('a.postcounter').each do |node|
	  count = count + 1
	end
	puts count
  end
end

def test
  ticker = Ticker.new(1, "http://forum.bodybuilding.com/showthread.php?t=139217483")
  ticker.check_site
  puts "testing"
end

test
			 