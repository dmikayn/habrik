class Post < ApplicationRecord
  belongs_to :comment, optional: true # root comment
  before_save :create_root_comment
  before_destroy :destroy_root_comment
  validates_presence_of :title, :body
  belongs_to :user

  def get_comments
    comment.subtree
  end

  private

  def create_root_comment
    self.comment = Comment.create(user: user, comment_id: nil, contents: 'root')
  end

  def destroy_root_comment
    comment.destroy
  end
end
