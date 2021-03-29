-- +micrate Up
CREATE TABLE characters (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  name_japanese VARCHAR,
  birthday VARCHAR,
  bounty BIGINT,
  nickname VARCHAR,
  description VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS characters;
