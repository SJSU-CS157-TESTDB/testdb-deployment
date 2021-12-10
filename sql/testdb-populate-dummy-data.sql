--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-12-09 22:51:22

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
-- TOC entry 218 (class 1259 OID 17411)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    project_id integer NOT NULL,
    project_name text NOT NULL,
    client integer NOT NULL
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17443)
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    task_id integer NOT NULL,
    name text NOT NULL,
    order_id integer NOT NULL,
    status text NOT NULL,
    selected_fullfillment integer,
    standard integer NOT NULL
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17427)
-- Name: work_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work_orders (
    order_id integer NOT NULL,
    project integer NOT NULL,
    quoted_hours integer,
    worked_hours integer NOT NULL,
    completion_date_estimate text NOT NULL
);


ALTER TABLE public.work_orders OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17517)
-- Name: Unreviewed Test Data; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Unreviewed Test Data" AS
 SELECT tasks.task_id,
    projects.project_name,
    tasks.order_id,
    tasks.name,
    tasks.status
   FROM ((public.tasks
     JOIN public.work_orders ON ((tasks.order_id = work_orders.order_id)))
     JOIN public.projects ON ((work_orders.project = projects.project_id)))
  WHERE (tasks.status = 'Tested'::text);


ALTER TABLE public."Unreviewed Test Data" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17513)
-- Name: Work Orders Over Budget; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Work Orders Over Budget" AS
 SELECT projects.project_name,
    work_orders.order_id,
    work_orders.quoted_hours,
    work_orders.worked_hours
   FROM (public.work_orders
     JOIN public.projects ON ((work_orders.project = projects.project_id)))
  WHERE (work_orders.worked_hours > work_orders.quoted_hours);


ALTER TABLE public."Work Orders Over Budget" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17400)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    client_id integer NOT NULL,
    name text NOT NULL,
    contact_name text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    country text NOT NULL,
    zipcode character varying(5) NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17509)
-- Name: Work Overview; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Work Overview" AS
 SELECT projects.project_name,
    clients.name,
    work_orders.order_id,
    work_orders.quoted_hours,
    work_orders.worked_hours,
    work_orders.completion_date_estimate
   FROM ((public.work_orders
     JOIN public.projects ON ((work_orders.project = projects.project_id)))
     JOIN public.clients ON ((projects.client = clients.client_id)));


ALTER TABLE public."Work Overview" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17398)
-- Name: clients_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_client_id_seq OWNER TO postgres;

--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 215
-- Name: clients_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_client_id_seq OWNED BY public.clients.client_id;


--
-- TOC entry 206 (class 1259 OID 17320)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    department_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17318)
-- Name: departments_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_department_id_seq OWNER TO postgres;

--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 205
-- Name: departments_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_department_id_seq OWNED BY public.departments.department_id;


--
-- TOC entry 210 (class 1259 OID 17342)
-- Name: labs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.labs (
    lab_id integer NOT NULL,
    name text NOT NULL,
    department integer NOT NULL,
    site integer NOT NULL
);


ALTER TABLE public.labs OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 17340)
-- Name: labs_lab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.labs_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.labs_lab_id_seq OWNER TO postgres;

--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 209
-- Name: labs_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.labs_lab_id_seq OWNED BY public.labs.lab_id;


--
-- TOC entry 217 (class 1259 OID 17409)
-- Name: projects_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_project_id_seq OWNER TO postgres;

--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 217
-- Name: projects_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_project_id_seq OWNED BY public.projects.project_id;


--
-- TOC entry 208 (class 1259 OID 17331)
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sites (
    site_id integer NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    country text NOT NULL,
    zipcode text NOT NULL
);


ALTER TABLE public.sites OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 17329)
-- Name: sites_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sites_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sites_site_id_seq OWNER TO postgres;

--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 207
-- Name: sites_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sites_site_id_seq OWNED BY public.sites.site_id;


--
-- TOC entry 221 (class 1259 OID 17441)
-- Name: tasks_task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_task_id_seq OWNER TO postgres;

--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 221
-- Name: tasks_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_task_id_seq OWNED BY public.tasks.task_id;


--
-- TOC entry 226 (class 1259 OID 17490)
-- Name: test_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_data (
    testdata_id integer NOT NULL,
    test integer NOT NULL,
    type text NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.test_data OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17488)
-- Name: test_data_testdata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_data_testdata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_data_testdata_id_seq OWNER TO postgres;

--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 225
-- Name: test_data_testdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_data_testdata_id_seq OWNED BY public.test_data.testdata_id;


--
-- TOC entry 214 (class 1259 OID 17384)
-- Name: test_standards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_standards (
    standard_id integer NOT NULL,
    name text NOT NULL,
    region text NOT NULL,
    standard_owner integer NOT NULL
);


ALTER TABLE public.test_standards OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 17382)
-- Name: test_standards_standard_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_standards_standard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_standards_standard_id_seq OWNER TO postgres;

--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 213
-- Name: test_standards_standard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_standards_standard_id_seq OWNED BY public.test_standards.standard_id;


--
-- TOC entry 224 (class 1259 OID 17464)
-- Name: tests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tests (
    test_id integer NOT NULL,
    task_id integer NOT NULL,
    tester integer NOT NULL,
    lab integer NOT NULL,
    test_date text NOT NULL,
    test_result text NOT NULL
);


ALTER TABLE public.tests OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17462)
-- Name: tests_test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tests_test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tests_test_id_seq OWNER TO postgres;

--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 223
-- Name: tests_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tests_test_id_seq OWNED BY public.tests.test_id;


--
-- TOC entry 201 (class 1259 OID 17283)
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permissions (
    permission_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.user_permissions OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17281)
-- Name: user_permissions_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_permissions_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_permissions_permission_id_seq OWNER TO postgres;

--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 200
-- Name: user_permissions_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_permissions_permission_id_seq OWNED BY public.user_permissions.permission_id;


--
-- TOC entry 204 (class 1259 OID 17303)
-- Name: user_role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_permissions (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.user_role_permissions OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17294)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    role_id integer NOT NULL,
    role_name text NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 17292)
-- Name: user_roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_roles_role_id_seq OWNER TO postgres;

--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 202
-- Name: user_roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_roles_role_id_seq OWNED BY public.user_roles.role_id;


--
-- TOC entry 212 (class 1259 OID 17363)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    employee_id integer NOT NULL,
    name text NOT NULL,
    password text NOT NULL,
    role integer NOT NULL,
    department integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 17361)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 219 (class 1259 OID 17425)
-- Name: work_orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.work_orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 219
-- Name: work_orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.work_orders_order_id_seq OWNED BY public.work_orders.order_id;


--
-- TOC entry 2958 (class 2604 OID 17403)
-- Name: clients client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN client_id SET DEFAULT nextval('public.clients_client_id_seq'::regclass);


--
-- TOC entry 2953 (class 2604 OID 17323)
-- Name: departments department_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN department_id SET DEFAULT nextval('public.departments_department_id_seq'::regclass);


--
-- TOC entry 2955 (class 2604 OID 17345)
-- Name: labs lab_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labs ALTER COLUMN lab_id SET DEFAULT nextval('public.labs_lab_id_seq'::regclass);


--
-- TOC entry 2959 (class 2604 OID 17414)
-- Name: projects project_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN project_id SET DEFAULT nextval('public.projects_project_id_seq'::regclass);


--
-- TOC entry 2954 (class 2604 OID 17334)
-- Name: sites site_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites ALTER COLUMN site_id SET DEFAULT nextval('public.sites_site_id_seq'::regclass);


--
-- TOC entry 2961 (class 2604 OID 17446)
-- Name: tasks task_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN task_id SET DEFAULT nextval('public.tasks_task_id_seq'::regclass);


--
-- TOC entry 2963 (class 2604 OID 17493)
-- Name: test_data testdata_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_data ALTER COLUMN testdata_id SET DEFAULT nextval('public.test_data_testdata_id_seq'::regclass);


--
-- TOC entry 2957 (class 2604 OID 17387)
-- Name: test_standards standard_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_standards ALTER COLUMN standard_id SET DEFAULT nextval('public.test_standards_standard_id_seq'::regclass);


--
-- TOC entry 2962 (class 2604 OID 17467)
-- Name: tests test_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests ALTER COLUMN test_id SET DEFAULT nextval('public.tests_test_id_seq'::regclass);


--
-- TOC entry 2951 (class 2604 OID 17286)
-- Name: user_permissions permission_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions ALTER COLUMN permission_id SET DEFAULT nextval('public.user_permissions_permission_id_seq'::regclass);


--
-- TOC entry 2952 (class 2604 OID 17297)
-- Name: user_roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN role_id SET DEFAULT nextval('public.user_roles_role_id_seq'::regclass);


--
-- TOC entry 2956 (class 2604 OID 17366)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 2960 (class 2604 OID 17430)
-- Name: work_orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders ALTER COLUMN order_id SET DEFAULT nextval('public.work_orders_order_id_seq'::regclass);


--
-- TOC entry 3156 (class 0 OID 17400)
-- Dependencies: 216
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (client_id, name, contact_name, address, city, state, country, zipcode) FROM stdin;
1	Client 1	John Smith	123 Main Street	Anytown	CA	USA	12345
2	Client 2	Jane Smith	456 Main Street	Anytown	CA	USA	12345
3	Client 3	Joe Smith	789 Main Street	Anytown	CA	USA	12345
\.


--
-- TOC entry 3146 (class 0 OID 17320)
-- Dependencies: 206
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (department_id, name) FROM stdin;
6	RF
7	SAR
8	Sales
9	Management
10	Technical
\.


--
-- TOC entry 3150 (class 0 OID 17342)
-- Dependencies: 210
-- Data for Name: labs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.labs (lab_id, name, department, site) FROM stdin;
19	RF Lab 1	6	4
20	RF Lab 2	6	5
21	RF Lab 3	6	6
22	SAR Lab 4	7	4
23	SAR Lab 5	7	5
24	SAR Lab 6	7	6
\.


--
-- TOC entry 3158 (class 0 OID 17411)
-- Dependencies: 218
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (project_id, project_name, client) FROM stdin;
1	Project 1	1
2	Project 2	2
3	Project 3	3
\.


--
-- TOC entry 3148 (class 0 OID 17331)
-- Dependencies: 208
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sites (site_id, name, address, city, state, country, zipcode) FROM stdin;
4	Site 1	123 Main Street	Anytown	CA	USA	12345
5	Site 2	456 Main Street	Anytown	CA	USA	12345
6	Site 3	789 Main Street	Anytown	CA	USA	12345
\.


--
-- TOC entry 3162 (class 0 OID 17443)
-- Dependencies: 222
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (task_id, name, order_id, status, selected_fullfillment, standard) FROM stdin;
77	Task 1	1	Tested	\N	3
78	Task 2	1	Tested	\N	3
79	Task 3	1	Tested	\N	3
80	Task 4	1	Tested	\N	3
81	Task 5	1	Tested	\N	3
82	Task 6	1	Tested	\N	3
83	Task 7	1	Tested	\N	3
84	Task 8	1	Tested	\N	3
85	Task 9	1	Tested	\N	3
86	Task 10	1	Open	\N	3
87	Task 11	1	Open	\N	3
88	Task 12	2	Open	\N	3
89	Task 13	2	Open	\N	3
90	Task 14	2	Open	\N	3
91	Task 15	2	Open	\N	3
92	Task 16	2	Open	\N	3
93	Task 17	2	Open	\N	3
94	Task 18	2	Open	\N	3
95	Task 19	1	Open	\N	3
96	Task 20	1	Open	\N	3
97	Task 21	1	Open	\N	3
98	Task 22	1	Open	\N	3
99	Task 23	1	Open	\N	3
100	Task 24	1	Open	\N	3
101	Task 25	1	Reviewed	\N	4
102	Task 26	1	Reviewed	\N	4
103	Task 27	1	Reviewed	\N	4
104	Task 28	1	Reviewed	\N	4
105	Task 29	1	Reviewed	\N	4
106	Task 30	1	Reviewed	\N	4
107	Task 31	1	Reviewed	\N	4
108	Task 32	1	Reviewed	\N	4
109	Task 33	1	Finalized	\N	4
110	Task 34	1	Finalized	\N	4
111	Task 35	1	Finalized	\N	4
112	Task 36	1	Finalized	\N	4
113	Task 37	1	Finalized	\N	4
114	Task 38	1	Finalized	\N	4
\.


--
-- TOC entry 3166 (class 0 OID 17490)
-- Dependencies: 226
-- Data for Name: test_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_data (testdata_id, test, type, data) FROM stdin;
1	191	spectrum_plot_url	https://rfmw.em.keysight.com/rfcomms/refdocs/wcdma/wcdma_meas_spec_em_mask_desc-1.gif
2	192	dbm_scalar	16.7
3	193	dbm_scalar	16.5
4	194	dbm_scalar	15.5
5	195	dbm_scalar	21.5
6	196	dbm_scalar	20.5
7	197	dbm_scalar	18.5
8	198	dbm_scalar	17.2
9	199	dbm_scalar	16.5
\.


--
-- TOC entry 3154 (class 0 OID 17384)
-- Dependencies: 214
-- Data for Name: test_standards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_standards (standard_id, name, region, standard_owner) FROM stdin;
3	802.11	RF	16
4	LTE	RF	16
\.


--
-- TOC entry 3164 (class 0 OID 17464)
-- Dependencies: 224
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tests (test_id, task_id, tester, lab, test_date, test_result) FROM stdin;
191	77	13	19	2021-1-1	Passed
192	78	13	19	2021-1-1	Failed
193	79	13	19	2021-1-1	Passed
194	80	13	19	2021-1-1	Passed
195	81	13	19	2021-1-1	Passed
196	82	13	20	2021-1-1	Passed
197	83	13	20	2021-1-1	Passed
198	84	13	20	2021-1-1	Passed
199	85	13	20	2021-1-1	Passed
200	86	13	20	2021-1-1	Passed
\.


--
-- TOC entry 3141 (class 0 OID 17283)
-- Dependencies: 201
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_permissions (permission_id, name) FROM stdin;
1	Full Access
2	Submit Test Data
3	Review Test Data
4	Compile Report
5	Create/Edit Standards
6	Read Standards
7	Create Projects
8	Create Work Orders
9	Review Report
10	View Business Insights
11	Schedule Test Dates
\.


--
-- TOC entry 3144 (class 0 OID 17303)
-- Dependencies: 204
-- Data for Name: user_role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_permissions (role_id, permission_id) FROM stdin;
1	1
2	6
2	7
2	8
2	9
2	10
3	2
3	6
4	6
4	3
5	6
5	4
6	6
6	5
7	6
7	8
7	10
\.


--
-- TOC entry 3143 (class 0 OID 17294)
-- Dependencies: 203
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (role_id, role_name) FROM stdin;
1	Administrator
2	Project Manager
3	Test Staff
4	Test Review Staff
5	Report Writer
6	Standard Owner
7	Sales Representative
\.


--
-- TOC entry 3152 (class 0 OID 17363)
-- Dependencies: 212
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, employee_id, name, password, role, department) FROM stdin;
13	12345	John Smith	password	1	6
14	23456	Jane Smith	password	2	7
15	34567	Joe Smith	password	3	8
16	45678	John Doe	password	4	9
17	56789	Jane Doe	password	5	10
18	67890	Joe Doe	password	6	6
\.


--
-- TOC entry 3160 (class 0 OID 17427)
-- Dependencies: 220
-- Data for Name: work_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work_orders (order_id, project, quoted_hours, worked_hours, completion_date_estimate) FROM stdin;
1	1	100	50	2022-02-11
2	2	100	101	2021-12-30
3	3	100	200	2022-01-01
\.


--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 215
-- Name: clients_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_client_id_seq', 3, true);


--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 205
-- Name: departments_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_department_id_seq', 10, true);


--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 209
-- Name: labs_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.labs_lab_id_seq', 24, true);


--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 217
-- Name: projects_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_project_id_seq', 3, true);


--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 207
-- Name: sites_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sites_site_id_seq', 6, true);


--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 221
-- Name: tasks_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_task_id_seq', 114, true);


--
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 225
-- Name: test_data_testdata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_data_testdata_id_seq', 9, true);


--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 213
-- Name: test_standards_standard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_standards_standard_id_seq', 4, true);


--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 223
-- Name: tests_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tests_test_id_seq', 200, true);


--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 200
-- Name: user_permissions_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_permissions_permission_id_seq', 11, true);


--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 202
-- Name: user_roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_roles_role_id_seq', 7, true);


--
-- TOC entry 3196 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 18, true);


--
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 219
-- Name: work_orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_orders_order_id_seq', 3, true);


--
-- TOC entry 2981 (class 2606 OID 17408)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (client_id);


--
-- TOC entry 2971 (class 2606 OID 17328)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (department_id);


--
-- TOC entry 2975 (class 2606 OID 17350)
-- Name: labs labs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labs
    ADD CONSTRAINT labs_pkey PRIMARY KEY (lab_id);


--
-- TOC entry 2983 (class 2606 OID 17419)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);


--
-- TOC entry 2973 (class 2606 OID 17339)
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (site_id);


--
-- TOC entry 2987 (class 2606 OID 17451)
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2991 (class 2606 OID 17498)
-- Name: test_data test_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_data
    ADD CONSTRAINT test_data_pkey PRIMARY KEY (testdata_id);


--
-- TOC entry 2979 (class 2606 OID 17392)
-- Name: test_standards test_standards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_standards
    ADD CONSTRAINT test_standards_pkey PRIMARY KEY (standard_id);


--
-- TOC entry 2989 (class 2606 OID 17472)
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (test_id);


--
-- TOC entry 2965 (class 2606 OID 17291)
-- Name: user_permissions user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY (permission_id);


--
-- TOC entry 2969 (class 2606 OID 17307)
-- Name: user_role_permissions user_role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_permissions
    ADD CONSTRAINT user_role_permissions_pkey PRIMARY KEY (role_id, permission_id);


--
-- TOC entry 2967 (class 2606 OID 17302)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (role_id);


--
-- TOC entry 2977 (class 2606 OID 17371)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2985 (class 2606 OID 17435)
-- Name: work_orders work_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3002 (class 2606 OID 17504)
-- Name: tasks fk_tasks_tests; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_tasks_tests FOREIGN KEY (selected_fullfillment) REFERENCES public.tests(test_id);


--
-- TOC entry 2994 (class 2606 OID 17351)
-- Name: labs labs_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labs
    ADD CONSTRAINT labs_department_fkey FOREIGN KEY (department) REFERENCES public.departments(department_id);


--
-- TOC entry 2995 (class 2606 OID 17356)
-- Name: labs labs_site_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labs
    ADD CONSTRAINT labs_site_fkey FOREIGN KEY (site) REFERENCES public.sites(site_id);


--
-- TOC entry 2999 (class 2606 OID 17420)
-- Name: projects projects_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_client_fkey FOREIGN KEY (client) REFERENCES public.clients(client_id);


--
-- TOC entry 3001 (class 2606 OID 17452)
-- Name: tasks tasks_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.work_orders(order_id);


--
-- TOC entry 3006 (class 2606 OID 17499)
-- Name: test_data test_data_test_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_data
    ADD CONSTRAINT test_data_test_fkey FOREIGN KEY (test) REFERENCES public.tests(test_id);


--
-- TOC entry 2998 (class 2606 OID 17393)
-- Name: test_standards test_standards_standard_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_standards
    ADD CONSTRAINT test_standards_standard_owner_fkey FOREIGN KEY (standard_owner) REFERENCES public.users(user_id);


--
-- TOC entry 3005 (class 2606 OID 17483)
-- Name: tests tests_lab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_lab_fkey FOREIGN KEY (lab) REFERENCES public.labs(lab_id);


--
-- TOC entry 3003 (class 2606 OID 17473)
-- Name: tests tests_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(task_id);


--
-- TOC entry 3004 (class 2606 OID 17478)
-- Name: tests tests_tester_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_tester_fkey FOREIGN KEY (tester) REFERENCES public.users(user_id);


--
-- TOC entry 2993 (class 2606 OID 17313)
-- Name: user_role_permissions user_role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_permissions
    ADD CONSTRAINT user_role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.user_permissions(permission_id);


--
-- TOC entry 2992 (class 2606 OID 17308)
-- Name: user_role_permissions user_role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_permissions
    ADD CONSTRAINT user_role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.user_roles(role_id);


--
-- TOC entry 2997 (class 2606 OID 17377)
-- Name: users users_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_department_fkey FOREIGN KEY (department) REFERENCES public.departments(department_id);


--
-- TOC entry 2996 (class 2606 OID 17372)
-- Name: users users_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_fkey FOREIGN KEY (role) REFERENCES public.user_roles(role_id);


--
-- TOC entry 3000 (class 2606 OID 17436)
-- Name: work_orders work_orders_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_orders
    ADD CONSTRAINT work_orders_project_fkey FOREIGN KEY (project) REFERENCES public.projects(project_id);


-- Completed on 2021-12-09 22:51:23

--
-- PostgreSQL database dump complete
--

