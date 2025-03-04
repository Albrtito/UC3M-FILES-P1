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
