class User
  attr_accessor :id, :username, :full_name
  def initialize(username, full_name)
    @username =username
    @full_name = full_name
  end
end