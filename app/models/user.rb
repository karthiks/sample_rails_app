class User < ActiveRecord::Base
  attr_accessor :password  # is not a column in the DB and so these field is required
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true, 
                   :length => { :maximum => 25 },
                   :uniqueness => { :scope => :email }

  validates :email, :presence => true,
                    :format => { :with => email_regex }

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..20 }

  before_save :encrypt_password

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def has_password?(submitted_password) 
    encrypted_password == encrypt(submitted_password)
  end
  
  private

  def encrypt_password 
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string) 
    secure_hash "#{salt}--#{string}"
  end

  def secure_hash(string) 
    Digest::SHA2.hexdigest(string)
  end

  def make_salt 
    secure_hash "#{Time.now.utc}--#{password}"
  end 
end
