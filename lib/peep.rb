require 'date'
class Peep
  attr_accessor :id, :time_made, :content, :user_id 
  def initialize(content, user_id)
    @content = content
    @user_id = user_id
    current_time = DateTime.now
    @time_made = current_time
  end
end