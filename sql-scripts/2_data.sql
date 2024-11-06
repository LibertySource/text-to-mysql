INSERT INTO Student (studentID, firstname, lastname, dob)
SELECT * FROM (
    SELECT 1 as studentID, 'Mickey' as firstname, 'Mouse' as lastname, '1928-11-18' as dob UNION ALL
    SELECT 2, 'Minnie', 'Mouse', '1928-11-18' UNION ALL
    SELECT 3, 'Donald', 'Duck', '1934-06-09' UNION ALL
    SELECT 4, 'Daisy', 'Duck', '1940-01-09' UNION ALL
    SELECT 5, 'Goofy', 'Goof', '1932-05-25' UNION ALL
    SELECT 6, 'Pluto', NULL, '1930-09-05' UNION ALL
    SELECT 7, 'Mickey', 'Mouse', '1928-11-18' UNION ALL
    SELECT 8, 'Bugs', 'Bunny', '1940-07-27' UNION ALL
    SELECT 9, 'Porky', 'Pig', '1935-03-02' UNION ALL
    SELECT 10, 'Daffy', 'Duck', '1937-04-17' UNION ALL
    SELECT 11, 'Scooby', 'Doo', '1969-09-13' UNION ALL
    SELECT 12, 'Shaggy', 'Rogers', '1969-09-13' UNION ALL
    SELECT 13, 'Fred', 'Flintstone', '1960-09-30' UNION ALL
    SELECT 14, 'Wilma', 'Flintstone', '1960-09-30' UNION ALL
    SELECT 15, 'Barney', 'Rubble', '1960-09-30' UNION ALL
    SELECT 16, 'Betty', 'Rubble', '1960-09-30' UNION ALL
    SELECT 17, 'George', 'Jetson', '1962-09-23' UNION ALL
    SELECT 18, 'Jane', 'Jetson', '1962-09-23' UNION ALL
    SELECT 19, 'Elroy', 'Jetson', '1962-09-23' UNION ALL
    SELECT 20, 'Judy', 'Jetson', '1962-09-23' UNION ALL
    SELECT 21, 'Popeye', NULL, '1929-01-17' UNION ALL
    SELECT 22, 'Olive', 'Oyl', '1919-12-19' UNION ALL
    SELECT 23, 'Bluto', NULL, NULL UNION ALL
    SELECT 24, 'SpongeBob', 'SquarePants', '1999-05-01' UNION ALL
    SELECT 25, 'Patrick', 'Star', '1999-05-01' UNION ALL
    SELECT 26, 'Squidward', 'Tentacles', '1999-05-01' UNION ALL
    SELECT 27, 'Sandy', 'Cheeks', '1999-05-01' UNION ALL
    SELECT 28, 'Tom', 'Cat', NULL UNION ALL
    SELECT 29, 'Jerry', 'Mouse', NULL UNION ALL
    SELECT 30, 'Bart', 'Simpson', '1987-04-19' UNION ALL
    SELECT 31, 'Homer', 'Simpson', '1987-04-19' UNION ALL
    SELECT 32, 'Marge', 'Simpson', '1987-04-19' UNION ALL
    SELECT 33, 'Lisa', 'Simpson', '1987-04-19' UNION ALL
    SELECT 34, 'Maggie', 'Simpson', '1987-04-19' UNION ALL
    SELECT 35, 'Peter', 'Griffin', '1999-01-31' UNION ALL
    SELECT 36, 'Lois', 'Griffin', '1999-01-31' UNION ALL
    SELECT 37, 'Meg', 'Griffin', '1999-01-31' UNION ALL
    SELECT 38, 'Chris', 'Griffin', '1999-01-31' UNION ALL
    SELECT 39, 'Stewie', 'Griffin', '1999-01-31' UNION ALL
    SELECT 40, 'Brian', 'Griffin', '1999-01-31' UNION ALL
    SELECT 41, 'Eric', 'Cartman', NULL UNION ALL
    SELECT 42, 'Stan', 'Marsh', NULL UNION ALL
    SELECT 43, 'Kyle', 'Broflovski', NULL UNION ALL
    SELECT 44, 'Kenny', 'McCormick', NULL UNION ALL
    SELECT 45, 'Randy', 'Marsh', NULL UNION ALL
    SELECT 46, 'Shrek', NULL, '2001-05-22' UNION ALL
    SELECT 47, 'Fiona', 'Shrek', '2001-05-22' UNION ALL
    SELECT 48, 'Donkey', NULL, '2001-05-22' UNION ALL
    SELECT 49, 'Puss', 'Boots', '2004-11-05' UNION ALL
    SELECT 50, 'Felix', 'the Cat', '1919-11-09'
) AS temp_table
WHERE NOT EXISTS (SELECT 1 FROM Student);

INSERT INTO Address (studentID, contactname, relationshiop, number, street, city, state, zip, liveshere, mailhere, homephoneareacode, homephone, email1)
SELECT * FROM (
    SELECT 1 as studentID, 'Walt Disney Studios' as contactname, 'Parent' as relationshiop, '500' as number, 'Burbank Blvd' as street, 'Burbank' as city, 'CA' as state, '91521' as zip, 1 as liveshere, 1 as mailhere, '818' as homephoneareacode, '555-1234' as homephone, 'mickey@disney.com' as email1 UNION ALL
    SELECT 2, 'Walt Disney Studios', 'Parent', '500', 'Burbank Blvd', 'Burbank', 'CA', '91521', 1, 1, '818', '555-1234', 'minnie@disney.com' UNION ALL
    SELECT 3, 'Daisy Duck', 'Parent', '321', 'Duck Pond Ln', 'Duckburg', 'AZ', '54321', 1, 1, '555', '123-4567', 'donald@ducks.com' UNION ALL
    SELECT 4, 'Donald Duck', 'Parent', '321', 'Duck Pond Ln', 'Duckburg', 'AZ', '54321', 1, 1, '555', '123-4567', 'daisy@ducks.com' UNION ALL
    SELECT 5, 'Goofy Goof', 'Friend', '742', 'Silly St', 'Toontown', 'CA', '98765', 1, 0, '909', '987-6543', 'goofy@toons.com' UNION ALL
    SELECT 6, 'Pluto Dog', 'Pet', NULL, 'Kennel Rd', 'Dogtown', 'CA', '87654', 1, 0, '909', '234-5678', 'pluto@dogs.com' UNION ALL
    SELECT 7, 'Walt Disney Studios', 'Parent', '500', 'Burbank Blvd', 'Burbank', 'CA', '91521', 1, 1, '818', '555-1234', 'mickey@disney.com' UNION ALL
    SELECT 8, 'Warner Bros Studios', 'Parent', '4000', 'Warner Blvd', 'Los Angeles', 'CA', '90068', 1, 1, '310', '555-5678', 'bugs@warnerbros.com' UNION ALL
    SELECT 9, 'Warner Bros Studios', 'Parent', '4000', 'Warner Blvd', 'Los Angeles', 'CA', '90068', 1, 1, '310', '555-5678', 'porky@warnerbros.com' UNION ALL
    SELECT 10, 'Warner Bros Studios', 'Parent', '4000', 'Warner Blvd', 'Los Angeles', 'CA', '90068', 1, 1, '310', '555-5678', 'daffy@warnerbros.com' UNION ALL
    SELECT 11, 'Mystery Inc', 'Friend', '222', 'Haunted House Ln', 'Coolsville', 'OH', '54321', 1, 0, '555', '987-6543', 'scooby@mysteryinc.com' UNION ALL
    SELECT 12, 'Mystery Inc', 'Friend', '222', 'Haunted House Ln', 'Coolsville', 'OH', '54321', 1, 0, '555', '987-6543', 'shaggy@mysteryinc.com' UNION ALL
    SELECT 13, 'Bedrock City Hall', 'Parent', '301', 'Granite St', 'Bedrock', 'AZ', '65432', 1, 1, '555', '321-7654', 'fred@bedrock.com' UNION ALL
    SELECT 14, 'Bedrock City Hall', 'Parent', '301', 'Granite St', 'Bedrock', 'AZ', '65432', 1, 1, '555', '321-7654', 'wilma@bedrock.com' UNION ALL
    SELECT 15, 'Bedrock City Hall', 'Friend', '301', 'Granite St', 'Bedrock', 'AZ', '65432', 1, 0, '555', '321-7654', 'barney@bedrock.com' UNION ALL
    SELECT 16, 'Bedrock City Hall', 'Friend', '301', 'Granite St', 'Bedrock', 'AZ', '65432', 1, 0, '555', '321-7654', 'betty@bedrock.com' UNION ALL
    SELECT 17, 'Spacely Sprockets', 'Parent', '100', 'Skypad Apartments', 'Orbit City', 'FL', '32100', 1, 1, '555', '456-7890', 'george@orbitcity.com' UNION ALL
    SELECT 18, 'Spacely Sprockets', 'Parent', '100', 'Skypad Apartments', 'Orbit City', 'FL', '32100', 1, 1, '555', '456-7890', 'jane@orbitcity.com' UNION ALL
    SELECT 19, 'Spacely Sprockets', 'Parent', '100', 'Skypad Apartments', 'Orbit City', 'FL', '32100', 1, 1, '555', '456-7890', 'elroy@orbitcity.com' UNION ALL
    SELECT 20, 'Spacely Sprockets', 'Parent', '100', 'Skypad Apartments', 'Orbit City', 'FL', '32100', 1, 1, '555', '456-7890', 'judy@orbitcity.com' UNION ALL
    SELECT 21, 'Popeye Village', 'Parent', '123', 'Spinach Ave', 'Sweethaven', 'CA', '54321', 1, 1, '555', '987-6543', 'popeye@spinach.com' UNION ALL
    SELECT 22, 'Olive Oyl', 'Friend', '456', 'Olive St', 'Sweethaven', 'CA', '54321', 1, 0, '555', '567-8901', 'olive@spinach.com' UNION ALL
    SELECT 23, 'Salty Sailor Pub', 'Friend', '789', 'Main St', 'Sweethaven', 'CA', '54321', 1, 0, '555', '234-5678', 'bluto@spinach.com' UNION ALL
    SELECT 24, 'Pineapple Under the Sea', 'Parent', '124', 'Bikini Bottom', 'Pacific Ocean', 'NA', '12345', 1, 1, '555', '555-1234', 'spongebob@sea.com' UNION ALL
    SELECT 25, 'Pineapple Under the Sea', 'Parent', '124', 'Bikini Bottom', 'Pacific Ocean', 'NA', '12345', 1, 1, '555', '555-1234', 'patrick@sea.com' UNION ALL
    SELECT 26, 'Squidward''s Tiki Hut', 'Friend', '126', 'Annoyance Ln', 'Bikini Bottom', 'Pacific Ocean', 'NA', 1, 0, '555', '555-5678', 'squidward@sea.com' UNION ALL
    SELECT 27, 'Treasure Island', 'Parent', '456', 'Sandy Way', 'Bikini Bottom', 'Pacific Ocean', 'NA', 1, 1, '555', '987-6543', 'sandy@sea.com' UNION ALL
    SELECT 28, 'Mouse Hole', 'Friend', '321', 'Cheese St', 'Mouseville', 'NA', '98765', 1, 0, '555', '876-5432', 'tom@mouse.com' UNION ALL
    SELECT 29, 'Mouse Hole', 'Friend', '321', 'Cheese St', 'Mouseville', 'NA', '98765', 1, 0, '555', '876-5432', 'jerry@mouse.com' UNION ALL
    SELECT 30, '742 Evergreen Terrace', 'Parent', '1', 'Main St', 'Springfield', 'NA', '98765', 1, 1, '555', '123-4567', 'bart@springfield.com' UNION ALL
    SELECT 31, '742 Evergreen Terrace', 'Parent', '1', 'Main St', 'Springfield', 'NA', '98765', 1, 1, '555', '123-4567', 'homer@springfield.com' UNION ALL
    SELECT 32, '742 Evergreen Terrace', 'Parent', '1', 'Main St', 'Springfield', 'NA', '98765', 1, 1, '555', '123-4567', 'marge@springfield.com' UNION ALL
    SELECT 33, '742 Evergreen Terrace', 'Parent', '1', 'Main St', 'Springfield', 'NA', '98765', 1, 1, '555', '123-4567', 'lisa@springfield.com' UNION ALL
    SELECT 34, '742 Evergreen Terrace', 'Parent', '1', 'Main St', 'Springfield', 'NA', '98765', 1, 1, '555', '123-4567', 'maggie@springfield.com' UNION ALL
    SELECT 35, '31 Spooner St', 'Friend', '2', 'Main St', 'Quahog', 'RI', '02910', 1, 0, '401', '555-7890', 'peter@quahog.com' UNION ALL
    SELECT 36, '31 Spooner St', 'Friend', '2', 'Main St', 'Quahog', 'RI', '02910', 1, 0, '401', '555-7890', 'lois@quahog.com' UNION ALL
    SELECT 37, '31 Spooner St', 'Friend', '2', 'Main St', 'Quahog', 'RI', '02910', 1, 0, '401', '555-7890', 'meg@quahog.com' UNION ALL
    SELECT 38, '31 Spooner St', 'Friend', '2', 'Main St', 'Quahog', 'RI', '02910', 1, 0, '401', '555-7890', 'chris@quahog.com' UNION ALL
    SELECT 39, '31 Spooner St', 'Friend', '2', 'Main St', 'Quahog', 'RI', '02910', 1, 0, '401', '555-7890', 'stewie@quahog.com' UNION ALL
    SELECT 40, '31 Spooner St', 'Friend', '2', 'Main St', 'Quahog', 'RI', '02910', 1, 0, '401', '555-7890', 'brian@quahog.com' UNION ALL
    SELECT 41, 'South Park Elementary', 'Friend', '1234', 'South Park Ave', 'South Park', 'CO', '80440', 1, 0, '555', '234-5678', 'eric@southpark.com' UNION ALL
    SELECT 42, 'South Park Elementary', 'Friend', '1234', 'South Park Ave', 'South Park', 'CO', '80440', 1, 0, '555', '234-5678', 'stan@southpark.com' UNION ALL
    SELECT 43, 'South Park Elementary', 'Friend', '1234', 'South Park Ave', 'South Park', 'CO', '80440', 1, 0, '555', '234-5678', 'kyle@southpark.com' UNION ALL
    SELECT 44, 'South Park Elementary', 'Friend', '1234', 'South Park Ave', 'South Park', 'CO', '80440', 1, 0, '555', '234-5678', 'kenny@southpark.com' UNION ALL
    SELECT 45, 'City Hall', 'Parent', '555', 'Main St', 'South Park', 'CO', '80440', 1, 1, '555', '987-6543', 'randy@southpark.com' UNION ALL
    SELECT 46, 'Swamp', 'Friend', '1', 'Ogre Rd', 'Duloc', 'NA', '54321', 1, 0, '555', '555-4321', 'shrek@farfaraway.com' UNION ALL
    SELECT 47, 'Swamp', 'Parent', '1', 'Ogre Rd', 'Duloc', 'NA', '54321', 1, 1, '555', '555-4321', 'fiona@farfaraway.com' UNION ALL
    SELECT 48, 'Swamp', 'Friend', '1', 'Ogre Rd', 'Duloc', 'NA', '54321', 1, 0, '555', '555-4321', 'donkey@farfaraway.com' UNION ALL
    SELECT 49, 'Puss', 'Parent', '1', 'Boots Ln', 'Far Far Away', 'NA', '12345', 1, 1, '555', '123-4567', 'puss@farfaraway.com' UNION ALL
    SELECT 50, 'Felix', 'Friend', '1', 'Cat Alley', 'Cartoonland', 'NA', '98765', 1, 0, '555', '987-6543', 'felix@toons.com'
) AS temp_table
WHERE NOT EXISTS (SELECT 1 FROM Address);

INSERT INTO StudentYear (studentID, yearId, isActive)
SELECT * FROM (
    SELECT 1 as studentID, 2005 as yearId, 1 as isActive UNION ALL
    SELECT 2, 2009, 1 UNION ALL
    SELECT 3, 2003, 1 UNION ALL
    SELECT 4, 2011, 1 UNION ALL
    SELECT 5, 2008, 1 UNION ALL
    SELECT 6, 2002, 1 UNION ALL
    SELECT 7, 2007, 1 UNION ALL
    SELECT 8, 2004, 1 UNION ALL
    SELECT 9, 2012, 1 UNION ALL
    SELECT 10, 2001, 1 UNION ALL
    SELECT 11, 2006, 1 UNION ALL
    SELECT 12, 2010, 1 UNION ALL
    SELECT 13, 2002, 1 UNION ALL
    SELECT 14, 2009, 1 UNION ALL
    SELECT 15, 2004, 1 UNION ALL
    SELECT 16, 2008, 1 UNION ALL
    SELECT 17, 2003, 1 UNION ALL
    SELECT 18, 2011, 1 UNION ALL
    SELECT 19, 2005, 1 UNION ALL
    SELECT 20, 2007, 1 UNION ALL
    SELECT 21, 2001, 1 UNION ALL
    SELECT 22, 2012, 1 UNION ALL
    SELECT 23, 2006, 1 UNION ALL
    SELECT 24, 2010, 1 UNION ALL
    SELECT 25, 2002, 1 UNION ALL
    SELECT 26, 2009, 1 UNION ALL
    SELECT 27, 2004, 1 UNION ALL
    SELECT 28, 2008, 1 UNION ALL
    SELECT 29, 2003, 1 UNION ALL
    SELECT 30, 2011, 1 UNION ALL
    SELECT 31, 2005, 1 UNION ALL
    SELECT 32, 2007, 1 UNION ALL
    SELECT 33, 2001, 1 UNION ALL
    SELECT 34, 2012, 1 UNION ALL
    SELECT 35, 2006, 1 UNION ALL
    SELECT 36, 2010, 1 UNION ALL
    SELECT 37, 2002, 1 UNION ALL
    SELECT 38, 2009, 1 UNION ALL
    SELECT 39, 2004, 1 UNION ALL
    SELECT 40, 2008, 1 UNION ALL
    SELECT 41, 2003, 1 UNION ALL
    SELECT 42, 2011, 1 UNION ALL
    SELECT 43, 2005, 1 UNION ALL
    SELECT 44, 2007, 1 UNION ALL
    SELECT 45, 2001, 1 UNION ALL
    SELECT 46, 2012, 1 UNION ALL
    SELECT 47, 2006, 1 UNION ALL
    SELECT 48, 2010, 1 UNION ALL
    SELECT 49, 2002, 1 UNION ALL
    SELECT 50, 2009, 1 UNION ALL
    SELECT 1, 2003, 1 UNION ALL
    SELECT 2, 2008, 1 UNION ALL
    SELECT 3, 2010, 1 UNION ALL
    SELECT 4, 2005, 1 UNION ALL
    SELECT 5, 2001, 1 UNION ALL
    SELECT 6, 2012, 1 UNION ALL
    SELECT 7, 2009, 1 UNION ALL
    SELECT 8, 2003, 1 UNION ALL
    SELECT 9, 2007, 1 UNION ALL
    SELECT 10, 2002, 1 UNION ALL
    SELECT 11, 2011, 1 UNION ALL
    SELECT 12, 2006, 1 UNION ALL
    SELECT 13, 2003, 1 UNION ALL
    SELECT 14, 2008, 1 UNION ALL
    SELECT 15, 2010, 1 UNION ALL
    SELECT 16, 2005, 1 UNION ALL
    SELECT 17, 2001, 1 UNION ALL
    SELECT 18, 2012, 1 UNION ALL
    SELECT 19, 2009, 1 UNION ALL
    SELECT 20, 2004, 1 UNION ALL
    SELECT 21, 2007, 1 UNION ALL
    SELECT 22, 2002, 1 UNION ALL
    SELECT 23, 2011, 1 UNION ALL
    SELECT 24, 2006, 1 UNION ALL
    SELECT 25, 2003, 1 UNION ALL
    SELECT 26, 2008, 1 UNION ALL
    SELECT 27, 2010, 1 UNION ALL
    SELECT 28, 2005, 1 UNION ALL
    SELECT 29, 2001, 1 UNION ALL
    SELECT 30, 2012, 1 UNION ALL
    SELECT 31, 2009, 1 UNION ALL
    SELECT 32, 2004, 1 UNION ALL
    SELECT 33, 2007, 1 UNION ALL
    SELECT 34, 2002, 1 UNION ALL
    SELECT 35, 2011, 1 UNION ALL
    SELECT 36, 2006, 1 UNION ALL
    SELECT 37, 2003, 1 UNION ALL
    SELECT 38, 2008, 1 UNION ALL
    SELECT 39, 2010, 1 UNION ALL
    SELECT 40, 2005, 1 UNION ALL
    SELECT 41, 2001, 1 UNION ALL
    SELECT 42, 2012, 1 UNION ALL
    SELECT 43, 2009, 1 UNION ALL
    SELECT 44, 2004, 1 UNION ALL
    SELECT 45, 2007, 1 UNION ALL
    SELECT 46, 2002, 1 UNION ALL
    SELECT 47, 2011, 1 UNION ALL
    SELECT 48, 2006, 1 UNION ALL
    SELECT 49, 2003, 1 UNION ALL
    SELECT 50, 2008, 1
) AS temp_table
WHERE NOT EXISTS (SELECT 1 FROM StudentYear);

INSERT INTO Question (sortOrder, question, isValid, mysql, response)
SELECT t.*
FROM (
  SELECT 10 AS sortOrder, 'How many students are there in total?' AS question, TRUE AS isValid, NULL AS mysql, NULL AS response
  UNION ALL SELECT 20, 'What''s the earliest birth date in the database?', TRUE, NULL, NULL
  UNION ALL SELECT 30, 'How many students have the last name "Mouse"?', TRUE, NULL, NULL
  UNION ALL SELECT 40, 'Which students don''t have a last name?', TRUE, NULL, NULL
  UNION ALL SELECT 50, 'How many students live in California?', TRUE, NULL, NULL
  UNION ALL SELECT 60, 'Who are all the students from the Simpson family?', TRUE, NULL, NULL
  UNION ALL SELECT 70, 'Which students share the same birth date?', TRUE, NULL, NULL
  UNION ALL SELECT 80, 'How many different states are represented in the addresses?', TRUE, NULL, NULL
  UNION ALL SELECT 90, 'Who has the most recent birth date?', TRUE, NULL, NULL
  UNION ALL SELECT 100, 'How many students have a "Parent" relationship listed?', TRUE, NULL, NULL
  UNION ALL SELECT 110, 'Which email domains are most common?', TRUE, NULL, NULL
  UNION ALL SELECT 120, 'How many students live at the same address?', TRUE, NULL, NULL
  UNION ALL SELECT 130, 'Who are all the students from Bikini Bottom?', TRUE, NULL, NULL
  UNION ALL SELECT 140, 'Which students were active in 2005?', TRUE, NULL, NULL
  UNION ALL SELECT 150, 'How many different area codes are there?', TRUE, NULL, NULL
  UNION ALL SELECT 160, 'Which students have multiple years listed?', TRUE, NULL, NULL
  UNION ALL SELECT 170, 'Who are the oldest students based on birth date?', TRUE, NULL, NULL
  UNION ALL SELECT 180, 'How many students have a "Friend" relationship?', TRUE, NULL, NULL
  UNION ALL SELECT 190, 'Which cities have the most students?', TRUE, NULL, NULL
  UNION ALL SELECT 200, 'How many students have the same first name?', TRUE, NULL, NULL
  UNION ALL SELECT 210, 'Who lives at "31 Spooner St"?', TRUE, NULL, NULL
  UNION ALL SELECT 220, 'Which students are from Warner Bros Studios?', TRUE, NULL, NULL
  UNION ALL SELECT 230, 'How many students don''t have an email address?', TRUE, NULL, NULL
  UNION ALL SELECT 240, 'Which year has the most active students?', TRUE, NULL, NULL
  UNION ALL SELECT 250, 'How many students live in fictional cities?', TRUE, NULL, NULL
  UNION ALL SELECT 260, 'Who are all the Duck family members?', TRUE, NULL, NULL
  UNION ALL SELECT 270, 'Which students share the same contact name?', TRUE, NULL, NULL
  UNION ALL SELECT 280, 'How many different zip codes are there?', TRUE, NULL, NULL
  UNION ALL SELECT 290, 'Who has the longest email address?', TRUE, NULL, NULL
  UNION ALL SELECT 300, 'Which students are from the same family?', TRUE, NULL, NULL
  UNION ALL SELECT 310, 'How many students have a NULL birth date?', TRUE, NULL, NULL
  UNION ALL SELECT 320, 'Which students live and receive mail at the same address?', TRUE, NULL, NULL
  UNION ALL SELECT 330, 'Who has the earliest year ID?', TRUE, NULL, NULL
  UNION ALL SELECT 340, 'How many different streets are there?', TRUE, NULL, NULL
  UNION ALL SELECT 350, 'Which students are from Disney properties?', TRUE, NULL, NULL
  UNION ALL SELECT 360, 'How many students have the same phone number?', TRUE, NULL, NULL
  UNION ALL SELECT 370, 'Who are all the Griffin family members?', TRUE, NULL, NULL
  UNION ALL SELECT 380, 'Which students don''t have a state listed?', TRUE, NULL, NULL
  UNION ALL SELECT 390, 'How many students were born in the 1920s?', TRUE, NULL, NULL
  UNION ALL SELECT 400, 'Which students have multiple active years?', TRUE, NULL, NULL
  UNION ALL SELECT 410, 'Who are all the students from South Park?', TRUE, NULL, NULL
  UNION ALL SELECT 420, 'How many different relationships are listed?', TRUE, NULL, NULL
  UNION ALL SELECT 430, 'Which students share the same contact information?', TRUE, NULL, NULL
  UNION ALL SELECT 440, 'How many students were born on the same day?', TRUE, NULL, NULL
  UNION ALL SELECT 450, 'Who has the most recent year ID?', TRUE, NULL, NULL
  UNION ALL SELECT 460, 'Which students have incomplete address information?', TRUE, NULL, NULL
  UNION ALL SELECT 470, 'How many students are from each decade?', TRUE, NULL, NULL
  UNION ALL SELECT 480, 'Who are all the students from Bedrock?', TRUE, NULL, NULL
  UNION ALL SELECT 490, 'Which students have matching first and last names?', TRUE, NULL, NULL
  UNION ALL SELECT 500, 'How many different contact names are there?', TRUE, NULL, NULL
  UNION ALL SELECT 510, 'Who are the students from Orbit City?', TRUE, NULL, NULL
  UNION ALL SELECT 520, 'Which students have the same area code?', TRUE, NULL, NULL
  UNION ALL SELECT 530, 'How many students don''t have a phone number?', TRUE, NULL, NULL
  UNION ALL SELECT 540, 'Who are all the students born in 1999?', TRUE, NULL, NULL
  UNION ALL SELECT 550, 'Which addresses have multiple students?', TRUE, NULL, NULL
  UNION ALL SELECT 560, 'How many students are from each state?', TRUE, NULL, NULL
  UNION ALL SELECT 570, 'Who are the students from Far Far Away?', TRUE, NULL, NULL
  UNION ALL SELECT 580, 'Which students have matching email domains?', TRUE, NULL, NULL
  UNION ALL SELECT 590, 'How many students have a "Pet" relationship?', TRUE, NULL, NULL
  UNION ALL SELECT 600, 'Who has the longest street name?', TRUE, NULL, NULL
  UNION ALL SELECT 610, 'Which students share birth years?', TRUE, NULL, NULL
  UNION ALL SELECT 620, 'How many different cities are represented?', TRUE, NULL, NULL
  UNION ALL SELECT 630, 'Who are all the students without states?', TRUE, NULL, NULL
  UNION ALL SELECT 640, 'Which year has the least active students?', TRUE, NULL, NULL
  UNION ALL SELECT 650, 'How many students have matching contact names?', TRUE, NULL, NULL
  UNION ALL SELECT 660, 'Who are the students from Mystery Inc?', TRUE, NULL, NULL
  UNION ALL SELECT 670, 'Which students have the same zip code?', TRUE, NULL, NULL
  UNION ALL SELECT 680, 'How many students were active in multiple years?', TRUE, NULL, NULL
  UNION ALL SELECT 690, 'Who has the shortest email address?', TRUE, NULL, NULL
  UNION ALL SELECT 700, 'Which students live at the same number?', TRUE, NULL, NULL
  UNION ALL SELECT 710, 'How many different contact relationships exist?', TRUE, NULL, NULL
  UNION ALL SELECT 720, 'Who are all the students from Quahog?', TRUE, NULL, NULL
  UNION ALL SELECT 730, 'Which students have matching phone numbers?', TRUE, NULL, NULL
  UNION ALL SELECT 740, 'How many students don''t have an active year?', TRUE, NULL, NULL
  UNION ALL SELECT 750, 'Who shares the same contact information?', TRUE, NULL, NULL
  UNION ALL SELECT 760, 'Which students have the same birth month?', TRUE, NULL, NULL
  UNION ALL SELECT 770, 'How many different email domains exist?', TRUE, NULL, NULL
  UNION ALL SELECT 780, 'Who are all the students from Sweethaven?', TRUE, NULL, NULL
  UNION ALL SELECT 790, 'Which addresses have the same zip code?', TRUE, NULL, NULL
  UNION ALL SELECT 800, 'How many students have matching area codes?', TRUE, NULL, NULL
  UNION ALL SELECT 810, 'Who are the students without email addresses?', TRUE, NULL, NULL
  UNION ALL SELECT 820, 'Which students have the same contact relationship?', TRUE, NULL, NULL
  UNION ALL SELECT 830, 'How many different street numbers exist?', TRUE, NULL, NULL
  UNION ALL SELECT 840, 'Who are all the students from Springfield?', TRUE, NULL, NULL
  UNION ALL SELECT 850, 'Which students share the same year ID?', TRUE, NULL, NULL
  UNION ALL SELECT 860, 'How many students have incomplete contact info?', TRUE, NULL, NULL
  UNION ALL SELECT 870, 'Who has the most common birth year?', TRUE, NULL, NULL
  UNION ALL SELECT 880, 'Which students have matching city names?', TRUE, NULL, NULL
  UNION ALL SELECT 890, 'How many different birth dates exist?', TRUE, NULL, NULL
  UNION ALL SELECT 900, 'Who are the students from Mouseville?', TRUE, NULL, NULL
  UNION ALL SELECT 910, 'Which addresses have the same state?', TRUE, NULL, NULL
  UNION ALL SELECT 920, 'How many students have matching street names?', TRUE, NULL, NULL
  UNION ALL SELECT 930, 'Who has the most recent active year?', TRUE, NULL, NULL
  UNION ALL SELECT 940, 'Which students share contact names?', TRUE, NULL, NULL
  UNION ALL SELECT 950, 'How many different relationships per city?', TRUE, NULL, NULL
  UNION ALL SELECT 960, 'Who are all the students without birth dates?', TRUE, NULL, NULL
  UNION ALL SELECT 970, 'Which years have the most student activity?', TRUE, NULL, NULL
  UNION ALL SELECT 980, 'How many students share email domains?', TRUE, NULL, NULL
  UNION ALL SELECT 990, 'Who has multiple entries in StudentYear?', TRUE, NULL, NULL
  UNION ALL SELECT 1000, 'Which students have the same contact relationship and city?', TRUE, NULL, NULL
) t
WHERE NOT EXISTS (SELECT 1 FROM Question);