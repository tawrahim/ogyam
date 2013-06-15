class User < ActiveRecord::Base
  attr_accessible :bio, :email, :image_url, :location, :name,
    :password, :password_confirmation
  
  has_secure_password

  before_save :downcase_email 

  VALID_REGEX = /\A[\w+@\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_digest, presence: true

  private
    def downcase_email
      self.email.downcase 
    end
end

