class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist


  def artist_name
    artist.name
  end

  def album_title
    album.title
  end
end
