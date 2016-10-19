class StaticPagesController < ApplicationController
    before_filter :authenticate_user!

  def index
  	@products = Product.all
  end

  def landing_page
  	@products = Product.all
  end 

  def thank_you
  	@name = params[:name]
  	@email = params[:email]
  	@message = params[:message]
  	UserMailer.contact_form(@email, @name, @message).deliver_now
  end

end
