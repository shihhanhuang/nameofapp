class PaymentsController < ApplicationController

	def create
		logger.debug("called payments#create")
		@product = Product.find(params[:product_id])
		@user = current_user
		token = params[:stripeToken]
		# Create the charge on Stripe's servers - this will charge the user's card
		begin
			charge = Stripe::Charge.create(
				:amount => @product.pricing.to_i*100, #price to cents, integer
				:currency => "usd",
				:source => token,
				:description => params[:stripeEmail]
				)

			logger.debug(charge)
			if charge.paid
				logger.debug("charge is paid")
				Order.create(
					:product_id => @product,
					:user_id => @user,
					:total => @product.pricing
					)

				flash[:notice] = "Payment Successful"
				redirect_to product_path(@product)
			end
				
		rescue Stripe::CardError => e
			# The card has been declined
			body = e.json_body
			err = body[:error]
			flash[:alert] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
			redirect_to product_path(@product)
		end
	end

end
