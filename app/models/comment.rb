class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: "parent_id", dependent: :destroy
  validates :content, presence: true, length: { maximum: 200 }
  # has_rich_text :content
  # default_scope { order(created_at: :desc)}
end
