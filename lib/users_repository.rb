require_relative 'users'

class UsersRepository
  def all
    sql = 'SELECT * FROM users;'
    params = []
    result_set=DatabaseConnection.exec_params(sql,params)
    users = [];
    result_set.each do |part|
      user = User.new(part['username'], part['full_name'], part['email'])
      user.id = part['id']
      users << user
    end
    users
  end
  def find(id)
    sql = 'SELECT * FROM users WHERE id = $1;'
    params = [id]
    result_set=DatabaseConnection.exec_params(sql,params)[0]
    user = User.new(result_set['username'], result_set['full_name'], result_set['email'])
    user.id = result_set['id']
    user
  end
  def find_username(str)
    sql = 'SELECT * FROM users WHERE username = $1;'
    params = [str]
    result=DatabaseConnection.exec_params(sql,params)
    if result[0]['id'].to_i>0
      result_set = result[0]
    user = User.new(result_set['username'], result_set['full_name'],result_set['email'])
    user.id = result_set['id']
    return user
    else
      return nil
    end
  end
  def find_email(str)
    sql = 'SELECT * FROM users WHERE email = $1;'
    params = [str]
    result=DatabaseConnection.exec_params(sql,params)[0]
    if result.length >0
      result_set = result[0]
    user = User.new(result_set['username'], result_set['full_name'], result_set['email'])
    user.id = result_set['id']
    return user
    else
      return nil
    end
  end
  def create(user)
    sql = 'INSERT INTO users (username, full_name, email) VALUES ($1,$2, $3)'
    DatabaseConnection.exec_params(sql,[user.username, user.full_name, user.email])
    return user 
  end

  def delete(user)
    sql = 'DELETE FROM users WHERE id = $1;'
    DatabaseConnection.exec_params(sql,[user.id])
  end
end