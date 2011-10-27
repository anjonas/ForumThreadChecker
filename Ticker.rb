require "nokogiri"
require "rest-client"

class Ticker
  def initialize(minutes, url)
    @minutes = minutes
    @url = url
  end

  def start_ticker
    ticker
  end

  def ticker
    loop do
      sleep(@minutes * 60)
      check_site
    end
  end

  def check_site
    doc = Nokogiri::HTML(RestClient.get(url))
  end
end