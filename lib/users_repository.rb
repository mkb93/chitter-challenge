require_relative 'users'

class UsersRepository
  def all
    sql = 'SELECT * FROM users;'
    params = []
    result_set=DatabaseConnection.exec_params(sql,params)
    users = [];
    result_set.each do |part|
      user = User.new
      user.id = part['id']
      user.username = part['username']
      user.full_name = part['full_name']
      users << user
    end
    users
  end
  def find(id)
    sql = 'SELECT * FROM users WHERE id = $1;'
    params = [id]
    result_set=DatabaseConnection.exec_params(sql,params)
    user = User.new
    user.id = result_set[0]['id']
    user.username = result_set[0]['username']
    user.full_name = result_set[0]['full_name']
    user
  end
  
end