DROP TABLE IF EXISTS Records;
DROP TABLE IF EXISTS Ranking;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Coach;
DROP TABLE IF EXISTS Gymnasts;
DROP TABLE IF EXISTS People;


-- People --
CREATE TABLE People (
   pid         int not null,
   fname       text,
   lname       text,
   yearsActive int,
 primary key(pid)
);


-- Gymnasts --
CREATE TABLE Gymnasts (
   gid						   char(3) not null,
   pid                         int not null references People(pid),
   HeightInInches       	   int,
   WeightInPounds              int,
   DateOfBirth 		           date,
   homeCity 		           text,
   homestate 		           text,
   FavEvent                    text,
 primary key(gid),
	CONSTRAINT CHK_FavEvent CHECK (FavEvent = 'Bars' OR 
								   FavEvent = 'Beam' OR 
								   FavEvent = 'Vault' OR 
								   FavEvent = 'Floor')
);


-- Coach --
CREATE TABLE Coach (
   cid						   char(3) not null,
   pid                         int not null references People(pid),
   specialties       	       text,
 primary key(cid, pid)
);


-- Events --
CREATE TABLE Events (
   eid       	               char(3) not null,
   gid                         char(3) not null references Gymnasts(gid),
   eventType       	           text,
   eventTime                   time,
   eventDate 		           date,
   venue 		               text,
   winner 		               text,
   score                       decimal,
 primary key(eid),
	CONSTRAINT CHK_eventType CHECK (eventType = 'Individual: Bars' OR 
				                    eventType = 'Individual: Beam' OR 
								    eventType = 'Individual: Vault' OR 
								    eventType = 'Individual: Floor' OR 
								    eventType = 'All-Round' OR eventType = 'Team Final')
);


-- Ranking --
CREATE TABLE Ranking (
   rid						   char(3) not null,
   gid                         char(3) not null references Gymnasts(gid),
   rankingInWorld       	   int,
   rankingInCountry       	   int,
 primary key(rid)
);


-- Records --
CREATE TABLE Records (
   recID					   char(5) not null,
   gid                         char(3) not null references Gymnasts(gid),
   recordDescription      	   text,
   nameOfGymnastPrevRecSetBy   text,
   yearOfPrevRecSet			   date,
   yearOfNewRecSet			   date,
 primary key(recID)
);


-- Inserting data into the people data
INSERT INTO People (pid, fname, lname, yearsActive)
VALUES
 (001, 'Simone',   'Biles',     17),
 (002, 'Laurie',   'Hernandez', 15),
 (003, 'Madison',  'Kocian',    17),
 (004, 'Gabby',    'Douglas',   18),
 (005, 'Aly',      'Raisman',   20),
 (006, 'Other',    'Country',    0),
 (007, 'Team',     'USA',        0),
 (008, 'Mihai',    'Brestyan',  40),
 (009, 'Laurent',  'Landi',     20),
 (010, 'Christian','Gallardo',  15),
 (011, 'Maggie',   'Haney',     13),
 (012, 'Cecile',   'Landi',     20),
 (013, 'Alan',     'Labouseur', 18)
;


-- Inserting data into the gymnast data
INSERT INTO Gymnasts (gid, pid, HeightInInches, WeightInPounds, DateOfBirth, homeCity, homestate, FavEvent)
VALUES
 ('g01', 001, 56, 104, '1997-03-14', 'Columbus',    'Ohio',         'Floor'),
 ('g02', 002, 61, 106, '2000-06-09', 'Old Bridge',  'New Jersey',   'Floor'),
 ('g03', 003, 62, 101, '1997-06-15', 'Dallas',      'Texas',        'Bars'),
 ('g04', 004, 62, 108, '1995-12-31', 'Newport News','Virginia',     'Beam'),
 ('g05', 005, 62, 115, '1994-05-25', 'Needham',     'Massachusetts','Floor'),
 ('g06', 006, 62, 115, '1994-05-25', 'Other',       'Country',      'Floor'),
 ('g07', 007, 62, 115, '1994-05-25', 'Team',        'USA',          'Floor')
;


-- Inserting data into the coach data
INSERT INTO Coach (cid, pid, specialties)
VALUES
 ('c01', 008, 'Floor'),
 ('c02', 009, 'Bars'),
 ('c03', 010, 'Head Coach'),
 ('c04', 011, 'Head Coach'),
 ('c05', 012, 'Choreography'),
 ('c06', 013, 'Vault')
;


-- Inserting data into the events data
INSERT INTO Events (eid, gid, eventType, eventTime, eventDate, venue, winner, score)
VALUES
 ('e01', 'g06', 'Individual: Bars',  '14:00:00', '2016-08-14', 'Arena Olimpica do Rio', 'Aliya Mustafina', 15.900),
 ('e02', 'g06', 'Individual: Beam',  '12:00:00', '2016-08-15', 'Arena Olimpica do Rio', 'Sanne Wevers',    15.466),
 ('e03', 'g01', 'Individual: Vault', '08:00:00', '2016-08-14', 'Arena Olimpica do Rio', 'Simone Biles',    15.966),
 ('e04', 'g01', 'Individual: Floor', '14:00:00', '2016-08-16', 'Arena Olimpica do Rio', 'Simone Biles',    15.966),
 ('e05', 'g01', 'All-Round',         '08:00:00', '2016-08-11', 'Arena Olimpica do Rio', 'Simone Biles',    62.198),
 ('e06', 'g07', 'Team Final',        '08:00:00', '2016-08-09', 'Arena Olimpica do Rio', 'USA'         ,    184.897)
;


-- Inserting data into the ranking data
INSERT INTO Ranking (rid, gid, rankingInWorld, rankingInCountry)
VALUES
 ('r01', 'g01',  1, 1),
 ('r02', 'g02',  3, 3),
 ('r03', 'g03',  5, 5),
 ('r04', 'g04',  4, 4),
 ('r05', 'g05',  2, 2)
 ;
 
 
 -- Inserting data into the records data
INSERT INTO Records (recID, gid, recordDescription, nameOfGymnastPrevRecSetBy, yearOfPrevRecSet, yearOfNewRecSet)
VALUES
 ('rec01', 'g01',  'Win of four gold medals at a single Games',              'Ecaterina Szabo',   '1984-08-20', '2016-08-20'),
 ('rec02', 'g01',  'Won the all around gold as well as an event final gold', 'Lilia Podkopayeva', '1996-08-20', '2016-08-20')
 ;
 
 select *
 from People;
 
 select *
 from Gymnasts;
 
 select *
 from Coach;
 
 select *
 from Events;
 
 select *
 from Ranking;
 
 select *
 from Records;

-- End of Create Statements and Inserting --

-- Views --
DROP VIEW IndividualEvent;		
CREATE VIEW IndividualEvent
as 
select eid, gid, (eventType = 'Individual: Bars') AND  
		 (eventType = 'Individual: Beam') AND  
		 (eventType = 'Individual: Vault') AND 
		 (eventType = 'Individual: Floor'), winner, score
from Events
where score < 60
order by score DESC;

select * from IndividualEvent;


DROP VIEW AllRoundEvent;		
CREATE VIEW AllRoundEvent
as 
select eid, gid, (eventType = 'All-Round') winner, score
from Events
where score > 60 AND score < 180;

select * from AllRoundEvent;


DROP VIEW TeamFinalEvent;		
CREATE VIEW TeamFinalEvent
as 
select eid, gid, (eventType = 'Team Final') winner, score
from Events
where score > 180;

select * from TeamFinalEvent;


-- Reports --
select *
from Ranking r
left outer join Gymnasts g on g.gid = r.gid
left outer join Records rec on rec.gid = r.gid
where rankingInWorld < 3;


select fname, lname, yearsActive, cid, specialties  
from People p
left join Gymnasts g on g.pid = p.pid
left join Coach    c on c.pid = p.pid
where yearsActive >= 18;


select *
from People p inner join Coach c on p.pid = c.pid
where specialties = 'Floor';


select gid, FavEvent
from Gymnasts
where gid in (select gid from Ranking where rankingInWorld > 1)
group by HeightInInches, gymnasts.gid;


-- Stored Procedures --
create or replace function CoachSpecialties(char(3), REFCURSOR) returns refcursor as 
$$
declare  
   cSpecialty           char(3)       := $1;
   resultset            REFCURSOR     := $2;
begin
   open resultset for 
      select cid, specialties
      from   Coach 
      where cid = cSpecialty;
   return resultset;
end;
$$ 
language plpgsql;

select CoachSpecialties('c05', 'results');
Fetch all from results;


create or replace function RankingInWorld(char(3), REFCURSOR) returns refcursor as 
$$
declare  
   rRank                char(3)       := $1;
   resultset            REFCURSOR     := $2;
begin
   open resultset for 
      select gid, rankingInWorld
      from   Ranking 
      where  gid = rRank;
   return resultset;
end;
$$ 
language plpgsql;

select RankingInWorld('g04', 'results');
Fetch all from results;


create or replace function GymnastHomeState(char(3), REFCURSOR) returns refcursor as 
$$
declare  
   gHomeState           char(3)       := $1;
   resultset            REFCURSOR     := $2;
begin
   open resultset for 
      select gid, homestate
      from   Gymnasts 
      where  gid = gHomeState;
   return resultset;
end;
$$ 
language plpgsql;

select GymnastHomeState('g03', 'results');
Fetch all from results;


create or replace function getEventTime() returns trigger as 
$$
begin
  IF (NEW.eventTime > '14:00:00') THEN
  delete from Events where eventTime = NEW.eventTime;
  END IF;
  RETURN NEW;
end;
$$ 
language plpgsql;


-- Triggers -- 
create trigger getEventTime AFTER INSERT ON Events
	FOR EACH ROW EXECUTE PROCEDURE getEventTime();
   
   -- Data to test the trigger
INSERT INTO Events 
VALUES ('e07', 'g02', 'Individual: Floor', '13:00:00', '2016-08-16', 'Arena Olimpica do Rio', 'Simone Biles',    15.566),
		('e08', 'g03', 'Individual: Floor', '15:00:00', '2016-08-16', 'Arena Olimpica do Rio', 'Simone Biles',    15.466);


-- Security/Roles --
create role admin;
GRANT ALL ON ALL TABLES
IN SCHEMA PUBLIC 
TO admin;

create role judges;
GRANT SELECT INSERT, UPDATE ON ALL TABLES
IN SCHEMA PUBLIC 
TO judges;

create role coach;
GRANT SELECT ON ALL TABLES
IN SCHEMA PUBLIC 
TO coach;

create role gymnast;
GRANT SELECT ON ALL TABLES
IN SCHEMA PUBLIC 
TO gymnast;

create role commentators;
GRANT SELECT ON ALL TABLES
IN SCHEMA PUBLIC 
TO commentators;


 