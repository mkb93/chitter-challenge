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
    peep = Peep.new
    peep.time_made = result['time_made']
    peep.content = result['content']
    peep.user_id = result['user_id']
    peep.id = result['id']
    peeps << peep
    end
  peeps
  end
end