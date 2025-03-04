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
SELECT 
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
FROM original_table_name;
