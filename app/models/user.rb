class User < ActiveRecord::Base
  attr_accessible :bio, :email, :image_url, :location, :name,
    :password, :password_confirmation
  
  has_secure_password

  before_save :downcase_email 
  before_save :add_gravatar
  before_save :create_remember_token

  VALID_REGEX = /\A[\w+@\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_digest, presence: true

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    self.save!(validate: false)
    UserMailer.password_reset(self).deliver  
  end

  private
    def downcase_email
      self.email.downcase 
    end

    def gravatar_for(user)
      default_url = "https://still-shore-2532.herokuapp.com/assets/avatar.png"
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=44&d=#{CGI.escape(default_url)}" 
    end

    def add_gravatar
      self.image_url = gravatar_for(self) 
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64 
    end
end

