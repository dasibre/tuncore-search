class Library
	class << self
		def search(query)
			Song.text_search(query)
		end
	end
end
