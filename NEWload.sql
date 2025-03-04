INSERT INTO books (
    book_title,
    book_main_author,
    book_publication_country,
    book_original_language,
    book_publication_date,
    book_alternative_titles,
    book_subject,
    book_content_notes,
    book_awards,
    book_author_mention,
    book_other_authors
)
SELECT DISTINCT
    TITLE,
    MAIN_AUTHOR,
    PUB_COUNTRY,
    ORIGINAL_LANGUAGE,
    PUB_DATE,
    ALT_TITLE,
    TOPIC,
    CONTENT_NOTES,
    AWARDS,
    MENTION_AUTHORS,
    OTHER_AUTHORS
FROM fsdb.acervus
WHERE 
    TITLE IS NOT NULL
    AND LENGTH(TITLE) <= 200
    AND MAIN_AUTHOR IS NOT NULL
    AND LENGTH(MAIN_AUTHOR) <= 100
    AND PUB_COUNTRY IS NOT NULL
    AND LENGTH(PUB_COUNTRY) <= 50
    AND ORIGINAL_LANGUAGE IS NOT NULL
    AND LENGTH(ORIGINAL_LANGUAGE) <= 50
    AND PUB_DATE IS NOT NULL
    AND LENGTH(PUB_DATE) <= 12
    AND (ALT_TITLE IS NULL OR LENGTH(ALT_TITLE) <= 200)
    AND TOPIC IS NOT NULL
    AND LENGTH(TOPIC) <= 200
    AND (CONTENT_NOTES IS NULL OR LENGTH(CONTENT_NOTES) <= 2500)
    AND (AWARDS IS NULL OR LENGTH(AWARDS) <= 200)
    AND (MENTION_AUTHORS IS NULL OR LENGTH(MENTION_AUTHORS) <= 200)
    AND (OTHER_AUTHORS IS NULL OR LENGTH(OTHER_AUTHORS) <= 200);

INSERT INTO book_editions (
    edition_national_identifier,
    edition_ISBN,
    edition_main_language,
    edition_other_language,
    edition_number,
    edition_publisher,
    edition_lenght,
    edition_series,
    edition_legal_deposit,
    edition_publication_place,
    edition_dimensions,
    edition_physical_characteristics,
    edition_anciliaryMaterials_notes,
    edition_URL,
    edition_book_title,
    edition_book_main_author
)
SELECT DISTINCT
    NATIONAL_LIB_ID,               
    ISBN,      
    MAIN_LANGUAG
    OTHER_LANGUAG
    EDITION,      
    PUBLISHER,      
    DIMENSIONS,    
    SERIES,           
    COPYRIGHT,       
    PUB_PLACE,         
    DIMENSIONS,         
    PHYSICAL_FEATURES,   
    ATTACHED_MATERIALS,    
    URL,                      
    TITLE,                   
    MAIN_AUTHOR             
FROM original_table_name
WHERE 
    NATIONAL_LIB_ID IS NOT NULL
    AND ISBN IS NOT NULL
    AND MAIN_LANGUAGE IS NOT NULL
    AND EDITION IS NOT NULL
    AND PUBLISHER IS NOT NULL
    AND DIMENSIONS IS NOT NULL
    AND SERIES IS NOT NULL
    AND COPYRIGHT IS NOT NULL
    AND PUB_PLACE IS NOT NULL
    AND URL IS NOT NULL
    AND TITLE IS NOT NULL
    AND MAIN_AUTHOR IS NOT NULL;


INSERT INTO book_entries (
    entry_signature,
    entry_edition,
    entry_condition,
    entry_comments,
    entry_state,
    entry_deregistraton_time
)
SELECT DISTINCT
    SIGNATURE,                 
    NATIONAL_LIB_ID,            
    'new',                       
    NOTES,                        
    'free',                        
    NULL                           
FROM original_table_name
WHERE 
    SIGNATURE IS NOT NULL
    AND NATIONAL_LIB_ID IS NOT NULL;


INSERT INTO users (
    user_id,
    user_name,
    user_surname_1,
    user_surname_2,
    user_birthdate,
    user_municipality,
    user_address,
    user_email,
    user_phone_number,
    user_sanction,
    user_passport
)
SELECT DISTINCT
    USER_ID,                
    NAME,                  
    SURNAME1,             
    SURNAME2,            
    BIRTHDATE,          
    TOWN,              
    ADDRESS,          
    EMAIL,           
    PHONE,          
    NULL,          
    PASSPORT      
FROM fsdb.loans
WHERE 
    USER_ID IS NOT NULL
    AND NAME IS NOT NULL
    AND SURNAME1 IS NOT NULL
    AND SURNAME2 IS NOT NULL
    AND BIRTHDATE IS NOT NULL
    AND TOWN IS NOT NULL
    AND ADDRESS IS NOT NULL
    AND PHONE IS NOT NULL
    AND PASSPORT IS NOT NULL;



INSERT INTO ID_ROUTES (route_id)
SELECT DISTINCT 
        route_id 
FROM fsdb.busstops
WHERE 
    route_id IS NOT NULL;


-- THE LIBRARY INSERT WOULD GO HERE BUT THRE IS 
-- NOT ENOUGH DATA FOR IT. 


INSERT INTO book_loans (
    loan_initial_date,
    loan_entry,
    loan_user,
    loan_library,
    loan_final_date
)
SELECT 
    DATE_TIME,          
    SIGNATURE,           
    USER_ID,              
    NULL,                  
    RETURN                  
FROM fsdb.loans
WHERE 
    DATE_TIME IS NOT NULL
    AND SIGNATURE IS NOT NULL
    AND USER_ID IS NOT NULL;


INSERT INTO book_reservations (
    reservation_date,
    reservation_entry,
    reservation_user,
    reservation_library,
    reservation_route
)
SELECT 
    POST_DATE,          
    SIGNATURE,           
    USER_ID,              
    NULL,                  
    NULL                    
FROM fsdb.loans
WHERE 
    POST_DATE IS NOT NULL
    AND SIGNATURE IS NOT NULL
    AND USER_ID IS NOT NULL;


INSERT INTO user_comments (
    comment_id,
    comment_text,
    comment_user,
    comment_entry,
    comment_date,
    comment_likes,
    comment_dislikes
)
SELECT 
    USER_ID || '_' || SIGNATURE || '_' || POST_DATE, -
    POST,                                           -
    USER_ID,                                   
    SIGNATURE,                                  
    POST_DATE,                                   
    LIKES,                                        
    DISLIKES                                       
FROM fsdb.loans
WHERE 
    POST IS NOT NULL
    AND USER_ID IS NOT NULL
    AND SIGNATURE IS NOT NULL
    AND POST_DATE IS NOT NULL
    AND LIKES IS NOT NULL
    AND DISLIKES IS NOT NULL;


INSERT INTO bibusero (
    bibusero_passport,
    bibusero_fullname,
    bibusero_phone,
    bibusero_birthdate,
    bibusero_email,
    bibusero_contract_start_date,
    bibusero_contract_end_date
)
SELECT DISTINCT
    LIB_PASSPORT,           
    LIB_FULLNAME,          
    LIB_PHONE,            
    LIB_BIRTHDATE,       
    LIB_EMAIL,          
    CONT_START,        
    CONT_END          
FROM fsdb.busstops
WHERE 
    LIB_PASSPORT IS NOT NULL
    AND LIB_FULLNAME IS NOT NULL
    AND LIB_PHONE IS NOT NULL
    AND LIB_BIRTHDATE IS NOT NULL
    AND LIB_EMAIL IS NOT NULL
    AND CONT_START IS NOT NULL;



INSERT INTO routes (
    route_id,
    route_stop_time,
    route_municipality
)
SELECT DISTINCT
    ROUTE_ID,        
    STOPTIME,       
    TOWN           
FROM fsdb.busstops
WHERE 
    ROUTE_ID IS NOT NULL
    AND STOPTIME IS NOT NULL
    AND TOWN IS NOT NULL;


INSERT INTO bibus (
    bibus_plate,
    bibus_last_ITV,
    bibus_next_ITV
)
SELECT DISTINCT
    PLATE,      
    LAST_ITV,    
    NEXT_ITV      
FROM fsdb.busstops
WHERE 
    PLATE IS NOT NULL;


INSERT INTO SRoutes (
    SRoute_date,
    SRoute_route_id,
    SRoute_route_stop_time,
    SRoute_bibus,
    SRoute_bibusero
)
SELECT DISTINCT
    STOPDATE,               
    ROUTE_ID,
    STOPTIME, 
    PLATE,     
    LIB_PASSPORT            
FROM fsdb.busstops
WHERE 
    STOPDATE IS NOT NULL
    AND ROUTE_ID IS NOT NULL
    AND STOPTIME IS NOT NULL
    AND PLATE IS NOT NULL
    AND LIB_PASSPORT IS NOT NULL;


INSERT INTO bibus_state (
    bibus_plate,
    state_date,
    state,
    assigned_route_id
)
SELECT DISTINCT
    PLATE,                  
    STOPDATE,              
    'assigned',           
    ROUTE_ID             
FROM fsdb.busstops
WHERE 
    PLATE IS NOT NULL
    AND STOPDATE IS NOT NULL
    AND ROUTE_ID IS NOT NULL;


INSERT INTO bibusero_state (
    bibusero_passport,
    state_date,
    state,
    assigned_route_id
)
SELECT DISTINCT
    LIB_PASSPORT,           
    STOPDATE,              
    'assigned',           
    ROUTE_ID             
FROM fsdb.busstops
WHERE 
    LIB_PASSPORT IS NOT NULL
    AND STOPDATE IS NOT NULL
    AND ROUTE_ID IS NOT NULL;
