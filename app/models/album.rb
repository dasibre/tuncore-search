class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs

  def self.text_search(query)
    includes(:artist).where('title LIKE ?', "%#{query}%")
  end
end
