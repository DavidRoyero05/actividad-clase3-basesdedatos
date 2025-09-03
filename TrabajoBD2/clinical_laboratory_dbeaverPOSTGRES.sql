--
-- PostgreSQL database dump
--

\restrict df4Ve3BYUyfAs5aFDXDcmEy5VlZWSVycQk5Jv3sxfsjylO9IQfolmStHqvs1E8V

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 17.6

-- Started on 2025-09-03 13:15:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3572 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\unrestrict df4Ve3BYUyfAs5aFDXDcmEy5VlZWSVycQk5Jv3sxfsjylO9IQfolmStHqvs1E8V
\connect postgres
\restrict df4Ve3BYUyfAs5aFDXDcmEy5VlZWSVycQk5Jv3sxfsjylO9IQfolmStHqvs1E8V

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 3572
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 901 (class 1247 OID 57463)
-- Name: data_type_enum; Type: TYPE; Schema: public; Owner: davidr2
--

CREATE TYPE public.data_type_enum AS ENUM (
    'Numeric',
    'Text',
    'Boolean'
);


ALTER TYPE public.data_type_enum OWNER TO davidr2;

--
-- TOC entry 865 (class 1247 OID 57356)
-- Name: order_priority_type; Type: TYPE; Schema: public; Owner: davidr2
--

CREATE TYPE public.order_priority_type AS ENUM (
    'Normal',
    'Urgent'
);


ALTER TYPE public.order_priority_type OWNER TO davidr2;

--
-- TOC entry 868 (class 1247 OID 57362)
-- Name: order_status_type; Type: TYPE; Schema: public; Owner: davidr2
--

CREATE TYPE public.order_status_type AS ENUM (
    'Pending',
    'In_Progress',
    'Reported'
);


ALTER TYPE public.order_status_type OWNER TO davidr2;

--
-- TOC entry 877 (class 1247 OID 57386)
-- Name: payment_method_type; Type: TYPE; Schema: public; Owner: davidr2
--

CREATE TYPE public.payment_method_type AS ENUM (
    'Cash',
    'Card',
    'Transfer',
    'Insurance'
);


ALTER TYPE public.payment_method_type OWNER TO davidr2;

--
-- TOC entry 880 (class 1247 OID 57396)
-- Name: payment_status_type; Type: TYPE; Schema: public; Owner: davidr2
--

CREATE TYPE public.payment_status_type AS ENUM (
    'Pending',
    'Completed',
    'Rejected'
);


ALTER TYPE public.payment_status_type OWNER TO davidr2;

--
-- TOC entry 874 (class 1247 OID 57380)
-- Name: policy_status_type; Type: TYPE; Schema: public; Owner: davidr2
--

CREATE TYPE public.policy_status_type AS ENUM (
    'Active',
    'Expired'
);


ALTER TYPE public.policy_status_type OWNER TO davidr2;

--
-- TOC entry 871 (class 1247 OID 57370)
-- Name: sample_status_type; Type: TYPE; Schema: public; Owner: davidr2
--

CREATE TYPE public.sample_status_type AS ENUM (
    'Collected',
    'In_Progress',
    'Used',
    'Discarded'
);


ALTER TYPE public.sample_status_type OWNER TO davidr2;

--
-- TOC entry 862 (class 1247 OID 57349)
-- Name: sex_type; Type: TYPE; Schema: public; Owner: davidr2
--

CREATE TYPE public.sex_type AS ENUM (
    'M',
    'F',
    'Other'
);


ALTER TYPE public.sex_type OWNER TO davidr2;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 57420)
-- Name: doctors; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.doctors (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    specialty character varying(100),
    phone character varying(50),
    email character varying(100)
);


ALTER TABLE public.doctors OWNER TO davidr2;

--
-- TOC entry 219 (class 1259 OID 57419)
-- Name: doctors_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.doctors ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doctors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 57414)
-- Name: insurers; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.insurers (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone character varying(50),
    email character varying(100)
);


ALTER TABLE public.insurers OWNER TO davidr2;

--
-- TOC entry 217 (class 1259 OID 57413)
-- Name: insurers_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.insurers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.insurers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 57509)
-- Name: insurers_patients; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.insurers_patients (
    patient_id integer NOT NULL,
    insurer_id integer NOT NULL,
    policy_number character varying(50) NOT NULL,
    status public.policy_status_type DEFAULT 'Active'::public.policy_status_type,
    start_date date,
    end_date date
);


ALTER TABLE public.insurers_patients OWNER TO davidr2;

--
-- TOC entry 226 (class 1259 OID 57442)
-- Name: lab_orders; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.lab_orders (
    id integer NOT NULL,
    patient_id integer NOT NULL,
    doctor_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    priority public.order_priority_type DEFAULT 'Normal'::public.order_priority_type,
    status public.order_status_type DEFAULT 'Pending'::public.order_status_type,
    notes text
);


ALTER TABLE public.lab_orders OWNER TO davidr2;

--
-- TOC entry 225 (class 1259 OID 57441)
-- Name: lab_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.lab_orders ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lab_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 57540)
-- Name: lab_orders_tests; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.lab_orders_tests (
    lab_order_id integer NOT NULL,
    test_id integer NOT NULL
);


ALTER TABLE public.lab_orders_tests OWNER TO davidr2;

--
-- TOC entry 222 (class 1259 OID 57426)
-- Name: panels; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.panels (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    estimated_time integer,
    cost numeric(10,2)
);


ALTER TABLE public.panels OWNER TO davidr2;

--
-- TOC entry 221 (class 1259 OID 57425)
-- Name: panels_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.panels ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.panels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 57525)
-- Name: panels_tests; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.panels_tests (
    panel_id integer NOT NULL,
    test_id integer NOT NULL
);


ALTER TABLE public.panels_tests OWNER TO davidr2;

--
-- TOC entry 228 (class 1259 OID 57470)
-- Name: parameters; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.parameters (
    id integer NOT NULL,
    test_id integer NOT NULL,
    name character varying(100) NOT NULL,
    unit character varying(50),
    reference_values character varying(100),
    data_type public.data_type_enum DEFAULT 'Text'::public.data_type_enum
);


ALTER TABLE public.parameters OWNER TO davidr2;

--
-- TOC entry 227 (class 1259 OID 57469)
-- Name: parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.parameters ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 57404)
-- Name: patients; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.patients (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    document_number character varying(50) NOT NULL,
    birth_date date,
    sex public.sex_type,
    address character varying(150),
    phone character varying(50),
    email character varying(100)
);


ALTER TABLE public.patients OWNER TO davidr2;

--
-- TOC entry 215 (class 1259 OID 57403)
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.patients ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 57497)
-- Name: payments; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    lab_order_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    payment_method public.payment_method_type,
    status public.payment_status_type DEFAULT 'Pending'::public.payment_status_type
);


ALTER TABLE public.payments OWNER TO davidr2;

--
-- TOC entry 231 (class 1259 OID 57496)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.payments ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 57556)
-- Name: results; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.results (
    id integer NOT NULL,
    sample_id integer NOT NULL,
    parameter_id integer NOT NULL,
    value character varying(100),
    result_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    doctor_id integer
);


ALTER TABLE public.results OWNER TO davidr2;

--
-- TOC entry 236 (class 1259 OID 57555)
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.results ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 57482)
-- Name: samples; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.samples (
    id integer NOT NULL,
    lab_order_id integer NOT NULL,
    type character varying(100),
    collected_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public.sample_status_type DEFAULT 'Collected'::public.sample_status_type,
    notes text
);


ALTER TABLE public.samples OWNER TO davidr2;

--
-- TOC entry 229 (class 1259 OID 57481)
-- Name: samples_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.samples ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.samples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 57434)
-- Name: tests; Type: TABLE; Schema: public; Owner: davidr2
--

CREATE TABLE public.tests (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    sample_type character varying(100),
    estimated_time integer,
    cost numeric(10,2)
);


ALTER TABLE public.tests OWNER TO davidr2;

--
-- TOC entry 223 (class 1259 OID 57433)
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: davidr2
--

ALTER TABLE public.tests ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3549 (class 0 OID 57420)
-- Dependencies: 220
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.doctors (id, first_name, last_name, specialty, phone, email) FROM stdin;
\.


--
-- TOC entry 3547 (class 0 OID 57414)
-- Dependencies: 218
-- Data for Name: insurers; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.insurers (id, name, phone, email) FROM stdin;
\.


--
-- TOC entry 3562 (class 0 OID 57509)
-- Dependencies: 233
-- Data for Name: insurers_patients; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.insurers_patients (patient_id, insurer_id, policy_number, status, start_date, end_date) FROM stdin;
\.


--
-- TOC entry 3555 (class 0 OID 57442)
-- Dependencies: 226
-- Data for Name: lab_orders; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.lab_orders (id, patient_id, doctor_id, order_date, priority, status, notes) FROM stdin;
\.


--
-- TOC entry 3564 (class 0 OID 57540)
-- Dependencies: 235
-- Data for Name: lab_orders_tests; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.lab_orders_tests (lab_order_id, test_id) FROM stdin;
\.


--
-- TOC entry 3551 (class 0 OID 57426)
-- Dependencies: 222
-- Data for Name: panels; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.panels (id, name, description, estimated_time, cost) FROM stdin;
\.


--
-- TOC entry 3563 (class 0 OID 57525)
-- Dependencies: 234
-- Data for Name: panels_tests; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.panels_tests (panel_id, test_id) FROM stdin;
\.


--
-- TOC entry 3557 (class 0 OID 57470)
-- Dependencies: 228
-- Data for Name: parameters; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.parameters (id, test_id, name, unit, reference_values, data_type) FROM stdin;
\.


--
-- TOC entry 3545 (class 0 OID 57404)
-- Dependencies: 216
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.patients (id, first_name, last_name, document_number, birth_date, sex, address, phone, email) FROM stdin;
\.


--
-- TOC entry 3561 (class 0 OID 57497)
-- Dependencies: 232
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.payments (id, lab_order_id, amount, payment_date, payment_method, status) FROM stdin;
\.


--
-- TOC entry 3566 (class 0 OID 57556)
-- Dependencies: 237
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.results (id, sample_id, parameter_id, value, result_date, doctor_id) FROM stdin;
\.


--
-- TOC entry 3559 (class 0 OID 57482)
-- Dependencies: 230
-- Data for Name: samples; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.samples (id, lab_order_id, type, collected_at, status, notes) FROM stdin;
\.


--
-- TOC entry 3553 (class 0 OID 57434)
-- Dependencies: 224
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: davidr2
--

COPY public.tests (id, name, description, sample_type, estimated_time, cost) FROM stdin;
\.


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 219
-- Name: doctors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.doctors_id_seq', 1, false);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 217
-- Name: insurers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.insurers_id_seq', 1, false);


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 225
-- Name: lab_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.lab_orders_id_seq', 1, false);


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 221
-- Name: panels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.panels_id_seq', 1, false);


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 227
-- Name: parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.parameters_id_seq', 1, false);


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 215
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.patients_id_seq', 1, false);


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 231
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 236
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.results_id_seq', 1, false);


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 229
-- Name: samples_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.samples_id_seq', 1, false);


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 223
-- Name: tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: davidr2
--

SELECT pg_catalog.setval('public.tests_id_seq', 1, false);


--
-- TOC entry 3366 (class 2606 OID 57424)
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (id);


--
-- TOC entry 3380 (class 2606 OID 57514)
-- Name: insurers_patients insurers_patients_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.insurers_patients
    ADD CONSTRAINT insurers_patients_pkey PRIMARY KEY (patient_id, insurer_id, policy_number);


--
-- TOC entry 3364 (class 2606 OID 57418)
-- Name: insurers insurers_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.insurers
    ADD CONSTRAINT insurers_pkey PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 57451)
-- Name: lab_orders lab_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.lab_orders
    ADD CONSTRAINT lab_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3384 (class 2606 OID 57544)
-- Name: lab_orders_tests lab_orders_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.lab_orders_tests
    ADD CONSTRAINT lab_orders_tests_pkey PRIMARY KEY (lab_order_id, test_id);


--
-- TOC entry 3368 (class 2606 OID 57432)
-- Name: panels panels_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.panels
    ADD CONSTRAINT panels_pkey PRIMARY KEY (id);


--
-- TOC entry 3382 (class 2606 OID 57529)
-- Name: panels_tests panels_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.panels_tests
    ADD CONSTRAINT panels_tests_pkey PRIMARY KEY (panel_id, test_id);


--
-- TOC entry 3374 (class 2606 OID 57475)
-- Name: parameters parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.parameters
    ADD CONSTRAINT parameters_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 57412)
-- Name: patients patients_document_number_key; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_document_number_key UNIQUE (document_number);


--
-- TOC entry 3362 (class 2606 OID 57410)
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 3378 (class 2606 OID 57503)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- TOC entry 3386 (class 2606 OID 57561)
-- Name: results results_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- TOC entry 3376 (class 2606 OID 57490)
-- Name: samples samples_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.samples
    ADD CONSTRAINT samples_pkey PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 57440)
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- TOC entry 3392 (class 2606 OID 57520)
-- Name: insurers_patients insurers_patients_insurer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.insurers_patients
    ADD CONSTRAINT insurers_patients_insurer_id_fkey FOREIGN KEY (insurer_id) REFERENCES public.insurers(id);


--
-- TOC entry 3393 (class 2606 OID 57515)
-- Name: insurers_patients insurers_patients_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.insurers_patients
    ADD CONSTRAINT insurers_patients_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- TOC entry 3387 (class 2606 OID 57457)
-- Name: lab_orders lab_orders_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.lab_orders
    ADD CONSTRAINT lab_orders_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctors(id);


--
-- TOC entry 3388 (class 2606 OID 57452)
-- Name: lab_orders lab_orders_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.lab_orders
    ADD CONSTRAINT lab_orders_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- TOC entry 3396 (class 2606 OID 57545)
-- Name: lab_orders_tests lab_orders_tests_lab_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.lab_orders_tests
    ADD CONSTRAINT lab_orders_tests_lab_order_id_fkey FOREIGN KEY (lab_order_id) REFERENCES public.lab_orders(id);


--
-- TOC entry 3397 (class 2606 OID 57550)
-- Name: lab_orders_tests lab_orders_tests_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.lab_orders_tests
    ADD CONSTRAINT lab_orders_tests_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id);


--
-- TOC entry 3394 (class 2606 OID 57530)
-- Name: panels_tests panels_tests_panel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.panels_tests
    ADD CONSTRAINT panels_tests_panel_id_fkey FOREIGN KEY (panel_id) REFERENCES public.panels(id);


--
-- TOC entry 3395 (class 2606 OID 57535)
-- Name: panels_tests panels_tests_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.panels_tests
    ADD CONSTRAINT panels_tests_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id);


--
-- TOC entry 3389 (class 2606 OID 57476)
-- Name: parameters parameters_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.parameters
    ADD CONSTRAINT parameters_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id);


--
-- TOC entry 3391 (class 2606 OID 57504)
-- Name: payments payments_lab_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_lab_order_id_fkey FOREIGN KEY (lab_order_id) REFERENCES public.lab_orders(id);


--
-- TOC entry 3398 (class 2606 OID 57572)
-- Name: results results_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctors(id);


--
-- TOC entry 3399 (class 2606 OID 57567)
-- Name: results results_parameter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_parameter_id_fkey FOREIGN KEY (parameter_id) REFERENCES public.parameters(id);


--
-- TOC entry 3400 (class 2606 OID 57562)
-- Name: results results_sample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES public.samples(id);


--
-- TOC entry 3390 (class 2606 OID 57491)
-- Name: samples samples_lab_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: davidr2
--

ALTER TABLE ONLY public.samples
    ADD CONSTRAINT samples_lab_order_id_fkey FOREIGN KEY (lab_order_id) REFERENCES public.lab_orders(id);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO davidr2;


--
-- TOC entry 2119 (class 826 OID 40961)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT ON TABLES TO davidr2;


-- Completed on 2025-09-03 13:15:52

--
-- PostgreSQL database dump complete
--

\unrestrict df4Ve3BYUyfAs5aFDXDcmEy5VlZWSVycQk5Jv3sxfsjylO9IQfolmStHqvs1E8V

