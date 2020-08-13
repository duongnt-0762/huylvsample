module UsersHelper
	# Returns the Gravatar for the given user.
	def gravatar_for(user, options = { size: 200 })
		size = options[:size]
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
	#Returns gender
	def check_gender(user)
		# byebug
		if @user.gioi_tinh == 0
			 "Giới tính: Buê Đuê"
		elsif @user.gioi_tinh == 1
			 "Giới tính: Nam"	
		elsif @user.gioi_tinh == 2
			 "Giới tính: Nữ"	
		end	
	end
end