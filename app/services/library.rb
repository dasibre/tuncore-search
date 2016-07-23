class Library
	class << self
		def search(query)
			songs = Song.text_search(query)
			artists = Artist.text_search(query)
			albums = Album.text_search(query)
			results = songs.concat(artists.concat(albums)).uniq
		end
	end
end