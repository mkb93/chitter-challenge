  TRUNCATE TABLE users RESTART IDENTITY CASCADE;

  INSERT INTO users (username, full_name, email) VALUES ('user1', 'john smith', 'john@hotmail.com'),('user2','albert fleming', 'albert@hotmail.com');

  TRUNCATE TABLE peeps RESTART IDENTITY;

  INSERT INTO peeps (time_made, content, user_id ) VALUES (CURRENT_TIMESTAMP, 'I love coding',1),(CURRENT_TIMESTAMP, 'I love coding too',2);