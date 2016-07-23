class Artist < ActiveRecord::Base
	has_many :albums
	has_many :songs

	def self.text_search(query)
		includes(:albums,:songs).where('name LIKE ?', "%#{query}%")
	end
end
