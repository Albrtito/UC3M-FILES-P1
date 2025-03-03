DROP TABLE course;
CREATE TABLE Course (
subject VARCHAR2(100),
degree VARCHAR2(50),
credits NUMBER(2) NOT NULL,
lecturer VARCHAR2(50),
CONSTRAINT pk_course PRIMARY KEY(subject, degree),CONSTRAINT valid_ttl CHECK (credits>0),
CONSTRAINT fk_course_degree FOREIGN KEY(degree)REFERENCES TO degree(name)
);
