require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'Validation test' do

    it 'ensures first name presence' do
      user = User.new(password: "password").save
      expect(user).to eq(false)
      user2 = User.new(username: "username", password: "password").save
      expect(user2).to eq(true)
    end

    it 'ensures username has valid length' do
      user = User.new(username: "12", password: "password").save
      expect(user).to eq(false)
      user2 = User.new(username: "123456789012345678901234", password: "password").save
      expect(user2).to eq(false)
      user3 = User.new(username: "12345", password: "password").save
      expect(user3).to eq(true)
    end
    
    it 'ensures usernames are unique' do
      user = User.new(username: "username", password: "password").save
      expect(user).to eq(true)
      user2 = User.new(username: "username", password: "password2").save
      expect(user2).to eq(false)
    end

    it 'ensures username regex' do
      user = User.new(username: "asdasd", password: "password").save
      expect(user).to eq(true)
      user2 = User.new(username: "asd**()asd", password: "password").save
      expect(user2).to eq(false)
      user3 = User.new(username: "123asdasd123", password: "password").save
      expect(user3).to eq(true)
    end

    it 'ensures username is not case sensitive' do
      username = "AsdASdASd"
      user = User.new(username: username, password: "password")
      user.save
      expect(user.username).to eq(username.downcase)
    end

    it 'ensures password presence' do
      user = User.new(username: "username").save
      expect(user).to eq(false)
      user2 = User.new(username: "username", password: "password").save
      expect(user2).to eq(true)
    end

    it 'ensures salt presence' do
      user = User.new(username: "username", password: "password")  
      user.save
      expect(user.salt).to_not eq(nil)
    end

    it 'has encrypted password' do
      password = "password"
      user = User.new(username:"username", password: password)
      user.save
      expect(user.valid_password?(password)).to eq(true)  
      expect(user.valid_password?("not password")).to eq(false)  
    end

    it 'ensures loging attempts start at 0' do
      user = User.new(username:"username", password: "password")
      user.save
      expect(user.login_failure_count).to eq(0)  
    end

    it 'ensures loging attempts reset' do
      user = User.new(username:"username", password: "password")
      user.save
      user.incorrect_login_attempt
      user.reset_login_attempts
      expect(user.login_failure_count).to eq(0)  
    end

    it 'ensures loging attempts increment' do
      user = User.new(username:"username", password: "password")
      user.save
      user.incorrect_login_attempt
      expect(user.login_failure_count).to eq(1)  
    end

    it 'gets correct user given username' do
      user = User.new(username:"username", password: "password")
      user.save
      query_user = User.get_user("username")
      expect(query_user.id).to eq(user.id)
      expect(query_user.id + 1).to_not eq(user.id)  
    end

  end

end
