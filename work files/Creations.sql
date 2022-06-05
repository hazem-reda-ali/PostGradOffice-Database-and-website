Go
Create Database PostGradOffice;
Go
create table PostGradUser (
id int primary key identity,
email varchar(50),
password varchar(25));

create Table Admin(
id int primary key foreign key references PostGradUser(id));

create Table GucianStudent(
id int primary key foreign key references PostGradUser(id),
firstName varchar(20),
lastName varchar(20),
type varchar(10),
faculty varchar(20),
address varchar(40),
GPA decimal(6,5),
UndergradID int,
);

create Table NonGucianStudent(
id int primary key foreign key references PostGradUser(id),
firstName varchar(20),
lastName varchar(20),
type varchar(10),
faculty varchar(20),
address varchar(40),
GPA decimal(6,5),
);

Create Table GUCStudentPhoneNumber(
id int foreign key references GucianStudent(id),
phone varchar(20)
primary key(id,phone)
);

create Table NonGUCStudentphonenumber(
id int foreign key references NonGucianStudent(id),
phone varchar(20)
primary key(id,phone)
);

Create Table Course(
id int primary key identity,
fees int,
creditHours int,
code varchar(15)
);

create table supervisor(
id int primary key foreign key references PostGradUser(id),
name varchar(25),
faculty varchar(20)
);

create table payment(
id int primary key identity,
amount decimal(10,3),
no_installments int,
fundpercentage int);

create table thesis(
serialNumber int primary key,
field varchar(25),
type varchar (10),
title varchar(150),
startDate Datetime,
endDate Datetime,
defenseDate Datetime,
years as (year(endDate) - year(startDate)),
grade decimal(10,6),
payment_id int foreign key references Payment(id),
noExtension int);

create table Publication(
id int primary key identity,
title varchar(40),
date Datetime,
place varchar(40),
accepted Bit,
host varchar(30));

CREATE Table Examiner
(
    id int foreign key references PostGradUser(id),
    primary key(id),
    name varchar(50),
    fieldOfWork varchar(50),
    isNational Bit
);
CREATE Table Defense
(
    serialNumber int foreign key references Thesis(serialNumber),
    date Datetime,
    primary key(serialNumber,date),
    location varchar(50),
    grade decimal(10,6)
);
CREATE Table GUCianProgressReport
(
    sid int foreign key references GucianStudent(id),
    no int,
    primary key(sid,no),
    date Datetime,
    eval int,
    state int,
    thesisSerialNumber int foreign key references Thesis(serialNumber),
    supid int foreign key references Supervisor(id),
    description varchar(500),
    CONSTRAINT CHK_eval CHECK (eval<=3 and eval>=3)
);
CREATE Table NonGUCianProgressReport
(
    sid int foreign key references NonGucianStudent(id),
    no int,
    primary key(sid,no),
    date Datetime,
    eval int,
    state int,
    thesisSerialNumber int foreign key references Thesis(serialNumber),
    supid int foreign key references Supervisor(id),
    description varchar(500),
    CONSTRAINT CHK_eval1 CHECK (eval<=3 and eval>=3)
);
CREATE Table Installment
(
    date Datetime,
    paymentId int foreign key references Payment,
    primary key(date, paymentId),
    amount decimal(10,3),
    done varchar(20)
);

create table NonGucianStudentPayForCourse(
sid int foreign key references NonGucianStudent,
paymentNo int foreign key references Payment,
cid int foreign key references Course,
primary key(sid,paymentno,cid)
);
Create table NonGucianStudentTakeCourse(
sid int foreign key references NonGucianStudent,
cid int foreign key references Course,
grade decimal(10,6),
primary key(sid,cid),
CONSTRAINT CHK_grade CHECK (grade>50)
);
Create table GUCianStudentRegisterThesis(
sid int foreign key references GucianStudent,
supid int foreign key references supervisor,
serial_No int foreign key references thesis ,
primary key(sid, supid, serial_No)
)
Create Table NonGUCianStudentRegisterThesis(
sid int foreign key references NonGucianStudent,
supid int foreign key references supervisor,
serial_No int foreign key references Thesis ,
primary key(sid, supid, serial_No)
)

Create Table ThesisHasPublication(
serialNo int foreign key references thesis ,
pubid int foreign key references Publication ,
primary key(serialNo,pubid)
);

create Table ExaninerEvaluateDefense(
date datetime foreign key references Defense(date),
serialNo int foreign key references Defense(serialNumber),
examinerId int foreign key references Examiner(id),
comment varchar(300),
primary key(date,serialNo,examinerId)
);
