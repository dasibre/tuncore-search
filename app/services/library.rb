class Library
	class << self
		def all
			Song.all
		end
		
		def search(query)
			sanitized = sanitize_sql(["to_tsquery('english', ?)", query.downcase.gsub(/\s/, "|")])
			Song.joins(:artist, :album).where("songs.search_vector @@ #{sanitized} or artists.search_vector @@ #{sanitized} or albums.search_vector @@ #{sanitized}")
		end

		private

		def sanitize_sql(arry_str)
			ActiveRecord::Base.send(:sanitize_sql_array, arry_str)
		end
	end
end