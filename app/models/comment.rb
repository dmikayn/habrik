class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :comment, optional: true # parent
  has_many :comments # children
  validates_presence_of :contents
  before_destroy :destroy_subtree

  def subtree(level = 0)
    ([
      comment.nil? ? nil : { comment: self, level: level }
    ] + comments.map do |current|
      current.subtree(level + 1)
    end).flatten.compact
  end

  def destroy_subtree
    comments.each(&:destroy)
  end
end
