drop table books cascade constraints;


CREATE TABLE books(
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
    CONSTRAINT PK_BOOKS PRIMARY KEY (book_title,book_main_author)
);


drop table book_editions cascade constraints;

CREATE TABLE book_editions(
    edition_national_identifier CHAR(20) NOT NULL,
    editoon_ISBN CHAR(20) NOT NULL,
    edition_main_language CHAR(50) NOT NULL,
    edition_other_language CHAR(50),
    edition_number CHAR(50) NOT NULL,
    edition_publisher CHAR(100) NOT NULL,
    edition_lenght CHAR(50) NOT NULL,
    edition_series CHAR(50) NOT NULL,
    edition_legal_deposit CHAR(20) NOT NULL,
    edition_publication_place CHAR(50) NOT NULL,
    edition_dimensions CHAR(50) NOT NULL,
    edition_physical_characteristics CHAR(200),
    edition_anciliaryMaterials_notes CHAR(200),
    edition_URL CHAR(200) NOT NULL,
    edition_book_title CHAR(200) NOT NULL,
    edition_book_main_author CHAR(100) NOT NULL,
    CONSTRAINT PK_BOOK_EDITIONS PRIMARY KEY (edition_national_identifier),
    CONSTRAINT FK_REFERENCEBOOK FOREIGN KEY(edition_book_title, editoin_book_main_author) REFERENCES BOOKS(book_title,book_main_author)
);

