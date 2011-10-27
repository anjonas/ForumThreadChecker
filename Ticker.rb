require 'nokogiri'
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
    doc = NokoGiri::HTML(RestClient.get(url))
    #Parse doc for new posts in thread or for a new page 
  end
end
			 