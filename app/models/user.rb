class User < ApplicationRecord
	before_save :ba_duong_vlog
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: true
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	def ba_duong_vlog
		self.email = email.downcase
	end
end