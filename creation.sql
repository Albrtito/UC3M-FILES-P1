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
    CONSTRAINT FK_REFRENCE_COMMENT_USER FOREIGN KEY(comment_user) REFERENCES USERS(user_id),
    CONSTRAINT FK_REFERENCE_COMMENT_ENTRY FOREIGN KEY(comment_entry) REFERENCES BOOK_ENTRIES(entry_signature)
);

drop table bibusero cascade constraints;
CREATE TABLE bibusero(
    bibusero_passport CHAR(20) NOT NULL,
    bibusero_fullname CHAR(80) NOT NULL,
    bibusero_phone CHAR(9) NOT NULL,
    bibusero_birthdate CHAR(10) NOT NULL,
    bibusero_email CHAR(100) NOT NULL,
    bibusero_contract_start_date CHAR(10) NOT NULL,
    bibusero_contract_end_date CHAR(10),
    CONSTRAINT PK_BIBUSERO PRIMARY KEY(bibusero_passport)
);

drop table ID_ROUTES cascade constraints;
CREATE TABLE ID_ROUTES(
    route_id CHAR(5) NOT NULL,
    CONSTRAINT PK_ID_ROUTES PRIMARY KEY(route_id)
);

drop table routes cascade constraints;
CREATE TABLE routes(
    route_id CHAR (5) NOT NULL,
    route_stop_time CHAR(10) NOT NULL,
    route_municipality CHAR(50) NOT NULL,
    CONSTRAINT PK_ROUTES PRIMARY KEY(route_id,route_stop_time),
    CONSTRAINT FK_REFERENCES_ROUTES_ROUTE_ID FOREIGN KEY(route_id) REFERENCES ID_ROUTES(route_id),
    CONSTRAINT FK_REFERENCES_ROUTES_MUNICIPALITY FOREIGN KEY(route_municipality) REFERENCES MUNICIPALITY(municipality_name)
);

drop table bibus cascade constraints;
CREATE TABLE bibus(
    bibus_plate CHAR(8) NOT NULL,
    bibus_last_ITV CHAR(22), 
    bibus_next_ITV CHAR(22),
    CONSTRAINT PK_BIBUS PRIMARY KEY(bibus_plate)
);

-- SCHEDULED ROUTES -> SROUTES
drop table SRoutes cascade constraints;
CREATE TABLE SRoutes(
    SRoute_date CHAR(22) NOT NULL,
    SRoute_route_id CHAR(5) NOT NULL,
    SRoute_route_stop_time CHAR(10) NOT NULL,
    SRoute_bibus CHAR(8) NOT NULL,
    SRoute_bibusero CHAr(20) NOT NULL,
    CONSTRAINT PK_SROUTES PRIMARY KEY(SRoute_date,SRoute_route_id, SRoute_route_stop_time, SRoute_bibus, SRoute_bibusero),
    CONSTRAINT FK_REFERENCES_SROUTES_ROUTE FOREIGN KEY(SRoute_route_id, SRoute_route_stop_time) REFERENCES ROUTES(route_id, route_stop_time),
    CONSTRAINT FK_REFERENCES_SROUTES_BIBUS FOREIGN KEY(SRoute_bibus) REFERENCES BIBUS(bibus_plate),
    CONSTRAINT FK_REFERNCES_SROUTS_BIBUSERO FOREIGN KEY(SRoute_bibusero) REFERENCES BIBUSERO(bibusero_passport)
);

drop table bibus_state cascade constraints;
CREATE TABLE bibus_state(
    bibus_plate CHAR(8) NOT NULL,
    state_date CHAR(22) NOT NULL,
    state CHAR(20) NOT NULL DEFAULT('aviable'),
    assigned_route_id CHAR(5) NOT NULL,
    CONSTRAINT PK_BIBUS_STATE PRIMARY KEY(bibus_plate, state_date),
    CONSTRAINT FK_REFERENCES_STATE_BIBUS FOREIGN KEY(bibus_plate) REFERENCES BIBUS(bibus_plate),
    CONSTRAINT C_BIBUS_STATE CHECK(state IN ('assigned','inspection','aviable'))
);

drop table bibusero_state cascade constraints;
CREATE TABLE bibusero_state(
    bibusero_passport CHAR(20) NOT NULL,
    state_date CHAR(22) NOT NULL,
    state CHAR(20) DEFAULT('aviable'),
    assigned_route_id CHAR(5) NOT NULL,
    CONSTRAINT PK_BIBUSERO_STATE PRIMARY KEY(bibusero_passport, state_date),
    CONSTRAINT FK_REFERENCES_STATE_BIBUSERO FOREIGN KEY(bibusero_passport) REFERENCES BIBUSERO(bibusero_passport),
    CONSTRAINT FK_REFERENCES_BIBUSERO_STATE_ROUTE FOREIGN KEY(assigned_route_id) REFERENCES ID_ROUTES(route_id),
    CONSTRAINT C_BIBUSERO_STATE CHECK(state IN ('assigned','aviable'))
);
    

