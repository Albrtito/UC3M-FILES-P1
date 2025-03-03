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
    edition_ISBN CHAR(20) NOT NULL,
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
    CONSTRAINT FK_REFERENCEBOOK FOREIGN KEY(edition_book_title, edition_book_main_author) REFERENCES BOOKS(book_title,book_main_author)
);


drop table book_entries cascade constraints;
CREATE TABLE book_entries(
    entry_signature CHAR(20) NOT NULL,
    entry_edition CHAR(20) NOT NULL,
    -- Could have a default value = "new"
    entry_condition CHAR(30) NOT NULL,
    entry_comments CHAR(500),
    -- Could have a default value = "free"
    entry_state CHAR(30) NOT NULL,
    entry_deregistraton_time CHAR(10),
    CONSTRAINT PK_BOOK_ENTRIES PRIMARY KEY(entry_signature),
    CONSTRAINT FK_REFERENCEEDITION FOREIGN KEY(entry_edition) REFERENCES BOOK_EDITIONS(edition_national_identifier),
    CONSTRAINT C_CONDITION CHECK(entry_condition IN ('new','good','worn','very-used','deteriorated')),
    CONSTRAINT C_STATE CHECK(entry_state IN ('loaned','free','deregistered'))
);

drop table municipality cascade constraints;
CREATE TABLE municipality(
    municipality_name CHAR(50) NOT NULL,
    municipality_popuation CHAR(8) NOT NULL,
    municipality_has_library CHAR(1) NOT NULL,
    municipality_address CHAR(100) NOT NULL,
    municipality_province CHAR(22) NOT NULL,
    CONSTRAINT PK_MUNICIPALITY PRIMARY KEY(municipality_name)
);
    

        
drop table users cascade constraints;
CREATE TABLE users(
    user_id CHAR(10) NOT NULL,
    user_name CHAR(80) NOT NULL,
    user_surname_1 CHAR (80) NOT NULL,
    user_surname_2 CHAR (80) NOT NULL,
    user_birthdate CHAR(10) NOT NULL,
    user_municipality CHAR(50) NOT NULL,
    user_address CHAR(150) NOT NULL,
    user_email CHAR(100),
    user_phone_number CHAR(9) NOT NULL,
    user_sanction CHAR(20),
    user_passport CHAR(20) NOT NULL,
    CONSTRAINT PK_USER PRIMARY KEY(user_id),
    CONSTRAINT FK_REFERENCE_USERS_MUNICIPALITY FOREIGN KEY(user_municipality) REFERENCES MUNICIPALITY(municipality_name)
);


drop table book_loans cascade constraints;
CREATE TABLE book_loans(
    loan_initial_date CHAR(22) NOT NULL,
    loan_entry CHAR(20) NOT NULL,
    loan_user CHAR(10) NOT NULL,
    loan_final_date CHAR(22),
    CONSTRAINT PK_BOOK_LOANS PRIMARY KEY(loan_initial_date,loan_entry,loan_user),
    CONSTRAINT FK_REFERENCE_ENTRY FOREIGN KEY(loan_entry) REFERENCES BOOK_ENTRIES(entry_signature),
    CONSTRAINT FK_REFERENCE_USER FOREIGN KEY(loan_user) REFERENCES USERS(user_id)
);


drop  table m_library cascade constraints;
CREATE TABLE m_library(
    library_CIF CHAR(20) NOT NULL,
    library_name CHAR(20) NOT NULL,
    library_foundation_date CHAR(20) NOT NULL,
    library_municipality CHAR(50) NOT NULL,
    library_address CHAR(100) NOT NULL,
    library_email CHAR(20) NOT NULL,
    library_telephone CHAR(9) NOT NULL,
    CONSTRAINT PK_M_LIBRARY PRIMARY KEY(library_CIF),
    CONSTRAINT FK_REFERENCE_LIBRARY_MUNICIPALITY FOREIGN KEY(library_municipality) REFERENCES MUNICIPALITY(municipality_name)
);

drop table user_comments cascade constraints;
CREATE TABLE user_comments(
    comment_id CHAR(20) NOT NULL,
    comment_text CHAR(2000) NOT NULL,
    comment_user CHAR(10) NOT NULL,
    comment_entry CHAR(20) NOT NULL,
    comment_date CHAR(22) NOT NULL,
    comment_likes CHAR(7) NOT NULL,
    comment_dislikes CHAR(7) NOT NULL,
    CONSTRAINT PK_USER_COMMENTS PRIMARY KEY(comment_id),
    CONSTRAINT FK_REFRENCE_COMMENT_USER FOREIGN KEY(comment_user) REFERENCES USERS(user_id)
    --CONSTRAINT FK_REFERENCE_COMMENT_ENTRY KEY(comment_entry) REFERENCES BOOK_ENTRIES(entry_signature)
);
