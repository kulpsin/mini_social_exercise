-- Temporarily disable foreign key constraints.
PRAGMA foreign_keys = 0;

-- Create a temporary table to keep current data safe.
CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM posts;

-- Drop the old posts table and recreate it with modifications in place.
DROP TABLE posts;
CREATE TABLE posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  original_post_id INTEGER REFERENCES posts (id) ON DELETE SET NULL DEFAULT NULL
);

-- Copy the data from the temporary table into the new posts table.
INSERT INTO posts (
  id,
  user_id,
  content,
  created_at
)
SELECT id,
       user_id,
       content,
       created_at
FROM sqlitestudio_temp_table;

-- Drop the temporary table.
DROP TABLE sqlitestudio_temp_table;

-- Enable foreign key constraints.
PRAGMA foreign_keys = 1;
