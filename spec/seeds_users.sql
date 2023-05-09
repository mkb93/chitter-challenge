  TRUNCATE TABLE users RESTART IDENTITY;

  INSERT INTO users (username, full_name) VALUES ('user1', 'john smith'),('user2','albert fleming');