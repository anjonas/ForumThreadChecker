require 'ruby_gntp'

class Notify
  def initialize()
    @growl = GNTP.new("ForumThreadChecker")
	@growl.register({:notifications => [{
    :name     => "notify",
    :enabled  => true,
    }]})
  end
  
  def send_message(message)
    @growl.notify({
            :name  => "notify",
            :title => "New Posts",
            :text  => message,
            :icon  => "http://www.hatena.ne.jp/users/sn/snaka72/profile.gif&quot;",
            :sticky=> true,
          })
  end
end