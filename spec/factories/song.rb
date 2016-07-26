FactoryGirl.define do
	factory :song do
		title 'Sacrifice'
		association :album
		association :artist
	end

	factory :album do
		title  'Elton'
		association :artist
	end

	factory :artist do
		name  'Elton John'
	end
end