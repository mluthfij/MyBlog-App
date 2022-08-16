class Post < ApplicationRecord
    paginates_per 6
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one_attached :cover
    # has_rich_text :body
    default_scope { order(created_at: :desc)}
    validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    validates :body, presence: true, length: { minimum: 10, maximum: 300 }
end

