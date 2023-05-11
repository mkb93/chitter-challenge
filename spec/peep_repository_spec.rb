require 'peep'
require 'peep_repository'
require 'spec_helper'

describe PeepRepository do
  before(:each) do 
    reset_table
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
    it 'returns nil if file doesnt exist' do
      repo = PeepRepository.new
      found = repo.find(1000)
      expect(found).to eq nil
    end
  end
  context 'create method' do
    it 'tests if a new peep can be created' do
      repo = PeepRepository.new
      expect(repo.all.length).to eq 2
      peep = Peep.new('peeping', '1')
      repo.create(peep)
      expect(repo.all.length).to eq 3
      expect(repo.all.last.content).to eq 'peeping'
    end
  end
  context 'delete method' do
    it 'tests that a peep can be delete after it is posted' do
      repo = PeepRepository.new
      expect(repo.all.length).to eq 2
      peep = Peep.new('peeping', '1')
      repo.create(peep)
      expect(repo.all.length).to eq 3
      expect(repo.all.last.content).to eq 'peeping'
      repo.delete(repo.all.last)
      expect(repo.all.length).to eq 2
    end
  end
end