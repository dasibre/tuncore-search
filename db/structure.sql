--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: albums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE albums (
    id integer NOT NULL,
    title character varying,
    artist_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    search_vector tsvector
);


--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE albums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE albums_id_seq OWNED BY albums.id;


--
-- Name: artists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE artists (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    search_vector tsvector
);


--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE artists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE artists_id_seq OWNED BY artists.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: songs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE songs (
    id integer NOT NULL,
    title character varying,
    album_id integer,
    artist_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    search_vector tsvector
);


--
-- Name: songs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE songs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE songs_id_seq OWNED BY songs.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY albums ALTER COLUMN id SET DEFAULT nextval('albums_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY artists ALTER COLUMN id SET DEFAULT nextval('artists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY songs ALTER COLUMN id SET DEFAULT nextval('songs_id_seq'::regclass);


--
-- Name: albums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);


--
-- Name: artists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: songs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY songs
    ADD CONSTRAINT songs_pkey PRIMARY KEY (id);


--
-- Name: albums_search_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX albums_search_idx ON albums USING gin (search_vector);


--
-- Name: artists_search_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX artists_search_idx ON artists USING gin (search_vector);


--
-- Name: index_albums_on_artist_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_albums_on_artist_id ON albums USING btree (artist_id);


--
-- Name: index_songs_on_album_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_songs_on_album_id ON songs USING btree (album_id);


--
-- Name: index_songs_on_artist_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_songs_on_artist_id ON songs USING btree (artist_id);


--
-- Name: songs_search_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX songs_search_idx ON songs USING gin (search_vector);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: albums_search_vector_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER albums_search_vector_update BEFORE INSERT OR UPDATE ON albums FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('search_vector', 'pg_catalog.english', 'title');


--
-- Name: artists_search_vector_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER artists_search_vector_update BEFORE INSERT OR UPDATE ON artists FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('search_vector', 'pg_catalog.english', 'name');


--
-- Name: songs_search_vector_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER songs_search_vector_update BEFORE INSERT OR UPDATE ON songs FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('search_vector', 'pg_catalog.english', 'title');


--
-- Name: fk_rails_124a79559a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY albums
    ADD CONSTRAINT fk_rails_124a79559a FOREIGN KEY (artist_id) REFERENCES artists(id);


--
-- Name: fk_rails_5ce8fd4cc7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY songs
    ADD CONSTRAINT fk_rails_5ce8fd4cc7 FOREIGN KEY (artist_id) REFERENCES artists(id);


--
-- Name: fk_rails_f4e40cd655; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY songs
    ADD CONSTRAINT fk_rails_f4e40cd655 FOREIGN KEY (album_id) REFERENCES albums(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160722234822');

INSERT INTO schema_migrations (version) VALUES ('20160724203024');

INSERT INTO schema_migrations (version) VALUES ('20160724203208');

INSERT INTO schema_migrations (version) VALUES ('20160724203441');

INSERT INTO schema_migrations (version) VALUES ('20160725012125');

INSERT INTO schema_migrations (version) VALUES ('20160725012133');

