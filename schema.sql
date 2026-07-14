-- Schema for CS50 into to database final project.

VACUUM;
-- the main user 
CREATE TABLE IF NOT EXISTS "users"(
    "id" INTEGER PRIMARY KEY,
    "username" TEXT UNIQUE NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "bio" TEXT
);

-- for users connections, followers and following users
CREATE TABLE IF NOT EXISTS "connections"(
    "user1_id" INTEGER,
    "user2_id" INTEGER,
    "following_time" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("user1_id","user2_id"),
    FOREIGN KEY("user1_id") REFERENCES "users"("id") ON DELETE CASCADE,
    FOREIGN KEY("user2_id") REFERENCES "users"("id") ON DELETE CASCADE
);

-- represents the authors of the books, who they are
CREATE TABLE IF NOT EXISTS "authors"(
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "nationality" TEXT,
    "biography" TEXT
);

-- for following the authors you like 
CREATE TABLE IF NOT EXISTS "following_authors"(
    "user_id" INTEGER,
    "author_id" INTEGER,
    "following" INTEGER CHECK("following" = 1 OR "following" = 0) DEFAULT 0,
    "rate" INTEGER CHECK("rate" BETWEEN 0 AND 5),   
    "review" TEXT,
    PRIMARY KEY("user_id","author_id")
    FOREIGN KEY("user_id") REFERENCES "users"("id") ON DELETE CASCADE,
    FOREIGN KEY("author_id") REFERENCES "authors"("id") ON DELETE CASCADE
);

-- represents the books
CREATE TABLE IF NOT EXISTS "books"(
    "id" INTEGER PRIMARY KEY,
    "title" TEXT NOT NULL,
    "publish_year" INTEGER,
    "type" TEXT NOT NULL,
    "overview" TEXT
);

-- there are many books have written by more than writer..
CREATE TABLE IF NOT EXISTS "authored_book"(
    "book_id" INTEGER,
    "author_id" INTEGER,
    PRIMARY KEY("book_id","author_id"),
    FOREIGN KEY("book_id") REFERENCES "books"("id") ON DELETE CASCADE,
    FOREIGN KEY("author_id") REFERENCES "authors"("id") ON DELETE CASCADE
);

-- in my opinion, it's the most important table..
-- it represents the books which user adds to its profile "his shared library"
CREATE TABLE IF NOT EXISTS "chosen_books"(
    "user_id" INTEGER,
    "book_id" INTEGER,
    "book_status" CHECK("book_status" IN ('not_started','in_progress','finished')),
    "rate" INTEGER CHECK("rate" BETWEEN 0 AND 5),
    "review" TEXT,
    "save" INTEGER CHECK("save" = 0 OR "save" = 1) DEFAULT 0,
    PRIMARY KEY("user_id","book_id")
    FOREIGN KEY("user_id") REFERENCES "users"("id") ON DELETE CASCADE,
    FOREIGN KEY("book_id") REFERENCES "books"("id") ON DELETE CASCADE
);

-- Indexing
CREATE INDEX "search_username" ON "users"("username");
CREATE INDEX "search_fullname" ON "users"("first_name","last_name");
CREATE INDEX "search_book_title" ON "books"("title");
CREATE INDEX "search_book_type" ON "books"("type");

-- View

-- for book rates to know which is the most populated to least one
CREATE VIEW "book_rate" AS
SELECT "title","type",ROUND(AVG("rate"),2) AS "average_rate"
FROM "books"
JOIN "chosen_books" ON "chosen_books"."book_id" = "books"."id"
GROUP BY "books"."id"
ORDER BY "average_rate" DESC;

-- top 10 followed authors
CREATE VIEW "top_10_authors" AS
SELECT "id","name","nationality",COUNT("user_id") AS "num_of_followers"
FROM "authors" 
JOIN "following_authors" ON "author_id" = "authors"."id"
GROUP BY "author_id"
ORDER BY "num_of_followers" DESC
LIMIT 10;










