require 'rails_helper'

def add_user_to_db
  User.create(username: 'test_user', password: 'pswd')
end

describe User, type: :model do
  after(:all) { User.delete_all }
  it 'should validate a normal user' do
    User.create(username: 'user', password: 'pswd')
  end

  it 'should not validate a user with mismatching confirmation' do
    user = User.new(username: 'test_user', password: 'pswd', password_confirmation: 'dwsp')
    expect(user).not_to be_valid
  end

  it 'should not validate non-unique username' do
    add_user_to_db
    match_name = User.new(username: 'test_user', password: 'pswd')
    expect(match_name).not_to be_valid
  end
end

