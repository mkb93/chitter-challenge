CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username text,
  full_name text,
  email text,
  password text
  );
CREATE TABLE IF NOT EXISTS peeps (
  id SERIAL PRIMARY KEY,
  time_made timestamp,
  content text,
  user_id int
  );
