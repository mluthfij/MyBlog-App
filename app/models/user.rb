class User < ApplicationRecord
  before_save { self.username = username.downcase }
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        #  :confirmable

         has_many :posts, dependent: :destroy
         has_many :comments, dependent: :destroy
    
         # Avatar Attachment
         has_one_attached :avatar

         # Validation 
         validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
              file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }
           # only allow letter, number, underscore and punctuation.
      
         validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
        #  VALID_USERNAME_REGEX = /\A[a-z0-9_]{4,16}\z/
         validates :username, presence: true, 
                     uniqueness: { case_sensitive: false }, 
                     length: { minimum: 3, maximum: 25 }
                    #  format: { with: VALID_USERNAME_REGEX }
         VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
         validates :email, presence: true, 
                     uniqueness: { case_sensitive: false }, 
                     length: { maximum: 105 },
                     format: { with: VALID_EMAIL_REGEX }

  attr_writer :login
  validate :validate_username

  def login
    @login || username || email
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value",
      { value: login.downcase}]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  # def username
  #   #email = john@example.com -> ['john']
  #   return self.email.split('@')[0].capitalize
  # end
              
end
