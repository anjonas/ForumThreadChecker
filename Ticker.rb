require 'nokogiri'
require 'open-uri'


class Ticker
	 def initialize(minutes, url)
	 	@minutes = minutes
	  	@url = url
	 end
	
	
	def startTicker()
		ticker()
	end

	def ticker()
		loop do
			startTime =  Time.now
			currentTime = Time.now

			while (currentTime - startTime) < minutes do
				currentTime = Time.now
			end

			checkSite()
		end
	end

	def checkSite()
		doc = NokoGiri::HTML(open(url))
		#Parse doc for new posts in thread or for a new page 
	end
end		

			 