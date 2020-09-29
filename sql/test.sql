-- https://en.wikipedia.org/wiki/Role-based_access_control
BEGIN;
CREATE EXTENSION IF NOT EXISTS citext;
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
COMMIT;

