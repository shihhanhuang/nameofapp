class UserMailer < ApplicationMailer
	default from: "from@example.com"

	def contact_form(email, name, message)
		@message = message
			mail(:from => email,
					:to => 'shihhan.huang@gmail.com',
					:subject => "Benibeni App contact from #{name}")
	end

	def welcome(user)
		@appname = "Berlin Bikes"
		mail( :to => user.email,
					: subject => "Welcome to #{@appname}!")
	end
			
end
