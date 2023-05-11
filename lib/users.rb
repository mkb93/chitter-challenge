class User
  attr_accessor :id, :username, :full_name, :email, :password
  def initialize(username, full_name, email, password)
    @username =username
    @full_name = full_name
    @email = email
    @password = password
  end
end