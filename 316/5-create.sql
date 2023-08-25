-- Modify the CREATE TABLE statements as needed to add constraints.
-- Do not otherwise change the column names or types.

CREATE TABLE People
(id INTEGER NOT NULL primary key,
 name VARCHAR(256) NOT NULL,
 pet VARCHAR(256),
 wand_core VARCHAR(256)
);

CREATE TABLE Teacher
(id INTEGER NOT NULL primary key
	references people(id)
);

create function teacher() returns trigger as $teacher$
	begin
		
		if new.id in (select id from student)
			then raise exception 'students cant teach';
		end if;
		return new;
	end;
$teacher$ language plpgsql;

create trigger teacher 
before insert on teacher
for each row execute procedure teacher();

create function teacher2() returns trigger as $teacher2$
	begin
		
		if new.id in (select id from student)
			then raise exception 'students cant teach';
		end if;
		return new;
	end;
$teacher2$ language plpgsql;

create trigger teacher2 
before update on teacher
for each row execute procedure teacher2();

CREATE TABLE House
(name VARCHAR(32) NOT NULL primary key,
 teacher_id INTEGER NOT NULL
	references teacher(id)
);

CREATE TABLE Student
(id INTEGER NOT NULL primary key
	references people(id),
 year INTEGER NOT NULL,
 house_name VARCHAR(32) NOT NULL
	references house(name)
);

create function student() returns trigger as $student$
	begin
		
		if new.id in (select id from teacher)
			then raise exception 'teachers cant student';
		end if;
		return new;
	end;
$student$ language plpgsql;

create trigger student 
before insert on student
for each row execute procedure student();

create function student2() returns trigger as $student2$
	begin
		
		if new.id in (select id from teacher)
			then raise exception 'teachers cant student';
		end if;
		return new;
	end;
$student2$ language plpgsql;

create trigger student2 
before update on student
for each row execute procedure student2();

CREATE TABLE Deed
(id SERIAL PRIMARY KEY,
 student_id INTEGER NOT NULL
	references student(id),
 datetime TIMESTAMP NOT NULL,
 points INTEGER NOT NULL,
 description VARCHAR(512) NOT NULL,
 constraint con3 check ((substring(description,1,13)='Arriving late' and points<-10) or (substring(description,1,13)<>'Arriving late'))
);

CREATE TABLE Subject
(name VARCHAR(256) NOT NULL primary key
);

CREATE TABLE Offering
(subject_name VARCHAR(256) NOT NULL
	references subject(name),
 year INTEGER NOT NULL,
 teacher_id INTEGER NOT NULL
	references teacher(id),
 primary key(subject_name, year),
 constraint con1 unique(year,teacher_id)
);

CREATE TABLE Grade
(student_id INTEGER NOT NULL
	references student(id),
 subject_name VARCHAR(256) NOT NULL,
 year INTEGER NOT NULL,
 grade CHAR(1),
 foreign key(subject_name,year) references offering(subject_name,year),
 primary key(student_id,subject_name,year),
 constraint con2 check (grade = 'O' or grade = 'E' or grade = 'A' or grade = 'P' or grade = 'D' or grade = 'T' or grade is null)
);

create function failure() returns trigger as $failure$
	begin
		
		if exists (
			select *
			from grade
			where (student_id=new.student_id and 
				subject_name=new.subject_name and
				year<new.year and
				(grade='D' or grade='T'))
			)
			then raise exception 'cannot retake flunked class';
		end if;
		return new;
	end;
$failure$ language plpgsql;

create trigger failure 
before insert on grade
for each row execute procedure failure();

create function failure2() returns trigger as $failure2$
	begin
		
		if exists (
			select *
			from grade
			where (student_id=new.student_id and 
				subject_name=new.subject_name and
				year>new.year)
			) and (new.grade='D' or new.grade='T')
			then raise exception 'cannot change to flunkery';
		end if;
		return new;
	end;
$failure2$ language plpgsql;

create trigger failure2 
before update on grade
for each row execute procedure failure2();

CREATE TABLE FavoriteSubject
(student_id INTEGER NOT NULL
	references student(id),
 subject_name VARCHAR(256) NOT NULL
	references subject(name),
 primary key(student_id,subject_name)
);

-- (e) Using a trigger, enforce that if a student ever receives a D or
-- T for a subject, the student cannot take the same subject
-- again. (Otherwise students may repeat a subject.)
CREATE FUNCTION TF_DTGrades() RETURNS TRIGGER AS $$
BEGIN
  -- YOUR IMPLEMENTATION GOES HERE
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TG_DTGrades
  BEFORE INSERT OR UPDATE ON Grade
  FOR EACH ROW
  EXECUTE PROCEDURE TF_DTGrades();

-- (f) Using triggers, enforce that a person cannot be both student
-- and teacher at the same time.
-- YOUR IMPLEMENTATION GOES HERE

-- Some initial data to play with.  These INSERT statements should succeed.
-- Do NOT modify this section.
INSERT INTO People VALUES
  (0, 'Albus Dumbledore', 'Fawkes the phoenix', 'Thestral tail-hair'),
  (1, 'Minerva McGonagall', NULL, 'dragon heartstring'),
  (2, 'Pomona Sprout', NULL, NULL),
  (3, 'Filius Flitwick', NULL, NULL),
  (4, 'Severus Snape', NULL, NULL);
INSERT INTO Teacher VALUES
  (0), (1), (2), (3), (4);
INSERT INTO House VALUES
  ('Gryffindor', 1),
  ('Hufflepuff', 2),
  ('Ravenclaw', 3),
  ('Slytherin', 4);
INSERT INTO People VALUES
  (11, 'Harry Potter', 'Hedwig the owl', 'phoenix feather'),
  (12, 'Hermione Granger', 'Crookshanks the cat', 'dragon heartstring'),
  (13, 'Ron Weasley', 'Scabbers the rat', 'unicorn tail hair'),
  (21, 'Cedric Diggory', NULL, 'unicorn hair'),
  (22, 'Laura Madley', NULL, NULL),
  (31, 'Cho Chang', NULL, NULL),
  (32, 'Luna Lovegood', NULL, NULL),
  (41, 'Draco Malfoy', 'eagle owl', 'dragon heartstring'),
  (42, 'Marcus Flint', NULL, NULL);
INSERT INTO Student VALUES
  (11, 1991, 'Gryffindor'),
  (12, 1991, 'Gryffindor'),
  (13, 1991, 'Gryffindor'),
  (21, 1989, 'Hufflepuff'),
  (22, 1994, 'Hufflepuff'),
  (31, 1990, 'Ravenclaw'),
  (32, 1992, 'Ravenclaw'),
  (41, 1991, 'Slytherin'),
  (42, 1986, 'Slytherin');
INSERT INTO Deed(student_id, datetime, points, description) VALUES
  (11, '1991-09-06 10:00:00', -1, 'Cheekiness'),
  (12, '1991-10-31 13:00:00', -5, 'Claimed to have gone looking for the troll'),
  (11, '1991-10-31 18:00:00', 5, 'For saving Hermione from the troll'),
  (13, '1991-10-31 18:00:00', 5, 'For saving Hermione from the troll'),
  (41, '1992-02-22 07:00:00', -20, 'Wandering the corridors at night'),
  (12, '1992-09-02 11:30:00', 10, 'Getting full marks on Lockhart''s quiz'),
  (13, '1993-10-10 15:30:00', -50, 'For throwing a crocodile heart at Draco Malfoy');
INSERT INTO Subject VALUES
  ('Charms'),
  ('Defence against the Dark Arts'),
  ('Arithmancy'),
  ('Potions'),
  ('Transfiguration');
INSERT INTO Offering
(SELECT 'Charms', year, 3
 FROM generate_series(1986, 1998) as year);
INSERT INTO Offering VALUES('Defence against the Dark Arts', 1996, 4);
INSERT INTO Offering
(SELECT 'Potions', year, 4
 FROM generate_series(1986, 1995) as year);
INSERT INTO Offering VALUES('Transfiguration', 1955, 0);
INSERT INTO Offering
(SELECT 'Transfiguration', year, 1
 FROM generate_series(1986, 1998) as year);
INSERT INTO Grade VALUES
  (13, 'Potions', 1992, 'P'),
  (13, 'Potions', 1993, 'T'),
  (13, 'Transfiguration', 1994, 'P');
INSERT INTO FavoriteSubject VALUES
  (11, 'Defence against the Dark Arts'),
  (12, 'Arithmancy'),
  (13, 'Charms'),
  (21, 'Defence against the Dark Arts'),
  (31, 'Charms'),
  (41, 'Potions');

-- (g) Write an INSERT statement that fails because a student grade
-- record is entered for a non-existent offering.
-- YOUR IMPLEMENTATION GOES HERE

insert into grade values
	(11,'magication',2017,'O');

-- (h) Write an INSERT statement that fails for violating (b).
-- YOUR IMPLEMENTATION GOES HERE

insert into offering values
	('Arithmancy',1996,4);

-- (i) Write an UPDATE statement that fails for violating (c).
-- YOUR IMPLEMENTATION GOES HERE

insert into grade values
	(11, 'Defence against the Dark Arts', 1996, 'z');

-- (j) Write an INSERT statement that fail for violating (d).
-- YOUR IMPLEMENTATION GOES HERE

insert into deed(student_id, datetime, points, description) values
	(11, '1991-09-06 10:00:00', -1, 'Arriving latealsdkgnluaelknv');

-- (k) Write an INSERT statement that fails for violating (e). Then
-- write another UPDATE statement that fails also for violating (e).
-- YOUR IMPLEMENTATION GOES HERE

insert into grade values 
	(13, 'Potions', 1994, 'O');
update grade
set grade='T'
where grade='P';


	

-- (l) Write an INSERT statement that fails for violating (f).  Then
-- write another UPDATE statement fails also for violating (f).
-- YOUR IMPLEMENTATION GOES HERE

insert into student values	
	(0);

insert into teacher values
	(11);
	
update teacher
set id = 11
where id= 0;

update student
set id = 0
where id= 11;

-- (m) Define a view that lists, for each House, the total number of
-- points accumulated by the House during the school year 1991-1992
-- (which started on September 1, 1991 and ended on June 30,
-- 1992). Note that your view should list all Houses, even if a House
-- didn’t have any points earned or deducted during this period (in
-- which case the total should be 0) or there were more points
-- deducted than earned (in which case the total should be negative).
CREATE VIEW HousePoints(house, points) AS
-- REPLACE THE FOLLOWING WITH YOUR IMPLEMENTATION



select foo.name, sum(points) points
from ((select deed.id, house_name as name,points
	from (student inner join deed on student.id=deed.student_id)
	where (datetime>'1991-9-1' and datetime<'1992-6-30'))
	union (SELECT 0,name, 0 FROM House)) foo
group by foo.name
order by points desc;

SELECT * FROM HousePoints;
