----User Table------
create table tblUsers(
PK_UserId int primary key identity(1,1),
UserName varchar(50),
UserEmail varchar(50) unique,
UserPhone bigint,
UserPassword varchar(50),
UserRole varchar(50)-----User,admin-----
)
---category----
create table tblCategory( 
 PK_CategoryId int primary key identity(1,1),
 Category_Name varchar(50)
 )
---Songs table-----
create table tblSongs(
PK_SongId int primary key identity(1,1),
SongName varchar(50),
SongDesc varchar(50),
FK_SongCategory int,
SongSinger varchar(50),
SongWriter varchar(50),
SongYear int,----old and new-----
SongGeneration varchar(50),
 FOREIGN KEY (FK_SongCategory) REFERENCES tblCategory(PK_CategoryId)
)

---Tv-Shows------
create table tblSeries(
PK_SeriesId int primary key identity(1,1),
SeriesName varchar(50),
SeriesDesc varchar(50),
FK_SeriesCategory int,
SeriesCountry varchar(50),
FOREIGN KEY (FK_SeriesCategory) REFERENCES tblCategory(PK_CategoryId)
)
----fav Songs-----
 create table tblFavSongs(
 PK_FavSoId int primary key identity(1,1),
 FK_UserId int,---foreign key----
 FK_SongId int,---foreign key----
  FOREIGN KEY (FK_UserId) REFERENCES tblUsers(PK_UserId),
  FOREIGN KEY (FK_SongId) REFERENCES  tblSongs(PK_SongId)
 )

 ---fav tv Shows-----
 create table tblFavSeries(
 PK_FavSeId int primary key identity(1,1),
 FK_UserId int,---foreign key----
 FK_SeriesId int,---foreign key----
  FOREIGN KEY (FK_UserId) REFERENCES tblUsers(PK_UserId),
  FOREIGN KEY ( FK_SeriesId) REFERENCES  tblSeries(PK_SeriesId)
 )

 ---Stored Procedure----
 CREATE PROCEDURE insertUser(@name varchar(50) ,@phone bigint  ,@email varchar(50),@password varchar(50),@role varchar(50))
 as
 insert into tblUsers(UserName,UserEmail,UserPhone,UserPassword,UserRole) values(@name,@email,@phone,@password,@role)

 --sp for Login--
 CREATE PROCEDURE userLogin(@email varchar(50),@password varchar(50))
 as
 select PK_UserId,UserName,UserEmail,UserRole,UserPassword from tblUsers where UserEmail=@email and UserPassword=@password

 ----Smae user Present or not------------
  CREATE PROCEDURE checkEmail(@email varchar(50))
 as
 select UserName,UserEmail,UserRole,UserPassword from tblUsers where UserEmail=@email
 -------------------------------
 ------Show ALL Songs--------------------
 CREATE PROCEDURE allSongs
 as
 select s.SongName,s.SongDesc,s.SongSinger,s.SongWriter,s.SongYear,s.SongGeneration,c.Category_Name from tblSongs s inner join tblCategory c on s.FK_SongCategory=c.PK_CategoryId
 ----------------------------
 ----Show All Shows-------------
 CREATE PROCEDURE allShows
 as
 select s.SeriesName,s.SeriesDesc,s.SeriesCountry,c.Category_Name from tblSeries s inner join tblCategory c on s.FK_SeriesCategory=c.PK_CategoryId
 ----------------------------

 CREATE PROCEDURE Showfavsongs(@songid int,@id int)
 as
 select s.SongName,s.SongDesc,s.SongSinger,s.SongWriter,s.SongYear,s.SongGeneration from tblSongs s inner join tblFavSongs  c on  c.FK_SongId=@songid and FK_UserId=@id 
 ------------to check song prsent or not----------------
 CREATE PROCEDURE SongsbyName(@songname varchar(50))
 as
 select * from tblSongs where SongName=@songname
 ----------------to REMOVE SONGS----------------
 CREATE PROCEDURE RemoveSong(@songname varchar(50))
 as
 delete from tblSongs where SongName=@songname

-------update songs---------droped----
CREATE PROCEDURE UpdateSong(@songname varchar(50),@songdesc varchar(50),@songwriter varchar(50),@songsinger varchar(50),@songyear int,@songgenration varchar(50))
 as
 update tblSongs set SongDesc=@songdesc,SongWriter=@songwriter,SongSinger=@songsinger,SongGeneration=@songgenration,SongYear=@songyear  where SongName=@songname
 -----------------------------

 drop procedure  UpdateSong

 ------TO CHEECK ROLE-------------
 CREATE PROCEDURE checkrole(@email varchar(50))
 as
 select UserRole from tblUsers where UserEmail=@email 
 
