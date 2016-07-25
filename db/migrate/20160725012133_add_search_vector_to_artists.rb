class AddSearchVectorToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :search_vector, 'tsvector'

    execute <<-SQL
      CREATE INDEX artists_search_idx
      ON artists
      USING gin(search_vector);
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS artists_search_vector_update
      ON artists;
      CREATE TRIGGER artists_search_vector_update
      BEFORE INSERT OR UPDATE
      ON artists
      FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger (search_vector, 'pg_catalog.english', "name");
    SQL

    Artist.find_each { |p| p.touch }
  end

  def down
    remove_column :artists, :search_vector
    execute <<-SQL
      DROP TRIGGER IF EXISTS artists_search_vector_update on artists;
    SQL
  end
end
