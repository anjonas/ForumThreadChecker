Shoes.app do
  class Actions
    @myApp
    def initialize(myApp)
	  @myApp = myApp
	end
	
	def startChecker(url)
	  @myApp.app do
		alert "Parsing..."
	    check_url = url.scan(/forum.bodybuilding.com/)
		if check_url != []
		  alert "Starting Checker"
		  Ticker.new(1, url)
	      Ticker.startTicker
		else
		  alert "Cannot use Checker for that page"
	    end
	  end
	end
  end
  
  stack do
    @myActions = Actions.new(self)
    url = edit_line
	
	button "Start ThreadChecker" do
	  @myActions.startChecker(url.text)
	end
  end
end
