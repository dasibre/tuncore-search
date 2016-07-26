class Library
	class << self
		def all
			Song.all
		end
		
		def search(query)
			Song.text_search(query)
		end
	end
end