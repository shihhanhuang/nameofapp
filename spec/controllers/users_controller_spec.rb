require 'rails_helper'

describe UsersController, :type => :controller do

	let(:user) { User.create!(email: 'example2@example.com', password: 'geocities' )}
	let(:next_user) { User.create!(email: 'anotheruser@gmail.com', password: '12345678')}

	describe 'GET #show' do
		
		context 'User is logged in' do
			before do
		 		sign_in user
		 	end

		 	it 'loads correct user details' do
		 		get :show, id: user.id
		 		expect(response).to have_http_status(200)
		 		expect(assigns(:user)).to eq user
			end
		end	

		context 'No user is logged in' do
			it 'redirects to login' do
				get :show, id: user.id
				expect(response).to redirect_to(root_path)
			end
		end
	end

end