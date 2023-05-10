  TRUNCATE TABLE users RESTART IDENTITY CASCADE;

  INSERT INTO users (username, full_name) VALUES ('user1', 'john smith'),('user2','albert fleming');

  TRUNCATE TABLE peeps RESTART IDENTITY;

  INSERT INTO peeps (time_made, content, user_id ) VALUES (CURRENT_TIMESTAMP, 'I love coding',1),(CURRENT_TIMESTAMP, 'I love coding too',2);