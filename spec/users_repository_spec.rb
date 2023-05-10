require 'users'
require 'users_repository'

def reset_table
  seed_sql = File.read('spec/seeds_peeps.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_db_test' })
  connection.exec(seed_sql)
end

describe UsersRepository do
  before(:each) do 
    reset_table
  end
  context 'all method' do
    it 'tests if all returns an array' do
      repo = UsersRepository.new.all
      expect(repo.is_a?(Array)).to eq true
      expect(repo.length).to eq 2
    end
  end
  context 'find method' do
    it 'tests if it finds the correct object' do
      repo = UsersRepository.new.find(1)
      expect(repo.username).to eq 'user1' 
    end
  end
end