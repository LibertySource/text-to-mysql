CREATE TABLE IF NOT EXISTS Student
 (
    studentid INT NOT NULL,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    dob DATETIME,
    PRIMARY KEY (studentid)
 )
engine=innodb;

CREATE TABLE IF NOT EXISTS Address
 (
     studentid INT,
     contactname VARCHAR(255),
     relationshiop VARCHAR(50),
     number VARCHAR(50),
     street VARCHAR(50),
     city VARCHAR(35),
     state VARCHAR(50),
     zip VARCHAR(50),
     liveshere TINYINT(1),
    mailhere TINYINT(1),
     homephoneareacode VARCHAR(50),
     homephone VARCHAR(50),
     email1 VARCHAR(50),
     CONSTRAINT fk_address_student FOREIGN KEY (studentid) REFERENCES Student(studentid)
 )
engine=innodb;

CREATE TABLE IF NOT EXISTS StudentYear
 (
     studentid INT,
     yearid SMALLINT,
     isactive TINYINT(1),
     CONSTRAINT fk_studentyear_student FOREIGN KEY (studentid) REFERENCES Student(studentid)
 )
engine=innodb;

CREATE TABLE IF NOT EXISTS AuditLog (
    id INT PRIMARY KEY AUTO_INCREMENT,
    awsAccessKey VARCHAR(50),
    awsRegion VARCHAR(50),
    flowIdentifier VARCHAR(50),
    flowAliasIdentifier VARCHAR(50),
    question VARCHAR(2000),
    mysql VARCHAR(2000),
    succeeded BOOLEAN,
    execAIStart DATETIME,
    execAIEnd DATETIME,
    execAIElapsed BIGINT
)
engine=innodb;