CREATE TABLE IF NOT EXISTS "brigade"
(
    "brigade_id"        serial PRIMARY KEY,
    "address"           text           NOT NULL,
    "material"          int            NOT NULL,
    "quadrature"        decimal(12, 2) NOT NULL,
    "lv_per_quadrature" decimal(12, 2) NOT NULL,
    "total_money"       decimal(12, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS "workers"
(
    "worker_id"          serial PRIMARY KEY,
    "name"               text NOT NULL,
    "salary_type"        int  NOT NULL,
    "salary_coefficient" decimal(12, 2),
    "salary_per_day"     decimal(12, 2)

);

CREATE TABLE IF NOT EXISTS "relation_salary_worker"
(
    "relation_salary_worker_id" serial PRIMARY KEY,
    "worker_id"                 int REFERENCES "workers" (worker_id) ON DELETE RESTRICT,
    "work_days"                 int,
    "brigade_id"                int REFERENCES "brigade" (brigade_id) ON DELETE RESTRICT,
    "advance"                   decimal(12, 2)                 ,
    "salary"                    decimal(12, 2)
);

CREATE TABLE IF NOT EXISTS "cars"
(
    "car_id"                serial            PRIMARY KEY,
    "car_name"              text              NOT NULL,
    "insurance_expires"     timestamptz         ,
    "vignette_expires"      timestamptz         ,
    "year_check_expires"    timestamptz
);

CREATE TABLE IF NOT EXISTS "dictionary"
(
    "dictionary_id"                serial            PRIMARY KEY,
    "content"                      text              NOT NULL
);








