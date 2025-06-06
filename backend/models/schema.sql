--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: album_compatibilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.album_compatibilities (
    id character varying NOT NULL,
    user_id_1 integer NOT NULL,
    user_id_2 integer NOT NULL,
    album_id character varying NOT NULL,
    compatibility_score integer NOT NULL
);


--
-- Name: albums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.albums (
    id character varying NOT NULL,
    title character varying NOT NULL,
    artist character varying NOT NULL,
    release_date timestamp without time zone,
    genre character varying,
    aoty_score integer,
    cover_url character varying
);


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: artist_compatibilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.artist_compatibilities (
    id character varying NOT NULL,
    user_id_1 integer NOT NULL,
    user_id_2 integer NOT NULL,
    artist_id character varying NOT NULL,
    compatibility_score integer NOT NULL
);


--
-- Name: artists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.artists (
    id character varying NOT NULL,
    name character varying NOT NULL,
    genre character varying,
    popularity integer,
    aoty_score integer
);


--
-- Name: compatibilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.compatibilities (
    id character varying NOT NULL,
    user_id_1 integer NOT NULL,
    user_id_2 integer NOT NULL,
    compatibility_score integer NOT NULL
);


--
-- Name: playlists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.playlists (
    id integer NOT NULL,
    name character varying NOT NULL,
    track_ids json NOT NULL,
    cover_url character varying
);


--
-- Name: playlists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.playlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: playlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.playlists_id_seq OWNED BY public.playlists.id;


--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recommendations (
    id character varying NOT NULL,
    user_id integer NOT NULL,
    track_id character varying NOT NULL,
    album character varying NOT NULL,
    recommendation_score integer NOT NULL
);


--
-- Name: track_compatibilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.track_compatibilities (
    id character varying NOT NULL,
    user_id_1 integer NOT NULL,
    user_id_2 integer NOT NULL,
    track_id character varying NOT NULL,
    compatibility_score integer NOT NULL
);


--
-- Name: track_listening_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.track_listening_histories (
    id character varying NOT NULL,
    user_id integer NOT NULL,
    track_id character varying NOT NULL,
    play_count integer NOT NULL
);


--
-- Name: tracks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tracks (
    id character varying NOT NULL,
    title character varying NOT NULL,
    artist character varying NOT NULL,
    album character varying,
    genre character varying,
    popularity integer,
    aoty_score integer,
    audio_features json NOT NULL,
    cover_url character varying
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    password_hash character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: playlists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists ALTER COLUMN id SET DEFAULT nextval('public.playlists_id_seq'::regclass);


--
-- Name: album_compatibilities album_compatibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.album_compatibilities
    ADD CONSTRAINT album_compatibilities_pkey PRIMARY KEY (id);


--
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: artist_compatibilities artist_compatibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artist_compatibilities
    ADD CONSTRAINT artist_compatibilities_pkey PRIMARY KEY (id);


--
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: compatibilities compatibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compatibilities
    ADD CONSTRAINT compatibilities_pkey PRIMARY KEY (id);


--
-- Name: playlists playlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_pkey PRIMARY KEY (id);


--
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: track_compatibilities track_compatibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_compatibilities
    ADD CONSTRAINT track_compatibilities_pkey PRIMARY KEY (id);


--
-- Name: track_listening_histories track_listening_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_listening_histories
    ADD CONSTRAINT track_listening_histories_pkey PRIMARY KEY (id);


--
-- Name: tracks tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT tracks_pkey PRIMARY KEY (id);


--
-- Name: track_listening_histories uq_user_track; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_listening_histories
    ADD CONSTRAINT uq_user_track UNIQUE (user_id, track_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: ix_album_compatibilities_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_album_compatibilities_id ON public.album_compatibilities USING btree (id);


--
-- Name: ix_artist_compatibilities_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_artist_compatibilities_id ON public.artist_compatibilities USING btree (id);


--
-- Name: ix_artists_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_artists_id ON public.artists USING btree (id);


--
-- Name: ix_compatibilities_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_compatibilities_id ON public.compatibilities USING btree (id);


--
-- Name: ix_playlists_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_playlists_id ON public.playlists USING btree (id);


--
-- Name: ix_recommendations_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_recommendations_id ON public.recommendations USING btree (id);


--
-- Name: ix_track_compatibilities_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_track_compatibilities_id ON public.track_compatibilities USING btree (id);


--
-- Name: ix_track_listening_histories_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_track_listening_histories_id ON public.track_listening_histories USING btree (id);


--
-- Name: ix_tracks_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_tracks_id ON public.tracks USING btree (id);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: album_compatibilities album_compatibilities_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.album_compatibilities
    ADD CONSTRAINT album_compatibilities_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.albums(id);


--
-- Name: album_compatibilities album_compatibilities_user_id_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.album_compatibilities
    ADD CONSTRAINT album_compatibilities_user_id_1_fkey FOREIGN KEY (user_id_1) REFERENCES public.users(id);


--
-- Name: album_compatibilities album_compatibilities_user_id_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.album_compatibilities
    ADD CONSTRAINT album_compatibilities_user_id_2_fkey FOREIGN KEY (user_id_2) REFERENCES public.users(id);


--
-- Name: artist_compatibilities artist_compatibilities_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artist_compatibilities
    ADD CONSTRAINT artist_compatibilities_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artists(id);


--
-- Name: artist_compatibilities artist_compatibilities_user_id_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artist_compatibilities
    ADD CONSTRAINT artist_compatibilities_user_id_1_fkey FOREIGN KEY (user_id_1) REFERENCES public.users(id);


--
-- Name: artist_compatibilities artist_compatibilities_user_id_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.artist_compatibilities
    ADD CONSTRAINT artist_compatibilities_user_id_2_fkey FOREIGN KEY (user_id_2) REFERENCES public.users(id);


--
-- Name: compatibilities compatibilities_user_id_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compatibilities
    ADD CONSTRAINT compatibilities_user_id_1_fkey FOREIGN KEY (user_id_1) REFERENCES public.users(id);


--
-- Name: compatibilities compatibilities_user_id_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compatibilities
    ADD CONSTRAINT compatibilities_user_id_2_fkey FOREIGN KEY (user_id_2) REFERENCES public.users(id);


--
-- Name: recommendations recommendations_album_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_album_fkey FOREIGN KEY (album) REFERENCES public.albums(id);


--
-- Name: recommendations recommendations_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.tracks(id);


--
-- Name: recommendations recommendations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: track_compatibilities track_compatibilities_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_compatibilities
    ADD CONSTRAINT track_compatibilities_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.tracks(id);


--
-- Name: track_compatibilities track_compatibilities_user_id_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_compatibilities
    ADD CONSTRAINT track_compatibilities_user_id_1_fkey FOREIGN KEY (user_id_1) REFERENCES public.users(id);


--
-- Name: track_compatibilities track_compatibilities_user_id_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_compatibilities
    ADD CONSTRAINT track_compatibilities_user_id_2_fkey FOREIGN KEY (user_id_2) REFERENCES public.users(id);


--
-- Name: track_listening_histories track_listening_histories_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_listening_histories
    ADD CONSTRAINT track_listening_histories_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.tracks(id);


--
-- Name: track_listening_histories track_listening_histories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_listening_histories
    ADD CONSTRAINT track_listening_histories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

