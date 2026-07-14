# Design Document

By: Sondos Mohamed Ali

Video overview: https://youtu.be/Zopq5DeF23c

## Scope

 A personal electronic library which is called "Maktabty" which means "my own library", such as a blog, where one can view the private library of others, evaluate books and authors, and record the process of reading, Which includes entities:
* Users, including identifies of them.
* Connections, to represents followings and followers  of users.
* Authors, including basic knowledge about them.
* Following Authors, to represent following, rates and reviews for a specific author.
* Books, Basic knowledge about the book.
* Authored Book, for all books which have single or many writer collaborated in writing and many books for the same writer.
* Chosen Books, for the books to rate, save in your blog.
Out of this scope: Donations, Blocked users.

## Functional Requirements

This database supports:
- CRUD for users, books and authors.
- Tracking the book and author statistics.
- Linking the relationships between written books and authors, and adding multiple authors to the same book if applicable (e.g., book called "**Good Omens**" has written by two authors).

## Representation

In this field, it represents entities and relationships in detail.

### Entities

This database includes:

#### Users

The `users` table includes:

- `id`, which represents a `UNIQUE` ID for the user as an `INTEGER`, and so that it's the `PRIMARY KEY`.
- `username`, each user has to create a specific `UNIQUE` readable identifier so that you can never find two users have the same `username`, and it can't be `NULL` so that it's used for most conditions to search, delete or update.
- `first_name`, which represents the user's first name as a `TEXT`, and can't be `NULL`.
- `last_name`, which represents the user's last name as a `TEXT`, and can't be `NULL`.
- `email`, which represents the user's email,and can't be `NULL`.
- `bio`, which represents the user's biography as a `TEXT` and it's optional to be added or not.

#### Connections

The `connections` table includes:

- `user_id1`, which represents the id of the first user as an integer as a `FOREIGN KEY` references to the `id` of the table of `users`.
- `user_id2`, which represents the id of the second user which is following the user who's ID is `user_id1` as an integer as a `FOREIGN KEY` references to the `id` of the table of `users`.
The `PRIMARY KEY` constrain is the combination of `user_id1` and `user_id2` (composite key) and this table tells you that a user can be followed and not following or vice versa or for sure be both "followed and following".

#### Authors

The `authors` table includes:

- `id`, which represents the ID of the author as `INTEGER` and and each author has a specific ID so that it has a `PRIMARY KEY` constrain.
- `name`, which represents the authors real name or nickname as a `TEXT` and for sure it can't be `NULL`.
- `nationality`, which represents the nationality of the author and it's optional.
- `biography`, which represents the biography of the author such as its life, achievements or overview about who is he/she.

#### Following Authors

The `following_authors` table includes:

- `user_id`, which represents the user who is going to interact with the table of author, it's represented as  an `INTEGER` and the `FOREIGN KEY` references to the `id` of the user in the table of `users`.
- `author_id`, which represents the author who is followed or been interacted with from the user, it's represented as `INTEGER` and the `FOREIGN KEY` references to the `id` of the author in the table of `authors`.
- `following`, which represents the condition (the author is followed or not) as an `INTEGER` and using the `CHECK` constrain to check: if it's followed 1 else 0 and the default "by `DEFAULT` constrain " is 0.
- `rate`, which represents the rate of author which the user rates as `INTEGER` from range between 0 to 5.
- `review`, which represents the review the user makes about an author, as a `TEXT`.
The `PRIMARY KEY` constrain is the combination of `user_id` and `author_id` (composite key).

#### Books

The `books` table includes:

- `id`, each book has an `INTEGER` ID which is represented as `PRIMARY KEY`.
- `title`, which represents the title of the book as a `TEXT`, and it can't be `NULL`.
- `publish_year`, which represents the publish year of the book as `INTEGER`.
- `type`, which represents the type of the book (e.g., Romance,Autobiography) which can't be `NULL`.
- `overview`, which represents a short brief on the book as a `TEXT`.

#### Authored Book

The `authored_book` table includes:

- `book_id`,which represents the book ID it's represented as  an `INTEGER` and the `FOREIGN KEY` references to the `id` of the book in the table of `books`.
- `author_id`,which represents the author ID it's represented as  an `INTEGER` and the `FOREIGN KEY` references to the `id` of the author in the table of `authors`.
The `PRIMARY KEY` constrain is the combination of `user_id` and `author_id` (composite key).

#### Chosen Books

The `chosen_books` table includes:

- `user_id`,which represents the user ID  who has chosen the book into its library (blog) and it's represented as  an `INTEGER` and the `FOREIGN KEY` references to the `id` of the book in the table of `books`.
- `book_id`,which represents the book ID chosen one, it's represented as  an `INTEGER` and the `FOREIGN KEY` references to the `id` of the book in the table of `books`.
- `book_status`, which represents the status of the book not started, in progress or finished, it marks the book optionally.
- `rate`, which represents the rate of the book which the user rates as `INTEGER` from range between 0 to 5.
-  `review`, which represents the review the user makes about a book, as a `TEXT`.
- `save`,  which represents the condition (the saved or not) as an `INTEGER` and using the `CHECK` constrain to check: if it's followed 1 else 0 and the default "by `DEFAULT` constrain " is 0.
The `PRIMARY KEY` constrain is the combination of `user_id` and `book_id` (composite key).

### Relationships 

The below entity relationship diagram describes the relationships among the entities in the database.

![Entity Relational Diagram](EDR.png)

#### Description

- One user can has no connection or multi, in some ER it uses an itself relationship which represented as a circular from entity user to itself.
- One user can add no or more than chosen book to its blog, and it can be no or more than one book has been chosen.
- One user can follow/ rate none or many authors. 
- Each book must have at least one author in  and each author must has at least one book in authored book entity.

## Optimization

- In many cases searching, deleting and updating are done by unique and easy to know column, such as `username` in `users`, so that we add indexing called `search_username`.
- To find friends in the blog, in most cases by its full name so we add indexing in `users` table for `first_name`,`last_name` called `search_fullname`.
- and for searching books by common things, (e.g., title, type) We add two indexing `search_book_title` and `search_book_type`.
- As a user, you what to know the most rated books and its average rate, so that we created a view table called `book_rate`
- And to know from time to another the top 10 authors which are followed we created a view called `top_10_authors`.

## Limitations

- This schema assumes it's a public blog and sharing info about readings and everything, being a private account for only followers will require extra check table for  sending request and being an accepted followers  (e.g., Instagram application)
- Not setting specific types of books from the first as "Enums" Could lead to many of the same type written in different forms.
