--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    is_spherical boolean,
    description text,
    type character varying(30)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    perimeter integer NOT NULL,
    planet_id integer,
    description text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    perimeter integer NOT NULL,
    mass numeric(10,2) NOT NULL,
    description text,
    has_life boolean,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: solar_system; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.solar_system (
    solar_system_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text
);


ALTER TABLE public.solar_system OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    perimeter integer NOT NULL,
    galaxy_id integer,
    description text
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', true, 'Galaxy containing our solar system', 'Spiral galaxy');
INSERT INTO public.galaxy VALUES (2, 'Andromeda', true, NULL, 'Spiral galaxy');
INSERT INTO public.galaxy VALUES (3, 'M87', true, NULL, 'Elliptical galaxy');
INSERT INTO public.galaxy VALUES (4, 'Large Magellanic CLoud', false, NULL, 'Irregular galaxy');
INSERT INTO public.galaxy VALUES (5, 'Sombrero', true, NULL, 'Spiral galaxy');
INSERT INTO public.galaxy VALUES (6, 'Centaurus A', false, NULL, 'Elliptical galaxy');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 3, 1, NULL);
INSERT INTO public.moon VALUES (2, 'Phobos', 2, 5, NULL);
INSERT INTO public.moon VALUES (3, 'Deimos', 1, 5, NULL);
INSERT INTO public.moon VALUES (4, 'Ganymede', 8, 6, NULL);
INSERT INTO public.moon VALUES (5, 'Europa', 7, 6, NULL);
INSERT INTO public.moon VALUES (6, 'Io', 6, 6, NULL);
INSERT INTO public.moon VALUES (7, 'Titan', 9, 7, NULL);
INSERT INTO public.moon VALUES (8, 'Enceladus', 4, 7, NULL);
INSERT INTO public.moon VALUES (9, 'Mimas', 2, 7, NULL);
INSERT INTO public.moon VALUES (10, 'Ariel', 4, 8, NULL);
INSERT INTO public.moon VALUES (11, 'Umbriel', 3, 8, NULL);
INSERT INTO public.moon VALUES (12, 'Titania', 5, 8, NULL);
INSERT INTO public.moon VALUES (13, 'Oberon', 4, 8, NULL);
INSERT INTO public.moon VALUES (14, 'Miranda', 2, 9, NULL);
INSERT INTO public.moon VALUES (15, 'Nereid', 1, 9, NULL);
INSERT INTO public.moon VALUES (16, 'Proteus', 2, 9, NULL);
INSERT INTO public.moon VALUES (17, 'Triton', 5, 10, NULL);
INSERT INTO public.moon VALUES (18, 'Charon', 2, 11, NULL);
INSERT INTO public.moon VALUES (19, 'Nix', 1, 11, NULL);
INSERT INTO public.moon VALUES (20, 'Hydra', 1, 11, NULL);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 48, 0.05, NULL, false, 1);
INSERT INTO public.planet VALUES (2, 'Venus', 121, 0.81, NULL, false, 1);
INSERT INTO public.planet VALUES (3, 'Earth', 127, 1.00, 'Third planet of solar system', true, 1);
INSERT INTO public.planet VALUES (4, 'Mars', 68, 0.10, NULL, false, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', 140, 318.00, NULL, false, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', 116460, 95.16, NULL, false, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', 50724, 14.54, NULL, false, 1);
INSERT INTO public.planet VALUES (8, 'Neptune', 49244, 17.15, NULL, false, 1);
INSERT INTO public.planet VALUES (9, 'Kepler-438b', 37, 0.08, NULL, true, 2);
INSERT INTO public.planet VALUES (10, 'Kepler-442b', 43, 0.12, NULL, false, NULL);
INSERT INTO public.planet VALUES (11, 'HD 219134 b', 13, 0.02, NULL, false, 3);
INSERT INTO public.planet VALUES (12, 'TRAPPIST-1 e', 14, 0.01, NULL, true, 4);


--
-- Data for Name: solar_system; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.solar_system VALUES (1, 'Earth', 'Humans live here');
INSERT INTO public.solar_system VALUES (2, 'Mars', 'Males are said to have come from Mars');
INSERT INTO public.solar_system VALUES (3, 'Venus', 'Females are said to have come from Venus');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 109, 1, 'The star at the center of solar system');
INSERT INTO public.star VALUES (2, 'Sirius', 8, 1, 'The brightest star');
INSERT INTO public.star VALUES (3, 'Betelgeuse', 1180, 1, NULL);
INSERT INTO public.star VALUES (4, 'Proxima Centauri', 1, 1, NULL);
INSERT INTO public.star VALUES (5, 'Mira', 418, 2, NULL);
INSERT INTO public.star VALUES (6, 'Aldebaran', 44, 5, NULL);


--
-- Name: galaxy galaxy_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_id PRIMARY KEY (galaxy_id);


--
-- Name: galaxy galaxy_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_id_key UNIQUE (galaxy_id);


--
-- Name: moon moon_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_id PRIMARY KEY (moon_id);


--
-- Name: moon moon_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_id_key UNIQUE (moon_id);


--
-- Name: planet planet_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_id PRIMARY KEY (planet_id);


--
-- Name: planet planet_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_id_key UNIQUE (planet_id);


--
-- Name: solar_system solar_system_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.solar_system
    ADD CONSTRAINT solar_system_id PRIMARY KEY (solar_system_id);


--
-- Name: solar_system solar_system_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.solar_system
    ADD CONSTRAINT solar_system_id_key UNIQUE (solar_system_id);


--
-- Name: solar_system solar_system_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.solar_system
    ADD CONSTRAINT solar_system_name_key UNIQUE (name);


--
-- Name: star star_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_id PRIMARY KEY (star_id);


--
-- Name: star star_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_id_key UNIQUE (star_id);


--
-- Name: star fk_galaxy_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy_id FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon fk_planet_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet_id FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_star_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star_id FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

