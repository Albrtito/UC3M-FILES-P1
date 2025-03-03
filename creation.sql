DROP TABLE itinerary_borrower CASCADE CONSTRAINTS;
DROP TABLE itinerary_stops CASCADE CONSTRAINTS;
DROP TABLE schedule CASCADE CONSTRAINTS;
DROP TABLE routes CASCADE CONSTRAINTS;
DROP TABLE stops CASCADE CONSTRAINTS;
DROP TABLE days CASCADE CONSTRAINTS;
DROP TABLE book_reservations CASCADE CONSTRAINTS;
DROP TABLE book_items CASCADE CONSTRAINTS;
DROP TABLE library_ID CASCADE CONSTRAINTS;
DROP TABLE comment_all CASCADE CONSTRAINTS;
DROP TABLE entry_details CASCADE CONSTRAINTS;
DROP TABLE edition_general CASCADE CONSTRAINTS;
DROP TABLE user_id CASCADE CONSTRAINTS;
DROP TABLE books CASCADE CONSTRAINTS;
DROP TABLE municipality CASCADE CONSTRAINTS;

CREATE TABLE books (
    book_title CHAR(200) NOT NULL,
    book_main_author CHAR(100) NOT NULL,
    book_publication_country CHAR(50) NOT NULL,
    book_original_language CHAR(50) NOT NULL,
    book_publication_date CHAR(12) NOT NULL, 
    book_alternative_titles CHAR(200),
    book_subject CHAR(200) NOT NULL,
    book_content_notes VARCHAR2(2500),
    book_awards CHAR(200),
    book_author_mention CHAR(200),
    book_other_authors CHAR(200),

);
