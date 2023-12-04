create table NewEmployee(
eid int primary key,
ename varchar(50),
eage int,
esalary int
)

create table Users(
uid int primary key,
uname varchar(50),
upassword varchar(50),
uemail varchar(50),
uphone int,
uage int
)

--insert-----
create proc insertUsers(@id int,@name varchar(50) ,@age int ,@phone int ,@email varchar(50),@password varchar(50))
as
Insert into Users(uid,uname,upassword,uemail,uphone,uage) values(@id,@name,@password,@email,@phone,@age)

---update---
create proc updateUsers(@id int,@name varchar(50) ,@age int ,@phone int ,@email varchar(50),@password varchar(50))
as
update Users set uname=@name,upassword=@password,uemail=@email,uphone=@phone,uage=@age where  uid=@id

drop proc updateUsers

--delete-
create proc deleteUser(@id int)
as
delete from Users  where  uid=@id
