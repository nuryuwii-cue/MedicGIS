--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2025-06-04 18:48:08

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

--
-- TOC entry 2 (class 3079 OID 40742)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 5820 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 41832)
-- Name: fasilitas_kesehatan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fasilitas_kesehatan (
    id_fasilitas character varying NOT NULL,
    nama_fasilitas character varying,
    kontak character varying,
    website character varying,
    jam_operasional character varying,
    alamat character varying,
    koordinat_fasilitas public.geometry,
    url_foto text,
    jumlah_ulasan integer,
    id_kategori character varying
);


ALTER TABLE public.fasilitas_kesehatan OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 41825)
-- Name: kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori (
    id_kategori character varying NOT NULL,
    nama_kategori character varying
);


ALTER TABLE public.kategori OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 41912)
-- Name: preferensi_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preferensi_user (
    id_preferensi character varying NOT NULL,
    username character varying(50) NOT NULL,
    id_kategori character varying NOT NULL,
    radius_preferensi numeric(5,2),
    CONSTRAINT rekomendasi_user_radius_preferensi_check CHECK ((radius_preferensi > (0)::numeric))
);


ALTER TABLE public.preferensi_user OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 41930)
-- Name: rekomendasi_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rekomendasi_user (
    id_rekomendasi character varying NOT NULL,
    username character varying(50) NOT NULL,
    id_fasilitas character varying NOT NULL,
    id_preferensi character varying NOT NULL,
    tanggal_rekomendasi date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.rekomendasi_user OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 41880)
-- Name: ulasan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ulasan (
    id_ulasan character varying NOT NULL,
    id_fasilitas character varying NOT NULL,
    komentar text,
    rating numeric(2,1),
    tanggal_ulasan date DEFAULT CURRENT_DATE NOT NULL,
    username character varying(50),
    CONSTRAINT ulasan_rating_check CHECK (((rating >= (0)::numeric) AND (rating <= (5)::numeric)))
);


ALTER TABLE public.ulasan OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 41865)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    username character varying(50) NOT NULL,
    id_fasilitas character varying,
    nama_user character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    tanggal_akses date DEFAULT CURRENT_DATE NOT NULL,
    koordinat_user public.geometry(Point,4326)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 5810 (class 0 OID 41832)
-- Dependencies: 222
-- Data for Name: fasilitas_kesehatan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fasilitas_kesehatan (id_fasilitas, nama_fasilitas, kontak, website, jam_operasional, alamat, koordinat_fasilitas, url_foto, jumlah_ulasan, id_kategori) FROM stdin;
11001	Rumah Sakit Nasional Diponegoro (RSND)	(024) 76928020	https://rsnd.undip.ac.id/	Buka 24 Jam	Jl. Prof. Moeljono S. Trastotenojo, Tembalang, Kec. Tembalang, Kota Semarang, Jawa Tengah 50275	0101000020ED7F0000713D0AD766C41A413D0AD7FB66966141	https://lh3.googleusercontent.com/p/AF1QipP2UaiSkVRWwB4HchofuYFGScGM5X8HGE5Ar0d5=s1360-w1360-h1020	0	14001
11003	Rumah Sakit UNIMUS	0878-5758-0214	https://rsunimus.com/	Buka 24 Jam	Jl. Kedungmundu No.214, Kedungmundu, Kec. Tembalang, Kota Semarang, Jawa Tengah 50273	0101000020ED7F00003333333382DE1A41A4703DB2CA976141	https://rsunimus.com/wp-content/uploads/elementor/thumbs/Cuplikan-layar-2023-12-01-173715-qhi8e1ancr2go3joukx590d8pufuh2jugxuieexd8g.jpg	0	14001
11004	Primaya Hospital Semarang	1 500 007	https://primayahospital.com	Buka 24 Jam	Jl. Kedungmundu No.24, Kedungmundu, Kec. Tembalang, Kota Semarang, Jawa Tengah 50273	0101000020ED7F000052B81E8567E31A41CDCCCC34B7976141	https://cdn-healthcare.hellohealthgroup.com/2022/10/1664783478_633a947611e673.47498501.jpg	2	14001
11005	Puskesmas Bulusan	(024) 35303034	-	-	Jl. Timoho Raya, Bulusan, Kec. Tembalang, Kota Semarang, Jawa Tengah 50277	0101000020ED7F00007B14AE47EAC71A41295C8F12BA956141	https://lh3.googleusercontent.com/p/AF1QipOzZvGmIzS2FfmcthCFEcC1H05OCRZTYanV9oQ-=s1360-w1360-h1020	1	14005
11006	Puskesmas Kelurahan Rowosari	(024) 76414169	-	-	Jl. Tunggu Raya, Rowosari, Tembalang, Meteseh, Kec. Tembalang, Kota Semarang, Jawa Tengah 50279	0101000020ED7F0000EC51B81E0CF51A41CDCCCC1CFC956141	https://dinkes.semarangkota.go.id/asset/4x3/puskesmas/rowosari.jpg	2	14005
11007	Puskesmas Kedungmundu	(024) 6717053	-	-	Jl. Sambiroto Raya, RT.01/RW.01, Sambiroto, Kec. Tembalang, Kota Semarang, Jawa Tengah 50276	0101000020ED7F0000E17A14AEFFE01A41F6285C0F95976141	https://dinkes.semarangkota.go.id/asset/upload/Kedungmundu/ARTIKEL%20SEPTEMBER%202024/kaji%20tiru%203.jpg	2	14005
11008	Puskesmas Pembantu Rowosari Krajan	(024) 70797382	-	-	Jl. Rowosari Raya, Rowosari, Kec. Tembalang, Kota Semarang, Jawa Tengah 50279	0101000020ED7F0000AE47E17AB4061B41C3F5281CCB956141	https://lh5.googleusercontent.com/p/AF1QipNmUPwdWruCkFGbPeCfiBS03jJdTNy2_XURp3Au=w408-h326-k-no	0	14005
11009	Puskesmas Pembantu Mangunharjo	-	-	-	Jl. Kompol R. Soekanto, Mangunharjo, Tembalang, Semarang City, Central Java 50272	0101000020ED7F00000AD7A37083E21A413D0AD72393966141	https://maps.app.goo.gl/VxGTt7imXiMCaHsq6	1	14005
11010	Puskesmas Pembantu Sendangguwo	-	-	-	Jl. Sendangguwo Raya No.66, Sendangguwo, Kec. Tembalang, Kota Semarang, Jawa Tengah 50273	0101000020ED7F0000C3F5285C0AD51A41B81E856B42986141	https://lh3.googleusercontent.com/p/AF1QipMJXz2jGK2m35QtETs784FESFGh5M8YTc4P9vrT=s1360-w1360-h1020	1	14005
11011	Puskesmas Pembantu Sambiroto	(0702) 92713	-	-	Jl. Taman Sambiroto Asri Barat, Sambiroto, Tembalang, Semarang City, Central Java 50276	0101000020ED7F0000D7A3703D52D21A41333333DB12976141	https://lh3.googleusercontent.com/p/AF1QipPn7rE6gB746e3YvYN7dtN_el60EU-eoqp89VMb=s1360-w1360-h1020	0	14005
11012	Klinik Pratama Medico Semarang	(024) 76403479	-	-	Jl. Mulawarman Selatan Raya No.16A Kramas, Kec. Tembalang, Kota Semarang, Jawa Tengah 50266	0101000020ED7F00000AD7A37002BD1A41AE47E16A30956141	https://p16-va.lemon8cdn.com/tos-alisg-v-a3e477-sg/oEPeAHfALQ8Xy4Q7agI2Bd7veGA2EbAKcKIPJD~tplv-tej9nj120t-origin.webp	2	14002
11014	Klinik Mitra Umat	6285848692815	-	-	Jl. Bulusan VI No.34, Bulusan, Kec. Tembalang, Kota Semarang, Jawa Tengah 50277	0101000020ED7F000048E17A143EC81A41CDCCCC74B0956141	https://medigo-images.s3-ap-southeast-1.amazonaws.com/clinics/mitra-umat/tampak-depan.jpeg	2	14002
11015	Klinik Pratama Erins	6285150716016	-	-	Jl. Timoho Raya No.21, Bulusan, Kec. Tembalang, Kota Semarang, Jawa Tengah 50277	0101000020ED7F0000713D0AD7C0C81A411F85EBA9B4956141	https://lh3.googleusercontent.com/p/AF1QipP0H26vpxMLybtoF0UZfLuOC-pQha8kJkWUO8_g=s1360-w1360-h1020	0	14002
11017	Klinik Pratama Diponegoro I	6281510015577	-	-	Tembalang, Semarang City, Central Java 50275	0101000020ED7F0000C3F5285CB2B21A41C3F528EC08966141	https://tembalang.semarangkota.go.id/medias/media/big/175/klinik-pratama-diponegoro-1.jpeg	1	14002
11018	Klinik Mardi Mulya Sendangmulyo	(024)76415987	-	07:00-21:00	Jl. Raya Sendangmulyo No.33, Mangunharjo, Kec. Tembalang, Kota Semarang, Jawa Tengah 50272	0101000020ED7F00000AD7A37007F11A41D7A3703579966141	https://lh3.googleusercontent.com/p/AF1QipOwGnmDQB2TLXGVBlKnYxHtZTJY70cCtIHRIgR3=s0	2	14002
11019	Klinik Pratama LC Medika	628895327688	-	10:00-08:00	Jl. Alam Asri No.17, Sendangmulyo, Kec. Tembalang, Kota Semarang, Jawa Tengah 50272	0101000020ED7F00001F85EB510EFB1A4100000048DC966141	https://medicastore.com/images/faskes/KLINIK-PRATAMA-LC-MEDIKA_Medicastore_ls1By.jpg	0	14002
11020	Klinik Pratama Puri Husada	(0354) 770586	-	07:00-14:30	Jl. KH. Sirojudin No.29, Tembalang, Kec. Tembalang, Kota Semarang, Jawa Tengah 50275	0101000020ED7F00007B14AE4779B51A41A4703DCAD9956141	https://lh3.googleusercontent.com/p/AF1QipNAzDeyzcT3qBtehestqEO9fvHkfXKnmWA64Pv1=s1360-w1360-h1020	1	14002
11021	Klinik Pratama Sulistya Medika	6285876631298	-	-	Meteseh, Tembalang, Semarang City, Central Java 50271, Indonesia	0101000020ED7F00005C8FC2F5C9E91A41AE47E1DA94956141	https://lh5.googleusercontent.com/p/AF1QipOWc7NS6K-tOrDzoFJlgtf3uBaF7FKc0jNcpHxK=w408-h408-k-no	2	14002
11023	Klinik Pratama Rowosari Asri	6282328154898	-	07:00-20:00	Jalan Albarokah Perumahan Pondok Rowosari Asri Ruko Blok B 3 Dan 4, Kota Semarang, Jawa Tengah 50271	0101000020ED7F0000E17A14AE03001B4114AE4771BE956141	https://lh3.googleusercontent.com/p/AF1QipO_nONwZd_8J9um5AI_Hdhh521w9oHYFCHp7Dbv=s1360-w1360-h1020	1	14002
11024	Klinik Utama Harapan Sehat Keluarga	6282180008201	-	07:00-21:00	Jl. Perumahan Ketileng Indah, Sendangmulyo, Kec. Tembalang, Kota Semarang, Jawa Tengah 50272	0101000020ED7F0000713D0AD776F51A411F85EB1920976141	https://lh3.googleusercontent.com/p/AF1QipNqtofv6BYyVCB_5sEu8jB5xvP06KRkclRoJk_S=s1360-w1360-h1020	1	14002
11025	Klinik Pratama Karyo Sih	(024) 6715464	-	05:00-21:00	Jl. Mutiara III No.53, Sambiroto, Kec. Tembalang, Kota Semarang, Jawa Tengah 50276	0101000020ED7F00003D0AD7A39FDF1A417B14AE4746976141	https://lh3.googleusercontent.com/p/AF1QipMM_7hQJhhNHz4qK472HN_eQ3dMwmOEdT_a1usH=s1360-w1360-h1020	2	14002
11026	Klinik Pratama 24 Jam DEKA Medika	6282138364304	-	24:00	Jl. Klipang Raya Ruko Klipang Golf View Kav. C-6, Jl. Klipang Raya, Sendangmulyo, Kec. Tembalang, Kota Semarang, Jawa Tengah 50272	0101000020ED7F0000EC51B81E2D011B4100000018F2966141	https://lh3.googleusercontent.com/p/AF1QipPXHp2q_bTPKlXbIzUyHB7-w-RvbrI60YWu86MV=s1360-w1360-h1020	0	14002
11027	Laboratorium Sentral Rumah Sakit Nasional Diponegoro	(024) 76928020	https://rsnd.undip.ac.id/	Buka 24 Jam	Jl. Prof. Moeljono S. Trastotenojo, Tembalang, Kec. Tembalang, Kota Semarang, Jawa Tengah 50275	0101000020ED7F00000AD7A3707BC31A411F85EB9171966141	https://lh3.googleusercontent.com/p/AF1QipMjB0bEapPrTQ3pCNNpf4KNwTx7bo4SfEquQwwl=s1360-w1360-h1020	0	14004
11028	Klinik Pratama Medika	(024) 76740281	-	08.00-20.00	Jl. Sambiroto Raya No.51, RT.2/RW.1, Sambiroto, Kec. Tembalang, Kota Semarang, Jawa Tengah 50276	0101000020ED7F0000713D0AD78DE01A4148E17A349E976141	https://lh5.googleusercontent.com/p/AF1QipMnf-KX4aIump-BrtrEUnU2OQn5va6bswtQSQQ=w520-h350-n-k-no	2	14002
11029	Klinik Rahmat Medika Samoing Kampus Unimus Semarang	085107195644	-	-	Jl. Kedungmundu No.17, Sambiroto, Kec. Tembalang, Kota Semarang, Jawa Tengah 50276	0101000020ED7F00000000000083E01A41000000089D976141	-	0	14002
11030	Klinik Rahmat Medika (BPJS & Umum)	+6285107195644	-	08.00-19.30	Jl. Kedungmundu No.24-A, Kedungmundu, Kec. Tembalang, Kota Semarang, Jawa Tengah 50273	0101000020ED7F0000713D0AD740E41A41EC51B866B9976141	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqJSfy5XneViZnmxN8otAZPfCnNC2NqP0Rw&s	0	14002
11031	Klinik Brimedika Semarang	(024) 6734632	-	08.00-17.00	Jalan Kedung Mundu Raya No.126, Kedungmundu, Tembalang, Tandang, Semarang, Tandang, Kec. Tembalang, Kota Semarang, Jawa Tengah 50274	0101000020ED7F000085EB51B85CD01A41F6285C9F40986141	https://lh3.googleusercontent.com/p/AF1QipPKASelmy4uA7HFvcDPn8V9QQbVPz65A09jKvr2=s1600-w600	2	14002
11032	Klinik Pratama Tjie Lam Tjay Kedungmundu	-	-	04.00-19.00	Jl. Kedungmundu No.200, Tandang, Kec. Tembalang, Kota Semarang, Jawa Tengah 50274	0101000020ED7F0000AE47E17A1CDA1A41F6285CAFF0976141	https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/2023/06/02/2fklinik-k18-4124344120.jpg	1	14002
11033	Klinik Gigi uSmile Dental Studio Semarang	+6287765677091	-	09.00-20.00	Jl. Kedungmundu No.122, Tandang, Kec. Tembalang, Kota Semarang, Jawa Tengah 50274	0101000020ED7F0000713D0AD714CF1A41C3F528EC42986141	https://lh3.googleusercontent.com/p/AF1QipOShi7cmPTndJBeJtB7vZSfVa5p793wJY348-sl=s1360-w1360-h1020	1	14002
11034	Klinik Mitra Sejawat	+6281229181169	-	05.00-20.00	Jl. Kedungmundu, Tandang, Kec. Tembalang, Kota Semarang, Jawa Tengah 50274	0101000020ED7F0000F6285C8FE1D91A418FC2F550EA976141	-	2	14002
11035	Klinik Pratama Mahisi Mulya	(024) 76719030	https://pratamamahisimulyasmg.com/	07.30-12.30	Kedungmundu, Tembalang, Semarang City, Central Java 50273	0101000020ED7F0000295C8FC2B6E51A418FC2F518CA976141	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4s2oHv1w-74-dnrODfM0svJqZ_5OQoTxkGw&s	0	14002
11037	Central Java Police Polyclinic Biddokkes Sendangmulyo	(024) 6702239	-	-	Asrama Polisi Sendang Mulyo, Jalan Ketileng Raya, Kedungmundu, Tembalang, Sendangmulyo, Kec. Tembalang, Kota Semarang, Jawa Tengah 50272	0101000020ED7F000048E17A142AF01A4185EB510857976141	https://lh3.googleusercontent.com/p/AF1QipODUR51vO52dpu4Rqv-UiMAKIdnh_NY1t14yhM0=s1360-w1360-h1020	0	14002
11038	Apotek Sehit	(024) 76419235	https://www.semuabis.com/apotek-sehit-024-76419235	08.00-21.00	Jl. Bougenvile Raya Nomor 30, Sendangmulyo, Tembalang, Kota Semarang	0101000020ED7F0000B81E85EBB7F71A41295C8FDA7F966141	https://lh3.googleusercontent.com/p/AF1QipPCvq4xq_Z49mTe_LWJJpa_ZJn9iRrwn_RaFp4=s1360-w1360-h1020	2	14003
11039	Apotek K-24	(024) 7475442	https://www.apotek-k24.com/location/detail/256/K-24-KEDUNGMUNDU	Buka 24 Jam	Jl. Kedungmundu No.137, Tandang, Kec. Tembalang, Kota Semarang	0101000020ED7F0000E17A14AE77D01A41666666B644986141	https://lh3.googleusercontent.com/p/AF1QipNECpG6lmQqJ4dUxqjJp11UuFeuIVhE3GubTeo3=s1360-w1360-h1020	2	14003
11040	Apotek Tembalang	(024) 76738208	https://www.instagram.com/apotektembalang/	08.00 – 20.45	Jl. Adipati Unus / Prof. Sudarto No.3, Tembalang, Kec. Tembalang, Kota Semarang	0101000020ED7F0000713D0AD7E7B61A41295C8F5AFF956141	https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQ6R13-R1-Om1aKAHEcSoUpwb0Z6_G8hHpBk4AzD-mq2cjLEO1Kc34DqAkLBqJDWkUCWKIaAsUf0uybG2Qe2lddqW1aN8-6aMk4C2U7f7IrI83Ah8mhrvcO5kIgqRPHCK9gAVC5TxWXNVZ/s1009/Apotek+Tembalang.jpg	1	14003
11041	Apotek Subur Sehat	\N	https://id837430-apotek-subur-sehat.contact.page/	07.00-22.00	JL. Klipang Golf Raya, No. A I/1, Sendangmulyo, Kec. Tembalang, Kota Semarang	0101000020ED7F000014AE47E19CFC1A4148E17A3CF4966141	https://lh3.googleusercontent.com/p/AF1QipMnTar7GjjKJmh5w55EpGIUEXq_oGQpuyu52Ib7=s1360-w1360-h1020	0	14003
11042	Apotek K-24 Sambiroto Semarang	0813-2669-0234	https://www.apotek-k24.com/location/detail/568/K-24-SAMBIROTO	Buka 24 Jam	Ruko Sambiroto Soekarno Jl. Kompol R Soekanto, Sambiroto, Kec. Tembalang, Kota Semarang	0101000020ED7F0000713D0AD752DD1A413D0AD7933C976141	-	0	14003
11043	Apotek Tulus Harapan	(024) 76740539	https://www.tokopedia.com/apotektulusharapantembal	06.30-22.00	Jl. KPA II No.xx, Sendangmulyo, Kec. Tembalang, Kota Semarang	0101000020ED7F0000D7A3703DFAF51A410AD7A320F9966141	https://lh3.googleusercontent.com/p/AF1QipPQkx55ks0K9Xa8BsviwmcqgGLH_W3_F2DkXMem=s1360-w1360-h1020	0	14003
11044	Apotek Akbar	(024) 6732041	https://www.tokopedia.com/apotekakbarfarmatembalan	08.00–21.30	Jl. Kedungmundu No.106.c, Sendangguwo, Kec. Tembalang, Kota Semarang	0101000020ED7F0000295C8FC2F8CC1A41AE47E1724B986141	https://lh3.googleusercontent.com/p/AF1QipMtaWm7C6yjZEhVSpGWj9SO7f0i11SXpPCj-es=s1360-w1360-h1020	1	14003
11045	Apotek K-24 Ketileng Raya Semarang	(024) 6702924	https://www.apotek-k24.com/location/detail/510/K-24-KETILENG	Buka 24 Jam	Sendangmulyo, Tembalang, Kota Semarang	0101000020ED7F00008FC2F528FFED1A41D7A3702549976141	https://lh3.googleusercontent.com/p/AF1QipPqFMhEfjbDMJP9q2L1Cuv01BA_lIt9kQGEqt4M=s1360-w1360-h1020	2	14003
11046	Apotek Klipang Sehat	(024) 76740777	https://shopee.co.id/apotekklipangsehat	07.00-21.30	Jl. Klipang Raya Jl. Raya Klipang Pesona Asri II No.19, Sendangmulyo, Kec. Tembalang, Kota Semarang	0101000020ED7F000052B81E8576F71A41F6285CFFF7966141	https://lh3.googleusercontent.com/p/AF1QipPqEpN2kzC7t_2xKF1Px7RRQdBcv-dZ0wyVJhby=s1360-w1360-h1020	2	14003
11047	Apotek Sehat Raharja	(024) 78918240	https://www.honestdocs.id/apotik/apotek-sehat-raharja-semarang	07.00–21.00	Jl. Dinar Elok Raya, Meteseh, Kec. Tembalang, Kota Semarang	0101000020ED7F0000C3F5285CDDF01A4100000050BB956141	https://lh3.googleusercontent.com/p/AF1QipMA9sGpFB56Vix4kRkVRf9H_oeYA7gAsHiEAi7b=s680-w680-h510	1	14003
11048	Apotek Kimia Farma Banjarsari	0811-1067-8069	http://kimiafarmaapotek.co.id/	07.00-22.00	Jl. Timoho Raya No.287, Bulusan, Kec. Tembalang, Kota Semarang	0101000020ED7F000014AE47E188C41A41AE47E16AB9956141	https://lh3.googleusercontent.com/p/AF1QipNuEt-RhxTeVqwSMOnZlHE2WcdLG65v_U1Ba1T5=s1360-w1360-h1020	0	14003
11049	APOTEK ALETHEIA	0882-0059-81888	https://www.instagram.com/aletheia.indonesia/	08.00-21.00	Ruko KPA Royal Park, Jl. Klipang Raya No.Kav 16, Sendangmulyo, Kec. Tembalang, Kota Semarang	0101000020ED7F000014AE47E139021B41F6285C17BF966141	https://lh3.googleusercontent.com/p/AF1QipOFJR79jv3lAXzCiEyX6qCDEp__qe-mXAgjTs_r=s1360-w1360-h1020	2	14003
11050	Apotek Manshurin	(024) 6703637	https://www.apotek-k24.com/	08.00-21.00	Jl. Ketileng Raya No.4, Sendangmulyo, Kec. Tembalang, Kota Semarang	0101000020ED7F000000000000B5ED1A4152B81E3D2B976141	-	0	14003
11051	Apotik Waras Barokah	-	https://m.goapotik.com/penjual/Apotek-Waras-Barokah	07.30–21.00	Jl. Fatmawati No.196, Kedungmundu, Kec. Tembalang, Kota Semarang	0101000020ED7F000014AE47E10EF21A4148E17A8CD7976141	https://lh3.googleusercontent.com/p/AF1QipNZMYngjQtESm9wiAIPaC_bmpHm8jCF1oGy8EPJ=s1360-w1360-h1020	0	14003
11052	Apotek Citra Medika	(024) 76738352	https://www.instagram.com/citra.medika/	07.00–21.45	Jl. Sambiroto Raya No.12, Sambiroto, Kec. Tembalang, Kota Semarang	0101000020ED7F00008FC2F52852DD1A41000000803B976141	https://lh3.googleusercontent.com/gps-cs-s/AB5caB_xXkgmj69090ssovzyJu4lWNj1C88PmYs7iciHGQdq_VEWVRTWVh0znLfqxBr15C569AfvTz9YkUdR2hktdFEfZy1jG-HOntZXMgCa1ssTZ1jDVfl7ob43EuoMLaI021EK0evq=s1360-w1360-h1020	1	14003
11053	Apotek Surya Sehat Apotik Semarang	0812-4611-9432	https://shp.ee/2is25aj	07.30–21.00	Ruko Pandanaran Hills Blok AC, Jl. Alamanda Atas, Mangunharjo, Kec. Tembalang, Kota Semarang	0101000020ED7F00009A999999E9DF1A41E17A14D6D3966141	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZ7h6VIkKtd0W7OhmgFa6YDaZOCW_IxxFJFA&s	1	14003
11054	Apotek KeluargaKu	0812-1409-6959	https://mart.grab.com/id/id/merchant/6-C6DCRT5JT36DJ2	09:00-21:00	Jl. Banjarsari raya no. Tembalang, Kec. Tembalang, Kota Semarang	0101000020ED7F000052B81E85EBC01A410AD7A368C0956141	https://lh3.googleusercontent.com/p/AF1QipN959wmBt05Co3EF8bCNKm9qHAxO98sspxoyBbr=s1360-w1360-h1020	2	14003
11055	Apotek Peduli Kedungmundu	0813-9083-1177	https://www.tokopedia.com/apotekpedulikedungsmrg	07:00-22:00	Jl. Kedungmundu No.230, Kedungmundu, Kec. Tembalang, Kota Semarang	0101000020ED7F0000D7A3703D62DE1A411F85EB39B8976141	-	1	14003
11056	Apotek Harmoni Sehat Bersama Kita	-	https://www.instagram.com/apotekharmonisehatgrup/?locale=en_US	24 Jam	Ruko Amsterdam No, Jl. Klipang Raya No.1 Blok Z, Sendangmulyo, Kec. Tembalang, Kota Semarang	0101000020ED7F00005C8FC2F591041B41D7A3705554966141	https://lh3.googleusercontent.com/p/AF1QipNZqrspmqOpf9xGK1cpcFOUg19qsfj6VhFIv4dJ=s1360-w1360-h1020	2	14003
11057	Apotek Sinar Waluyo	0856-4112-2033	https://www.instagram.com/apotek_sinarwaluyo/	24 Jam	Jl. Sinar Waluyo Raya No.11 E, Kedungmundu, Kec. Tembalang, Kota Semarang	0101000020ED7F00003D0AD7A3DBF11A413333338BB0976141	https://lh3.googleusercontent.com/p/AF1QipPQt-khZjjCJH0QpDlWbFHCLXWgFSSIPa1-ZCuO=s680-w680-h510	2	14003
11058	APOTEK METESEH	0896-6815-2052	-	08:00-21:00	Jl. Kompol R Soekanto No.1, Bulusan, Kec. Tembalang, Kota Semarang	0101000020ED7F00005C8FC2F5CBE61A41D7A3704DF5956141	https://lh3.googleusercontent.com/p/AF1QipO90I2YTg7DIXP70pRPuH2o6BRuuUcV3HL7o8Wz=s1360-w1360-h1020	2	14003
11059	Apotek Peduli Sendangguwo	0813-9083-1117	https://www.instagram.com/apotekpedulismg/	07:00-22:00	Jl. Sendangguwo Selatan Raya, Sendangguwo, Kec. Tembalang, Kota Semarang	0101000020ED7F0000F6285C8FAED71A41E17A14FE67986141	https://ik.imagekit.io/tk6ir0e7mng/uploads/2022/02/1645079580347.jpeg	2	14003
11060	Apotek Sarwo Sehat	-	https://www.goalkes.com/apotek/apotek-sarwo-sehat-miv5f	08:00-22:00	Jl. Imam Soeparto, Meteseh, Kec. Tembalang, Kota Semarang	0101000020ED7F000066666666C0E51A41295C8FB2E5956141	https://lh3.googleusercontent.com/p/AF1QipNf2df9OyDF45hcnnQ_0WIl_Az5vZqmwQEHYe0=s1360-w1360-h1020	0	14003
11061	Apotek Ajron Farma	-	-	07:00-20:00	Jl. Fatmawati No.4, Kedungmundu, Kec. Tembalang, Kota Semarang	0101000020ED7F0000EC51B81EBBEE1A41A4703D1AA2976141	https://lh3.googleusercontent.com/p/AF1QipOrUlpqnj3CjjhjMLILx4dTY36RFjy9OqzBb4PX=s1360-w1360-h1020	1	14003
11062	Apotek Manna	0811-2895-656	https://www.semuabis.com/apotek-manna_1Y-0811-2895-656	08:00-21:30	Jl. Ruko Graha Wahid Blok B No.3a, Jl. Kedungmundu, Sambiroto, Kec. Tembalang, Kota Semarang	0101000020ED7F0000333333332FE21A41E17A146EA0976141	https://lh3.googleusercontent.com/p/AF1QipOCsmis7Zxpvf6-bt6pMDSAG8yw1dn0e231JSc=s1360-w1360-h1020	0	14003
11063	Apotek Joyo	(024) 6706418	https://lewatmana.com/lokasi/48333/apotek-joyo/	10.00–21.00	Jl. Kedungmundu No.120, Tandang, Kec. Tembalang, Kota Semarang	0101000020ED7F00001F85EB51B1CE1A4152B81E1D44986141	https://lh3.googleusercontent.com/p/AF1QipPpkE-Jo9CIN4IOZU8Ts-58BtCPG3EJ1GJl6Hk=s1360-w1360-h1020	2	14003
11064	Apotek B-18 Ketileng	0811-2921-018	https://lewatmana.com/lokasi/48400/viva-apotek-ketileng/	06.00-22.00	Ruko Mutiara Gading Residence, Jl. Ketileng Indah Raya No. A-8, Sendangmulyo, Kec. Tembalang, Kota Semarang	0101000020ED7F0000AE47E17A13F51A410AD7A38819976141	https://lh3.googleusercontent.com/p/AF1QipNUpeN6CrXFBqdZarIm7eAVGF6seVwOix5evybX=s1360-w1360-h1020	2	14003
11065	Omura Apotek	0889-0890-8989	https://www.tokopedia.com/apotekomurakdungmundusmg	08.00-21.00	Jl. Kedungmundu, Kedungmundu, Tembalang, Kota Semarang	0101000020ED7F0000A4703D0A9DEB1A410AD7A3C0AC976141	https://lh3.googleusercontent.com/p/AF1QipNuxL9Br0I6t_CicZ6hbpoYxTh8BByNv0GyLWqs=s1360-w1360-h1020	2	14003
11066	Apotek Sehat Insan	\N	\N	08.00-21.00	Jl. Kedungmundu No.23A, Kedungmundu, Kec. Tembalang, Kota Semarang	0101000020ED7F0000F6285C8F20E41A41C3F52844B2976141	\N	2	14003
11067	Kurnia Sehat Pharmacy	(024) 70706721	https://www.honestdocs.id/apotik/kurnia-farma-pharmacy-semarang/details	Buka 24 Jam	Jl. Sambiroto Raya No.84, Sambiroto, Kec. Tembalang, Kota Semarang	0101000020ED7F00008FC2F52884DC1A41AE47E15AA6976141	\N	2	14003
11068	Apotek Mitra	\N	\N	Buka 24 Jam	Jl. Elang Raya No.2, Sambiroto, Kec. Tembalang, Kota Semarang	0101000020ED7F000048E17A1425E01A41AE47E1EA2A976141	\N	2	14003
11069	Apotek Ken Mari’o	\N	\N	Buka 24 Jam	Jl. Sendang Asri Raya, Kedungmundu, Kec. Tembalang, Kota Semarang	0101000020ED7F000048E17A1420E61A41666666360F986141	\N	2	14003
11002	Rumah Sakit Umum Daerah KRMT Wongsonegoro	(024) 6711500	https://rsud.semarangkota.go.id/	Buka 24 Jam	Jl. Fatmawati No.1, Mangunharjo, Kec. Tembalang, Kota Semarang, Jawa Tengah 50272	0101000020ED7F0000000000006CE71A4152B81E1D44986141	https://d1ojs48v3n42tp.cloudfront.net/provider_location_banner/440795_5-2-2020_8-3-17.jpg	2	14001
11013	Denticare Dental Clinic	6281215100539	\N	\N	Jl. Mulawarman Selatan Raya No.16 B, Kramas, Kec. Tembalang, Kota Semarang, Jawa Tengah 50278	0101000020ED7F0000A4703D0A5DBE1A4185EB51282E956141	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjqMZpQpHFIu1dkPWACWadz1z3GyZr12vbkw&s	2	14002
11016	Klinik Umum dr. Kurnia & Homevisit 24 Jam	6281226370658	\N	Buka 24 Jam	Permata Sendangmulyo, RT.01/RW.29, Sendangmulyo, Kec. Tembalang, Kota Semarang, Jawa Tengah 50272	0101000020ED7F00007B14AE4754EF1A41E17A14968F966141	https://lh3.googleusercontent.com/p/AF1QipP7MzQmGD7-hLhXo1HhNGMbaSt_KkPY6d4evCww=s1360-w1360-h1020	2	14002
11022	Klinik Pratama Amelia Medika	6289666935708	\N	02.00-21.00	Meteseh, Tembalang, Semarang City, Central Java 50271	0101000020ED7F0000E17A14AEAEE61A4114AE4739E2956141	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiuFJApk9Ew-pHYCcwhGfWY32FksJ3J8jhyA&s	0	14002
11036	Corpoderma Aesthetic Clinic Kedungmundu Semarang	6285229534123	\N	10.00-18.00	Jl. Kedungmundu No.7, Kedungmundu, Kec. Tembalang, Kota Semarang, Jawa Tengah 50273	0101000020ED7F000066666666F8EB1A415C8FC28DA5976141	https://lh3.googleusercontent.com/p/AF1QipMgVWV4Xon_YEFy0vv5b-jPXk7PKGV8xZY-NlN2=s1360-w1360-h1020	1	14002
\.


--
-- TOC entry 5809 (class 0 OID 41825)
-- Dependencies: 221
-- Data for Name: kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategori (id_kategori, nama_kategori) FROM stdin;
14001	Rumah Sakit
14002	Klinik
14003	Apotek
14004	Laboratorium
14005	Puskesmas
\.


--
-- TOC entry 5813 (class 0 OID 41912)
-- Dependencies: 225
-- Data for Name: preferensi_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferensi_user (id_preferensi, username, id_kategori, radius_preferensi) FROM stdin;
\.


--
-- TOC entry 5814 (class 0 OID 41930)
-- Dependencies: 226
-- Data for Name: rekomendasi_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rekomendasi_user (id_rekomendasi, username, id_fasilitas, id_preferensi, tanggal_rekomendasi) FROM stdin;
\.


--
-- TOC entry 5630 (class 0 OID 41060)
-- Dependencies: 217
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 5812 (class 0 OID 41880)
-- Dependencies: 224
-- Data for Name: ulasan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ulasan (id_ulasan, id_fasilitas, komentar, rating, tanggal_ulasan, username) FROM stdin;
1	11001	Komentar contoh	4.0	2025-06-04	user123
\.


--
-- TOC entry 5811 (class 0 OID 41865)
-- Dependencies: 223
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (username, id_fasilitas, nama_user, email, tanggal_akses, koordinat_user) FROM stdin;
\.


--
-- TOC entry 5642 (class 2606 OID 41838)
-- Name: fasilitas_kesehatan fasilitas_kesehatan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fasilitas_kesehatan
    ADD CONSTRAINT fasilitas_kesehatan_pkey PRIMARY KEY (id_fasilitas);


--
-- TOC entry 5640 (class 2606 OID 41831)
-- Name: kategori kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id_kategori);


--
-- TOC entry 5650 (class 2606 OID 41919)
-- Name: preferensi_user rekomendasi_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferensi_user
    ADD CONSTRAINT rekomendasi_user_pkey PRIMARY KEY (id_preferensi);


--
-- TOC entry 5652 (class 2606 OID 41937)
-- Name: rekomendasi_user rekomendasi_user_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekomendasi_user
    ADD CONSTRAINT rekomendasi_user_pkey1 PRIMARY KEY (id_rekomendasi);


--
-- TOC entry 5648 (class 2606 OID 41888)
-- Name: ulasan ulasan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ulasan
    ADD CONSTRAINT ulasan_pkey PRIMARY KEY (id_ulasan);


--
-- TOC entry 5644 (class 2606 OID 41874)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5646 (class 2606 OID 41872)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- TOC entry 5653 (class 2606 OID 41839)
-- Name: fasilitas_kesehatan fasilitas_kesehatan_id_kategori_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fasilitas_kesehatan
    ADD CONSTRAINT fasilitas_kesehatan_id_kategori_fkey FOREIGN KEY (id_kategori) REFERENCES public.kategori(id_kategori) ON DELETE CASCADE;


--
-- TOC entry 5658 (class 2606 OID 41943)
-- Name: rekomendasi_user rekomendasi_user_id_fasilitas_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekomendasi_user
    ADD CONSTRAINT rekomendasi_user_id_fasilitas_fkey FOREIGN KEY (id_fasilitas) REFERENCES public.fasilitas_kesehatan(id_fasilitas) ON DELETE CASCADE;


--
-- TOC entry 5656 (class 2606 OID 41925)
-- Name: preferensi_user rekomendasi_user_id_kategori_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferensi_user
    ADD CONSTRAINT rekomendasi_user_id_kategori_fkey FOREIGN KEY (id_kategori) REFERENCES public.kategori(id_kategori) ON DELETE CASCADE;


--
-- TOC entry 5659 (class 2606 OID 41948)
-- Name: rekomendasi_user rekomendasi_user_id_preferensi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekomendasi_user
    ADD CONSTRAINT rekomendasi_user_id_preferensi_fkey FOREIGN KEY (id_preferensi) REFERENCES public.preferensi_user(id_preferensi) ON DELETE CASCADE;


--
-- TOC entry 5657 (class 2606 OID 41920)
-- Name: preferensi_user rekomendasi_user_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferensi_user
    ADD CONSTRAINT rekomendasi_user_username_fkey FOREIGN KEY (username) REFERENCES public.users(username) ON DELETE CASCADE;


--
-- TOC entry 5660 (class 2606 OID 41938)
-- Name: rekomendasi_user rekomendasi_user_username_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekomendasi_user
    ADD CONSTRAINT rekomendasi_user_username_fkey1 FOREIGN KEY (username) REFERENCES public.users(username) ON DELETE CASCADE;


--
-- TOC entry 5655 (class 2606 OID 41894)
-- Name: ulasan ulasan_id_fasilitas_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ulasan
    ADD CONSTRAINT ulasan_id_fasilitas_fkey FOREIGN KEY (id_fasilitas) REFERENCES public.fasilitas_kesehatan(id_fasilitas) ON DELETE CASCADE;


--
-- TOC entry 5654 (class 2606 OID 41875)
-- Name: users users_id_fasilitas_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_fasilitas_fkey FOREIGN KEY (id_fasilitas) REFERENCES public.fasilitas_kesehatan(id_fasilitas) ON DELETE SET NULL;


-- Completed on 2025-06-04 18:48:09

--
-- PostgreSQL database dump complete
--

