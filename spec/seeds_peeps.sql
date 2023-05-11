  TRUNCATE TABLE users RESTART IDENTITY CASCADE;

  INSERT INTO users (username, full_name, email, password) VALUES ('user1', 'john smith', 'john@hotmail.com', '$2a$12$zEfXB2B06AB5Y0ZFpFqjweFqqsGwvL0X8iYmXIPP7rNj5CQp5nJcm'),('user2','albert fleming', 'albert@hotmail.com', '$2a$12$YSZe3wzKUhHk4FFECui5lutFcB4A3dN6xs8HURpi7n1ilWvutA.wS');

  TRUNCATE TABLE peeps RESTART IDENTITY;

  INSERT INTO peeps (time_made, content, user_id ) VALUES (CURRENT_TIMESTAMP, 'I love coding',1),(CURRENT_TIMESTAMP, 'I love coding too',2);