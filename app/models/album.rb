class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs

  def artist_name
    artist.name
  end
end
