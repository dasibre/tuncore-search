class AddSearchVectorToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :search_vector, 'tsvector'

    execute <<-SQL
      CREATE INDEX albums_search_idx
      ON albums
      USING gin(search_vector);
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS albums_search_vector_update
      ON albums;
      CREATE TRIGGER albums_search_vector_update
      BEFORE INSERT OR UPDATE
      ON albums
      FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger (search_vector, 'pg_catalog.english', title);
    SQL

    Album.find_each { |p| p.touch }
  end

  def down
    remove_column :albums, :search_vector
    execute <<-SQL
      DROP TRIGGER IF EXISTS albums_search_vector_update on albums;
    SQL
  end
end
