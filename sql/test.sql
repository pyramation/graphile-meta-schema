-- https://en.wikipedia.org/wiki/Role-based_access_control
BEGIN;
CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION IF NOT EXISTS postgis;
DROP SCHEMA IF EXISTS app_meta CASCADE;
CREATE SCHEMA app_meta;
CREATE TABLE app_meta.users (
    id serial PRIMARY KEY,
    username citext,
    UNIQUE (username),
    CHECK (length(username) < 127)
);
CREATE TABLE app_meta.roles (
    id serial PRIMARY KEY,
    org_id bigint NOT NULL REFERENCES app_meta.users (id)
);
CREATE TABLE app_meta.user_settings (
    user_id bigint NOT NULL PRIMARY KEY REFERENCES app_meta.users (id),
    setting1 text,
    UNIQUE (user_id)
);
CREATE TABLE app_meta.permissions (
    id serial PRIMARY KEY,
    name citext
);
CREATE TABLE app_meta.permission_assignment (
    perm_id bigint NOT NULL REFERENCES app_meta.permissions (id),
    role_id bigint NOT NULL REFERENCES app_meta.roles (id),
    PRIMARY KEY (perm_id, role_id)
);
CREATE TABLE app_meta.subject_assignment (
    subj_id bigint NOT NULL REFERENCES app_meta.users (id),
    role_id bigint NOT NULL REFERENCES app_meta.roles (id),
    PRIMARY KEY (subj_id, role_id)
);
CREATE TABLE app_meta.bounding_box (
    id serial PRIMARY KEY NOT NULL,
    zip int,
    LOCATION geometry(point, 4326),
    bbox geometry(polygon, 4326)
);
CREATE TABLE app_meta.zip_codes (
    id serial PRIMARY KEY NOT NULL,
    zip int,
    LOCATION geometry(point, 4326)
);
COMMENT ON TABLE app_meta.zip_codes IS '@name postcode';
COMMENT ON COLUMN app_meta.zip_codes.zip IS '@name zip_code';
CREATE TABLE app_meta.all_types (
    bigint_type bigint,
    bigserial_type bigserial,
    bit_opt_1_type bit(1),
    bit_opt_2_type bit(2),
    bit_opt_16_type bit(16),
    bit_varying_opt_1_type varbit(1),
    bit_varying_opt_2_type varbit(2),
    bool_type bool,
    boolean_type boolean,
    box_type box,
    bytea_type bytea,
    char_opt_1_type char(1),
    char_opt_140_type char(140),
    char_opt_1000_type char(1000),
    char_type char,
    character_type character,
    character_varying_opt_1_type character varying(1),
    character_varying_opt_10_type character varying(10),
    character_varying_opt_140_type character varying(140),
    character_varying_opt_1000_type character varying(1000),
    character_varying_type character varying,
    cidr_type cidr,
    circle_type circle,
    date_type date,
    double_precision_type double precision,
    float_4_type float4,
    float_8_type float8,
    float_type float,
    float_opt_1_type float (1),
    float_opt_2_type float (2),
    float_opt_3_type float (3),
    float_opt_4_type float (4),
    float_opt_5_type float (5),
    float_opt_6_type float (6),
    float_opt_7_type float (7),
    float_opt_8_type float (8),
    geometry_point_type geometry(point, 4326),
    geometry_polygon_type geometry(polygon, 4326),
    inet_type inet,
    int_type int,
    int2_type int2,
    int4_type int4,
    int8_type int8,
    interval_year_type interval year,
    interval_month_type interval month,
    -- interval_week_type interval week,
    interval_day_type interval day,
    interval_hour_type interval hour,
    interval_minute_type interval minute,
    interval_second_type interval second,
    interval_type interval,
    json_type json,
    jsonb_type jsonb,
    line_type line,
    lseg_type lseg,
    macaddr_type macaddr,
    money_type money,
    numeric_type numeric,
    numeric_opt_type numeric(10, 10),
    path_type path,
    pg_lsn_type pg_lsn,
    point_type point,
    polygon_type polygon,
    real_type real,
    serial_type serial,
    serial4_type serial4,
    serial8_type serial8,
    smallint_type smallint,
    text_type text,
    time_opt_2_type time(2) without time zone,
    time_type time,
    timestamp_type timestamp,
    timestamptz_type timestamptz,
    timetz_opt_2_type time(2) with time zone,
    timetz_type timetz,
    tsquery_type tsquery,
    tsvector_type tsvector,
    uuid_type uuid,
    varbit_1_type varbit(1),
    varbit_2_type varbit(2),
    varbit_16_type varbit(16),
    varbit_type varbit,
    varchar_opt_1_type varchar(1),
    varchar_opt_140_type varchar(140),
    varchar_opt_1000_type varchar(1000),
    varchar_type varchar,
    xml_type xml
);
COMMIT;

