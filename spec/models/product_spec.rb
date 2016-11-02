require 'rails_helper'

describe Product do

before do
	#here you put your code to generate test content
	@product = Product.create!(name: "race bike")
	@user = User.create!(email: "example1@gmail.com", password: "1234567")
	@product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
	@product.comments.create!(rating: 3, user: @user, body: "Average bike.")
	@product.comments.create!(rating: 5, user: @user, body: "Awesome bike!")
end

it "should return the average rating of all comments" do
	expect(@product.average_rating).to eq 3
end

context "it is not valid" do
	let(:product) { Product.new(description: "Nice bike") }

	it "should not be valid" do
		expect(Product.new(description: "Nice bike")).not_to be_valid
	end
end
	
end