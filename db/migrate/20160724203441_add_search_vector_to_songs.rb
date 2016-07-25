class AddSearchVectorToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :search_vector, 'tsvector'

    execute <<-SQL
      CREATE INDEX songs_search_idx
      ON songs
      USING gin(search_vector);
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS songs_search_vector_update
      ON songs;
      CREATE TRIGGER songs_search_vector_update
      BEFORE INSERT OR UPDATE
      ON songs
      FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger (search_vector, 'pg_catalog.english', title);
    SQL

    Song.find_each { |p| p.touch }
  end

  def down
    remove_column :songs, :search_vector
    execute <<-SQL
      DROP TRIGGER IF EXISTS songs_search_vector_update on songs;
    SQL
  end
end
