class User
  attr_accessor :id, :username, :full_name, :email
  def initialize(username, full_name, email)
    @username =username
    @full_name = full_name
    @email = email
  end
end