class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist

  class << self
    def text_search(query)
      if query.nil?
        Song.all.all
      else
        joins(:artist, :album).where("songs.search_vector @@ #{sanitize_query(query)} or artists.search_vector @@ #{sanitize_query(query)} or albums.search_vector @@ #{sanitize_query(query)}")
      end
    end

    private

    def sanitize_query(query)
      sanitize_sql_array(["to_tsquery('english', ?)", query.downcase.gsub(/\s/, "|")])
    end
  end

  def artist_name
    artist.name
  end

  def album_title
    album.title
  end
end
