require 'rails_helper'

def add_post_to_db
  Post.create(title: 'title', body: 'body', user: add_user_to_db)
end

describe Post, type: :model do
  it 'should validate a normal post' do
    expect(Post.new(title: 'title', body: 'body', user: add_user_to_db)).to be_valid
  end

  it 'should create a root comment when created' do
    expect(add_post_to_db.comment).not_to be nil
  end

  it 'should not validate empty posts' do
    expect(Post.new).not_to be_valid
  end
end