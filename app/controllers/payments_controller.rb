class PaymentsController < ApplicationController

	def create
		token = params[:stripeToken]
		@product = find.params[:product_id]
		@user = current_user
		# Create the charge on Stripe's servers - this will charge the user's card
		begin
			charge = Stripe::Charge.create(
				:amount => @product.pricing.to_i*100, #price to cents, integer
				:currency => "usd",
				:source => token,
				:description => params[:stripeEmail]
				)

			if charge.paid
				Order.create(
					:product_id => @product,
					:user_id => @user,
					:total => @product.pricing
					)

				flash[:success] = "Payment Successful"
				redirect_to "payments/create.html.erb"
			end
				
		rescue Stripe::CardError => e
			# The card has been declined
			body = e.json_body
			err = body[:error]
			flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
			redirect_to @payments.create
		end
	end

end
