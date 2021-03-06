-- USAGE: $ psql -d postgres -U postgres -f sql/setup.sql

CREATE DATABASE zdbtaptests;
\c zdbtaptests 
\set zombodb_url '''http://127.0.0.1:9200/'''


CREATE EXTENSION pgtap;
CREATE EXTENSION hstore;
CREATE EXTENSION zombodb;

CREATE SCHEMA unit_tests;


--**********************************************************************************************************************
CREATE TABLE unit_tests.data(
  pk_data BIGINT
  , data_bigint_1 BIGINT
  , data_bigint_expand_group BIGINT
  , data_bigint_array_1 BIGINT[]
  , data_bigint_array_2 BIGINT[]
  , data_boolean BOOLEAN
  , data_char_1 CHAR(2)
  , data_char_2 CHAR(2)
  , data_char_array_1 CHAR(2)[]
  , data_char_array_2 CHAR(2)[]
  , data_date_1 DATE
  , data_date_2 DATE
  , data_date_array_1 DATE[]
  , data_date_array_2 DATE[]
  , data_full_text fulltext
  , data_full_text_shingles fulltext_with_shingles
  , data_int_1 INT
  , data_int_2 INT
  , data_int_array_1 INT[]
  , data_int_array_2 INT[]
  , data_json JSON
  , data_phrase_1 phrase
  , data_phrase_2 phrase
  , data_phrase_array_1 phrase_array
  , data_phrase_array_2 phrase_array
  , data_text_1 TEXT
  , data_text_filter TEXT
  , data_text_array_1 TEXT[]
  , data_text_array_2 TEXT[]
  , data_timestamp TIMESTAMP
  , data_varchar_1 VARCHAR(25)
  , data_varchar_2 VARCHAR(25)
  , data_varchar_array_1 VARCHAR(25)[]
  , data_varchar_array_2 VARCHAR(25)[]
, CONSTRAINT idx_unit_tests_data_pkey PRIMARY KEY (pk_data)
);

CREATE INDEX es_unit_tests_data ON unit_tests.data USING zombodb (zdb('unit_tests.data', ctid), zdb(data.*)) WITH (url=:zombodb_url, options='pk_data = <var.es_unit_tests_var>pk_var,pk_data = <vol.es_unit_tests_vol>pk_vol', shards='3', replicas='1');
--**********************************************************************************************************************


--**********************************************************************************************************************
CREATE TABLE unit_tests.var(
  pk_var BIGINT
  , var_bigint_1 BIGINT
  , var_bigint_expand_group BIGINT
  , var_bigint_array_1 BIGINT[]
  , var_bigint_array_2 BIGINT[]
  , var_boolean BOOLEAN
  , var_char_1 CHAR(2)
  , var_char_2 CHAR(2)
  , var_char_array_1 CHAR(2)[]
  , var_char_array_2 CHAR(2)[]
  , var_date_1 DATE
  , var_date_2 DATE
  , var_date_array_1 DATE[]
  , var_date_array_2 DATE[]
  , var_int_1 INT
  , var_int_2 INT
  , var_int_array_1 INT[]
  , var_int_array_2 INT[]
  , var_json JSON
  , var_phrase_1 phrase
  , var_phrase_2 phrase
  , var_phrase_array_1 phrase_array
  , var_phrase_array_2 phrase_array
  , var_text_1 TEXT
  , var_text_filter TEXT
  , var_text_array_1 TEXT[]
  , var_text_array_2 TEXT[]
  , var_timestamp TIMESTAMP
  , var_varchar_1 VARCHAR(25)
  , var_varchar_2 VARCHAR(25)
  , var_varchar_array_1 VARCHAR(25)[]
  , var_varchar_array_2 VARCHAR(25)[]
, CONSTRAINT idx_unit_tests_var_pkey PRIMARY KEY (pk_var)
);

CREATE INDEX es_unit_tests_var ON unit_tests.var USING zombodb (zdb('unit_tests.var', ctid), zdb(var.*)) WITH (url=:zombodb_url, shards='3', replicas='1');
--**********************************************************************************************************************


--**********************************************************************************************************************
CREATE TABLE unit_tests.vol(
  pk_vol BIGINT
  , vol_bigint_1 BIGINT
  , vol_bigint_expand_group BIGINT
  , vol_bigint_array_1 BIGINT[]
  , vol_bigint_array_2 BIGINT[]
  , vol_boolean BOOLEAN
  , vol_char_1 CHAR(2)
  , vol_char_2 CHAR(2)
  , vol_char_array_1 CHAR(2)[]
  , vol_char_array_2 CHAR(2)[]
  , vol_date_1 DATE
  , vol_date_2 DATE
  , vol_date_array_1 DATE[]
  , vol_date_array_2 DATE[]
  , vol_int_1 INT
  , vol_int_2 INT
  , vol_int_array_1 INT[]
  , vol_int_array_2 INT[]
  , vol_json JSON
  , vol_phrase_1 phrase
  , vol_phrase_2 phrase
  , vol_phrase_array_1 phrase_array
  , vol_phrase_array_2 phrase_array
  , vol_text_1 TEXT
  , vol_text_filter TEXT
  , vol_text_array_1 TEXT[]
  , vol_text_array_2 TEXT[]
  , vol_timestamp TIMESTAMP
  , vol_varchar_1 VARCHAR(25)
  , vol_varchar_2 VARCHAR(25)
  , vol_varchar_array_1 VARCHAR(25)[]
  , vol_varchar_array_2 VARCHAR(25)[]
, CONSTRAINT idx_unit_tests_vol_pkey PRIMARY KEY (pk_vol)
);

CREATE INDEX es_unit_tests_vol ON unit_tests.vol USING zombodb (zdb('unit_tests.vol', ctid), zdb(vol.*)) WITH (url=:zombodb_url, shards='3', replicas='1');
--**********************************************************************************************************************

-- TODO: RULES/TRIGGERS
--VIEW
--**********************************************************************************************************************
CREATE VIEW unit_tests.consolidated_record_view AS
  SELECT pk_data
    , data_bigint_1
    , data_bigint_expand_group
    , data_bigint_array_1
    , data_bigint_array_2
    , data_boolean
    , data_char_1
    , data_char_2
    , data_char_array_1
    , data_char_array_2
    , data_date_1
    , data_date_2
    , data_date_array_1
    , data_date_array_2
    , data_full_text
    , data_full_text_shingles
    , data_int_1
    , data_int_2
    , data_int_array_1
    , data_int_array_2
    , data_json
    , data_phrase_1
    , data_phrase_2
    , data_phrase_array_1
    , data_phrase_array_2
    , data_text_1
    , data_text_filter
    , data_text_array_1
    , data_text_array_2
    , data_timestamp
    , data_varchar_1
    , data_varchar_2
    , data_varchar_array_1
    , data_varchar_array_2
    , var_bigint_1
    , var_bigint_expand_group
    , var_bigint_array_1
    , var_bigint_array_2
    , var_boolean
    , var_char_1
    , var_char_2
    , var_char_array_1
    , var_char_array_2
    , var_date_1
    , var_date_2
    , var_date_array_1
    , var_date_array_2
    , var_int_1
    , var_int_2
    , var_int_array_1
    , var_int_array_2
    , var_json
    , var_phrase_1
    , var_phrase_2
    , var_phrase_array_1
    , var_phrase_array_2
    , var_text_1
    , var_text_filter
    , var_text_array_1
    , var_text_array_2
    , var_timestamp
    , var_varchar_1
    , var_varchar_2
    , var_varchar_array_1
    , var_varchar_array_2
    , vol_bigint_1
    , vol_bigint_expand_group
    , vol_bigint_array_1
    , vol_bigint_array_2
    , vol_boolean
    , vol_char_1
    , vol_char_2
    , vol_char_array_1
    , vol_char_array_2
    , vol_date_1
    , vol_date_2
    , vol_date_array_1
    , vol_date_array_2
    , vol_int_1
    , vol_int_2
    , vol_int_array_1
    , vol_int_array_2
    , vol_json
    , vol_phrase_1
    , vol_phrase_2
    , vol_phrase_array_1
    , vol_phrase_array_2
    , vol_text_1
    , vol_text_filter
    , vol_text_array_1
    , vol_text_array_2
    , vol_timestamp
    , vol_varchar_1
    , vol_varchar_2
    , vol_varchar_array_1
    , vol_varchar_array_2
    , zdb('unit_tests.data', data.ctid) AS zdb
  FROM unit_tests.data
  LEFT JOIN unit_tests.var ON data.pk_data = var.pk_var
  LEFT JOIN unit_tests.vol ON data.pk_data = vol.pk_vol;
--**********************************************************************************************************************


--LOAD DATA
--**********************************************************************************************************************
\copy unit_tests.data FROM 'src/test/zdbtaptests/raw_data/data.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER);
\copy unit_tests.var FROM 'src/test/zdbtaptests/raw_data/var.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER);
\copy unit_tests.vol FROM 'src/test/zdbtaptests/raw_data/vol.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER);
--**********************************************************************************************************************


--DO SOME HOUSE KEEPING
--**********************************************************************************************************************
VACUUM ANALYZE unit_tests.data;
VACUUM ANALYZE unit_tests.var;
VACUUM ANALYZE unit_tests.vol;
--**********************************************************************************************************************
