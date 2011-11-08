require 'nokogiri'
require 'rubygems'
require 'rest_client'
require 'ruby_gntp'
require_relative 'C:\Ruby\ForumThreadChecker\Notify.rb'



class Ticker
  def initialize(minutes, base_url)
    @minutes = minutes
    @base_url = base_url
	@url = base_url
    @note = Notify.new()
  end
	
	
  def start_ticker()
    ticker()
  end

  def ticker()
    posts_then = 0
    loop do
      check_site() {|posts_now, new_page|
	    if new_page != 0
		  @note.send_message("New Page and new posts in Thread")
		  posts_then = 1
	      elsif posts_now != posts_then
	        @note.send_message("New posts in Thread")
	        posts_then = posts_now
		end
	  }
	  sleep(@minutes*60)
    end
  end

  def check_site()
	count = 0
	last_page = 0
    doc = Nokogiri::HTML(RestClient.get(@url))
	
	link = doc.css('span/a[@class = "popupctrl"]')
	  page =  link.text.scan /[-+]?\d*\.?\d+/
	  if page != []
	    if ((@base_url + "&page=" + page[1]) != @url)
	      @url = @base_url + "&page=" + page[1]
		  last_page = 1
	    end
	  end
	doc.css('a.postcounter').each do |node|
	  count = count + 1
	end
	yield(count, last_page)
	
  end
  
end

def test
  ticker = Ticker.new(1, "http://forum.bodybuilding.com/showthread.php?t=139437963&page=1")
  ticker.start_ticker
end

test
			 