class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist

  def self.text_search(query)
    includes(:artist,:album).where('title LIKE ?', "%#{query}%")
  end
end
