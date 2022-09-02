class Post < ApplicationRecord
    paginates_per 6
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_rich_text :richbody
    default_scope { order(created_at: :desc)}
    validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    # validates :richbody, presence: true, length: { minimum: 10, maximum: 10000 }
    validates :richbody, presence: true, length: { minimum: 10, maximum: 10000 }
end

