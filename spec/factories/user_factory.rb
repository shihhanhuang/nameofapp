FactoryGirl.define do
	factory :user do
	sequence(:email) { |n| "person#{n}@example.com" }
    password "1234567890"
    first_name "shihhan"
    last_name "Example"
    admin false
	end
end