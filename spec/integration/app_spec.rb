require "spec_helper"
require "rack/test"
require_relative '../../app'
require "peep_repository"
require "users_repository"


def reset_table
  seed_sql = File.read('spec/seeds_peeps.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_db_test' })
  connection.exec(seed_sql)
end
describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
  
  before(:each) do 
    reset_table
  end
  context "GET /" do
    it "gets 200 ok" do
      response = get("/")
      expect(response.status).to eq 200
      expect(response.body).to include "Welcome"
    end
  end
  context "GET /new_user" do
    it "gets 200 ok" do
      response = post("/new_user", fullname: 'james')
      expect(response.status).to eq 200
      expect(response.body).to include ""
    end
  end
end