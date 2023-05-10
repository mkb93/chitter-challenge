require_relative 'users'

class UsersRepository
  def all
    sql = 'SELECT * FROM users;'
    params = []
    result_set=DatabaseConnection.exec_params(sql,params)
    users = [];
    result_set.each do |part|
      user = User.new(part['username'], part['full_name'])
      user.id = part['id']
      users << user
    end
    users
  end
  def find(id)
    sql = 'SELECT * FROM users WHERE id = $1;'
    params = [id]
    result_set=DatabaseConnection.exec_params(sql,params)[0]
    user = User.new(result_set['username'], result_set['full_name'])
    user.id = result_set['id']
    user
  end

end