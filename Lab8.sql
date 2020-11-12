/*2*/
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS actorRoles;
DROP TABLE IF EXISTS directorRoles;


-- Actors--
CREATE TABLE Actors (
   aid                       text not null,
   actorAddress              text,
   actorBirthDate            date,
   actorHairColor            text,
   actorHeightInInches       int,
   actorWeight               text,
   actorSpouseName           int,
   actorFavColor             text,
   actorSAGAnniversaryDate   date,
 primary key(aid)
);


-- Directors--
CREATE TABLE Directors (
   did                           text not null,
   directorSpouseName            text,
   directorFilmSchoolAttended    text,
   directorGuildAnniversaryDate  date,
   directorFavLensMaker          text,  
 primary key(did)
);


-- Movies--
CREATE TABLE Movies (
   mid                          text not null,
   movieName                    text,
   movieDomesticBoxOfficeSales  decimal,
   movieForeignBoxOfficeSales   decimal,
   movieDVDBluraySales       	decimal,
   movieMPAANum                 text,
 primary key(mid)
);


-- People--
CREATE TABLE People (
   pid                   text not null,
   Name                  text,
   Address               text,
   Spouse                text,
 primary key(pid)
);


-- actorRoles--
CREATE TABLE actorRoles (
   arid                   text not null,
   aid                    text,
   mid                    text,
 primary key(arid),
 foreign key (aid) references Actors(aid),
 foreign key (mid) references Movies(mid)
);


-- directorRoles--
CREATE TABLE directorRoles (
   drid                   text not null,
   did                    text,
   mid                    text,
 primary key(drid),
 foreign key (did) references Directors(did),
 foreign key (mid) references Movies(mid)
);



/*4*/
select name from People where pid in (select did from Directors where did in 
                                     (select did from directorRoles where mid in
                                     (select mid from actorRoles where aid in 
                                     (select aid from Actors where aid in 
                                     (select pid from People where anme = "Roger Moore")))));