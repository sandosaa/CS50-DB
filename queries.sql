-- Inserting

-- Insert authors
INSERT INTO "authors"("id","name","nationality","biography")
VALUES
(1,'Taha Hussein','Egyptian','Dean of Arabic Literature and a famous Egyptian writer.'),
(2,'George Orwell','British','An English novelist, poet, essayist, journalist, and critic who wrote under the pen name of George Orwell');

-- Insert boooks
INSERT INTO "books"("id","title","publish_year","type")
VALUES
(1,'Al-Ayyam',1929,'autobiography'),
(2,'The animal farm',1945,'allegorical political satire');

-- Link between authors and books
INSERT INTO "authored_book"
VALUES
(1,1),
(2,2);

-- Insert Users
INSERT INTO "users"
VALUES
(1,'sandosaa','Sondos','Mohamed','sondos_ali_2006@hotmail.com','A passionate reader!'),
(2,'hagoora','Hager','Mahmoud','example@email.com','Cup of coffee is all I need..'),
(3,'emoo','Eman','Abdelrahman','emi@email.com','Busy doing stuff');

-- Insert to your profile books
INSERT INTO "chosen_books"
VALUES (1,2,'in_progress',4,'It is a great book!',1);

-- Follow an author
INSERT INTO "following_authors"("user_id","author_id","following")
VALUES (2,1,1);

-- Updating
UPDATE "users" SET "email" = 'update_example@email.com'
WHERE "username" = 'hagoora';

-- Deleting
DELETE FROM "users"
WHERE "username" = 'emoo';

-- Reading

--Order books by it's title
SELECT * FROM "books" 
ORDER BY "title" ASC;

--the followers of specific user
SELECT "username","first_name","last_name" 
FROM "users" 
WHERE "id" IN (
    SELECT "user2_id" FROM "connections"
    WHERE "user1_id" = (
        SELECT "id" FROM "users"
        WHERE "username" = 'sandosaa'
    )
);












