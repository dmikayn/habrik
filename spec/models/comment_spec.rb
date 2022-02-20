require 'rails_helper'

def add_comment_to_db
  Comment.create(contents: 'CONTENTS', user: add_user_to_db, comment: add_post_to_db.comment)
end

describe Post, type: :model do
  it 'should validate a normal comment' do
    expect(Comment.new(contents: 'contents', user: add_user_to_db, comment: add_post_to_db.comment)).to be_valid
  end
  
  it 'should not validate an empty comment' do
    expect(Comment.new).not_to be_valid
  end

  it 'should retrieve child comments' do
    Comment.create(contents: 'RESPONSE', user: add_user_to_db, comment: add_comment_to_db)
    st = Post.last.comment.subtree
    expect(st.to_s).to include('CONTENTS')
    expect(st.to_s).to include('RESPONSE')
  end
end