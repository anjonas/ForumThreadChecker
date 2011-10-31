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
	last_page = 0
    doc = Nokogiri::HTML(RestClient.get(@url))
	
	link = doc.css('span/a[@class = "popupctrl"]') #.each do |link|
	  page =  link.text.scan /[-+]?\d*\.?\d+/
	  if ((@url + "&" + page[1]) != @url)
	    @url = @url + "&page=" + page[1]
		puts "url changed"
	  end
	  puts @url
	
	
	doc.css('a.postcounter').each do |node|
	  count = count + 1
	end
	puts count
	
  end
  
end

def test
  ticker = Ticker.new(1, "http://forum.bodybuilding.com/showthread.php?t=139153723")
  ticker.check_site
  ticker.check_site
end

test
			 