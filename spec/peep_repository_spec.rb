require 'peep'
require 'peep_repository'

def reset_albums_table
  seed_sql = File.read('spec/seeds_peeps.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_db_test' })
  connection.exec(seed_sql)
end
describe PeepRepository do
  before(:each) do 
    reset_albums_table
  end
  context 'all method' do
    it 'tests if all returns an array' do
      repo = PeepRepository.new.all
      expect(repo.is_a?(Array)).to eq true
      expect(repo.length).to eq 2
    end
  end
  context 'find method' do
    it 'tests if find returns the correct file' do
      repo = PeepRepository.new
      found = repo.find(1)
      expect(found.user_id).to eq '1'
    end
  end
  context 'create method' do
    it 'tests if a new peep can be created' do
      repo = PeepRepository.new
      expect(repo.all.length).to eq 2
      peep = Peep.new('peeping', '1')
      repo.create(peep)
    end
  end
end