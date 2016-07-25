# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require 'rspotify'
# elton_john = Artist.create!(name: 'Elton John')
# lion_king = Album.create!(title: 'Lion King Sound track', artist: elton_john)
# Song.create!(title: 'Hakuna Matata', album: lion_king, artist: elton_john)

# ARTISTS = ['Elton John', 'Usher', 'Nas', 'Bob Marley', 'The Eagles', 'Erykah Badu', 'Sting', 'Tina Turner', 'Michael Jackson', 'James Brown']
#
#
# @data = Hash.new {|artist_hsh,aname| artist_hsh[aname] = Hash.new }
#
# def build_music_data(artist_name)
# 	artist = RSpotify::Artist.search(artist_name).first
# 	artist.albums.each do |album|
# 		@data[artist_name][album.name] = album.tracks.map(&:name)
# 	end
# end
#
# ARTISTS.each do |artist|
# 	build_music_data(artist)
# end
#
# File.open('db/data.json', 'w') {|f| f.write @data.to_json }

music_data = ActiveSupport::JSON.decode(File.read( "#{File.dirname(__FILE__)}/data.json"))

music_data.each do |artist_name,album_key|
	artist = Artist.create!(name: artist_name)
	album_key.each do |name,tracks|
		break if Album.count == 100
		album = Album.create!(title: name, artist: artist)
		tracks.each do |track|
			break if Song.count == 500
			Song.create!(title: track, album: album, artist: artist)
		end
	end
end
