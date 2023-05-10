require_relative 'peep'

class PeepRepository

  # Selecting all records
  # No arguments
  def all
   sql = 'SELECT * FROM peeps;'
   params =[]
   result_set = DatabaseConnection.exec_params(sql, params)
   peeps = []
   result_set.each do |result|
    peep = Peep.new(result['content'], result['user_id'])
    peep.time_made = result['time_made']
    peep.id = result['id']
    peeps << peep
    end
  peeps
  end
  def find(id)
    sql = 'SELECT * FROM peeps WHERE id = $1;'
    params = [id]
    result_set=DatabaseConnection.exec_params(sql,params)[0]
    peep = Peep.new(result_set['content'], result_set['user_id'])
    peep.id = result_set['id']
    peep.time_made = result_set['time_made']
    peep
   end
   def create(peep)
    sql = 'INSERT INTO peeps (content, user_id, time_made) VALUES ($1, $2, $3);'
    DatabaseConnection.exec_params(sql, [peep.content, peep.user_id, peep.time_made])
    peep
   end
   def delete(peep)
    sql = 'DELETE FROM peeps WHERE id = $1;'
    DatabaseConnection.exec_params(sql,[peep.id])

   end
end