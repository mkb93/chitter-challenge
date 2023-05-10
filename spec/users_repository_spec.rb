require 'users'
require 'users_repository'
require 'spec_helper'

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
  context 'find_username method' do
    it 'tests if it finds the correct object' do
      repo = UsersRepository.new.find_username('user1')
      expect(repo.username).to eq 'user1' 
    end
  end
  context 'create method' do
    it 'tests if it creates a new user' do
      repo = UsersRepository.new
      expect(repo.all.length).to eq 2
      user = User.new('strange', 'adolfo strange', 'adolfo@email.com')
      repo.create(user)
      expect(repo.all.length).to eq 3
      expect(repo.all.last.username).to eq 'strange'
    end
  end
  context 'delete method' do
    it 'tests if it creates a new user' do
      repo = UsersRepository.new
      expect(repo.all.length).to eq 2
      user = User.new('strange', 'adolfo strange', 'adolfo@email.com')
      repo.create(user)
      expect(repo.all.length).to eq 3
      expect(repo.all.last.username).to eq 'strange'
      repo.delete(repo.all.last)
      expect(repo.all.length).to eq 2
    end
  end
end