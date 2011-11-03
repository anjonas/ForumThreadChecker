require 'nokogiri'
require 'rubygems'
require 'rest_client'
require 'ruby_gntp'


class Ticker
  def initialize(minutes, base_url)
    @minutes = minutes
    @base_url = base_url
	@url = base_url
	@growl = GNTP.new("ForumThreadChecker")
    @growl.register({:notifications => [{
    :name     => "notify",
    :enabled  => true,
    }]})
  end
	
	
  def start_ticker()
    ticker()
  end

  def ticker()
    posts_then = 0
    loop do
      check_site() {|posts_now, new_page|
	    if new_page != 0
		  @growl.notify({
            :name  => "notify",
            :title => "New Posts",
            :text  => "New Page and new posts in thread",
            :icon  => "http://www.hatena.ne.jp/users/sn/snaka72/profile.gif&quot;",
            :sticky=> true,
          })
		  posts_then = 1
	      elsif posts_now != posts_then
	        @growl.notify({
              :name  => "notify",
              :title => "New Posts",
              :text  => "New posts in thread",
              :icon  => "http://www.hatena.ne.jp/users/sn/snaka72/profile.gif&quot;",
              :sticky=> true,
            })
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
  ticker = Ticker.new(1, "http://forum.bodybuilding.com/showthread.php?t=139374723")
  ticker.start_ticker
end

test
			 