require 'users'
require 'users_repository'
require 'spec_helper'
require 'bcrypt'
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
    it 'tests if it finds no object' do
      repo = UsersRepository.new.find_username('user0')
      expect(repo).to eq nil 
    end
  end
  context 'find_email method' do
    it 'tests if it finds the correct object' do
      repo = UsersRepository.new.find_email('john@hotmail.com')
      expect(repo.email).to eq 'john@hotmail.com' 
    end
    it 'tests if it finds no object' do
      repo = UsersRepository.new.find_email('user0')
      expect(repo).to eq nil 
    end
  end
  context 'create method' do
    it 'tests if it creates a new user' do
      repo = UsersRepository.new
      expect(repo.all.length).to eq 2
      user = User.new('strange', 'adolfo strange', 'adolfo@email.com', 'password')
      repo.create(user)
      expect(repo.all.length).to eq 3
      expect(repo.all.last.username).to eq 'strange'
    end
  end
  context 'delete method' do
    it 'tests if it creates a new user' do
      repo = UsersRepository.new
      expect(repo.all.length).to eq 2
      user = User.new('strange', 'adolfo strange', 'adolfo@email.com', 'password')
      repo.create(user)
      expect(repo.all.length).to eq 3
      expect(repo.all.last.username).to eq 'strange'
      repo.delete(repo.all.last)
      expect(repo.all.length).to eq 2
    end
  end
  context 'sign in method' do
    it 'tests if it signs in gives true and false results accurately' do
      users = UsersRepository.new
      user = User.new('strange', 'adolfo strange', 'adolfo@email.com', 'password')
      expect(users.all.length).to eq 2
      users.create(user)
      expect(users.all.length).to eq 3
      result =users.login('adolfo@email.com', 'password')
      expect(result).to eq true
    
    end
    it 'tests that the first two users have encrypted passwords' do
      users = UsersRepository.new
      user = users.find_username('user1')
      expect(users.login(user.email, user.password)).to eq true
    end
  end
end