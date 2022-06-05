--1a
Create PROC StudentRegister 
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@Gucian bit,
@email varchar(50),
@address varchar(50)
AS
Insert into PostGradUser (email,[password])
values(@email,@password)
declare @id int
set @id =(select id
from PostGradUser
where email=@email and password = @password)
IF @Gucian = 0
    Insert into NonGucianStudent (id,firstName,lastName,faculty,[address])
    values(@id,@first_name,@last_name,@faculty,@address)
else
    Insert into GucianStudent (id,firstName,lastName,faculty,[address])
    values(@id,@first_name,@last_name,@faculty,@address)

go
Create PROC SupervisorRegister 
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@email varchar(50)
AS
declare @name varchar(50)
Insert into PostGradUser (email,password)
    values(@email,@password)
declare @id int
set @id = (select id
from PostGradUser
where email=@email and password = @password)
Set @name = convert(varchar(50), @first_name) +','+convert(varchar(50),@last_name)
insert into supervisor(id,name , faculty)
values(@id , @name , @faculty)
;
--User Story 2 a
go
create PROC userLogin
@ID int,
@password varchar(20),
@success bit output
AS
declare @tmp varchar(20)
set @tmp = (select [password]
from PostGradUser 
where ID = @ID
 )
 begin
 if @tmp = @password
 set @success =1
 else 
 set @success = 0
 end
 ;
--User Story 2 b
go
create PROC addMobile
@ID int,
@mobile_number varchar(20)
AS
Begin
Declare @returnedbit Bit
if(Exists (select GS.* 
    from GucianStudent GS
    where GS.id = @ID))
    set @returnedbit = 1
    else
    set @returnedbit = 0;
    return @returnedbit
    end;
begin 
if @returnedbit = 1
update GUCStudentPhoneNumber
set phone = @mobile_number
where id = @ID
else
update NonGUCStudentPhoneNumber 
set phone = @mobile_number
where id = @ID
end
;

--3a list all supervisor
go
create proc AdminListSup
AS 
select * from supervisor
;
-- User Story 3 b
GO
Create proc AdminViewSupervisorProfile
@supId int
AS 
select * from supervisor where id=@supId
;
--User Story 3 c
GO
create proc AdminViewAllTheses
AS 
select * from thesis
--User Story 3 d
GO
create proc AdminViewOnGoingTheses
@thesesCount int output
AS
select @thesesCount = count(*)
from thesis 
where endDate > current_timestamp
;
--User Story 3 e
Go
Create PROC AdminViewStudentThesisBySupervisor
As
select S.name, T.title, G.firstName,G.lastName, NG.firstName , NG.lastName
from supervisor S
inner join GUCianStudentRegisterThesis GSR on GSR.supid = S.id
inner join NonGUCianStudentRegisterThesis NGSR on NGSR.supid = S.id
inner join GucianStudent G on G.id = GSR.sid
inner join NonGucianStudent NG on NG.id = NGSR.sid
inner join Thesis T on T.SerialNumber = GSR.serial_no or T.serialNumber = NGSR.serial_No
where T.endDate > current_timestamp
;

/*3f list nonGucian names, course code and respective grade*/
Go
create proc AdminListNonGucianCourse
@courseID int
AS
select NG.firstName, NG.lastName, C.code, G.grade
from NonGucianStudentTakeCourse G
inner join NonGucianStudent NG on G.sid= NG.id
inner join Course C on C.id= G.cid
;
go
/*3g increment NOextensions */
create proc AdminUpdateExtension
@ThesisSerialNo int
AS
update thesis
set noExtension = noExtension+1
where @ThesisSerialNo=serialNumber
;

--3h
Go
Create PROC  AdminIssueThesisPayment
@ThesisSerialNo int,
@amount decimal,
@noOfInstallments int,
@fundPercentage decimal,
@Success bit output
As
insert into Payment (amount, no_Installments, fundPercentage)
values (@amount,@noOfInstallments,@fundPercentage)
declare @id int
set @id =(select id
from payment
where amount=@amount and no_installments = @noOfInstallments and fundpercentage = @fundPercentage)
update Thesis 
set payment_id = @id
where serialNumber = @ThesisSerialNo
set @success = 1
;


/*3i view the profile of any student that contains all his/her information.*/
Go
create proc AdminViewStudentProfile
@sid int
AS
if (dbo.checkstudenttype(@sid) = 1) 
Select * from GucianStudent GS inner join PostGradUser PGU on GS.id = PGU.id where @sid=GS.id
Else
Select * from NonGucianStudent NG inner join PostGradUser PGU on PGU.id=NG.id where @sid=NG.id
;

--User Story 3 j
go
Create PROC AdminIssueInstallPayment
@paymentID int,
@InstallStartDate date
As
DECLARE @Counter INT 
SET @Counter=(select no_installments
from Payment 
where @paymentID = Id)
declare @amount int
set @amount= (select (amount/no_Installments)
from payment 
where id = @paymentID)
WHILE ( @Counter >0)
BEGIN
   set @Counter = @Counter - 1
   update Installment 
   SET [date]= dateadd(month, 6,[date])
   where @paymentID = paymentID
   update Installment 
   Set amount = amount +@amount
END
 ;



/*3k List the title(s) of accepted publication(s) per thesis.*/
Go
create proc AdminListAcceptPublication
AS
SELECT P.title
from Publication P inner join ThesisHasPublication THP ON P.id= THP.pubid
                    inner join thesis T on THP.serialNo=T.serialNumber
where P.accepted = 1

--User Story 3 l
Go
create PROC  AddCourse
@courseCode varchar(10),
@creditHrs int,
@fees decimal
AS
insert into Course (fees,creditHours,code)
values (@fees,@creditHrs,@courseCode)
;
go
Create PROC linkCourseStudent
@courseID int,
@studentID int
AS
Update NonGucianStudentTakeCourse
set cid = @courseID
where sid = @studentID
;
go
Create PROC addStudentCourseGrade
@courseID int,
@studentID int,
@grade decimal
As
update NonGucianStudentTakeCourse 
set grade = @grade 
where [sid] = @studentID and cid = @courseID

----3m
go
create PROC ViewExamSupDefense
@defenseDate datetime
as
select E.name,S.name
from Defense D
inner join ExaminerEvaluateDefense EED on EED.serialNo= D.serialNumber
inner join Examiner E on EED.examinerId=E.id
inner join Thesis T on T.serialNumber = D.serialNumber
inner join GUCianStudentRegisterThesis GSR on GSR.serial_no = T.serialNumber
inner join NonGUCianStudentRegisterThesis NGSR on NGSR.serial_no = T.serialNumber
inner join supervisor S on S.id = GSR.supid
where T.defensedate = @defenseDate
















--User Story 4 a
Go
Create Proc EvaluateProgressReport
@supervisorID int,
@thesisSerialNo int,
@progressReportNo int,
@evaluation int
as
declare @studentid int
set @studentid = dbo.getstudentid(@thesisSerialNo)
if (dbo.checkstudenttype(@studentid) = 1) 
Update GUCianProgressReport
set eval = @evaluation
where supid=@supervisorID and thesisSerialNumber = @thesisSerialNo and no = @progressReportNo
else
Update NonGUCianProgressReport
set eval = @evaluation
where supid=@supervisorID and thesisSerialNumber = @thesisSerialNo and no = @progressReportNo


----4b
go
Create PROC ViewSupStudentsYears
@supervisorID int
as
select G.firstName, NG.firstName, T.years
from thesis T 
inner join GUCianStudentRegisterThesis GS ON T.serialNumber = GS.serial_no
inner join GUCianStudentRegisterThesis NGS ON T.serialNumber = NGS.serial_no
inner join supervisor S on S.id = NGS.Sid
inner join GucianStudent G on G.id = GS.sid
inner join NonGucianStudent NG on NG.id = NGS.sid
;
-----4c
go
create Proc SupViewProfile
@supervisorID int
As
select S.*
from Supervisor S where S.id = @supervisorID
;

go
Create Proc UpdateSupProfile
@supervisorID int,
@name varchar(20),
@faculty varchar(20)
As
update Supervisor
Set name = @name
where id = @supervisorID

update Supervisor
Set faculty = @faculty
where id = @supervisorID
;

---4d
go
Create PROC ViewAStudentPublications
@StudentID int
as
Begin
Declare @returnedbit Bit
if(Exists (select GS.* 
    from GucianStudent GS
    where GS.id = @studentid))
    set @returnedbit = 1
    else
    set @returnedbit = 0;
    return @returnedbit
    end;
begin
if(@returnedbit = 1)
    Select P.title
    from GUCianStudentRegisterThesis GSR 
    inner join thesis T on GSR.serial_no = T.serialNumber
    inner join ThesisHasPublication THP on THP.serialNo = T.serialNumber
    inner join Publication P on P.id = THP.pubid
    where GSR.sid = @StudentID
else
    Select P.title
    from NonGUCianStudentRegisterThesis NGSR 
    inner join thesis T on NGSR.serial_no = T.serialNumber
    inner join ThesisHasPublication THP on THP.serialNo = T.serialNumber
    inner join Publication P on P.id = THP.pubid
    where NGSR.sid =@StudentID
    end;

--4 e
go
Create Proc AddDefenseGucian 
@ThesisSerialNo int,
@DefenseDate Datetime,
@DefenseLocation varchar(15)
as
update Defense
set [date] = @DefenseDate
where serialNumber = @ThesisSerialNo

update Defense
set [location] = @DefenseLocation
where serialNumber = @ThesisSerialNo



go
Create Proc AddDefenseNonGucian 
@ThesisSerialNo int,
@DefenseDate Datetime,
@DefenseLocation varchar(15)
as
update Defense
set [date] = @DefenseDate
where serialNumber = @ThesisSerialNo

update Defense
set [location] = @DefenseLocation
where serialNumber = @ThesisSerialNo
;
--4 f
go
Create Proc AddExaminer 
@ThesisSerialNo int , 
@DefenseDate Datetime , 
@ExaminerName varchar(20), 
@National bit, 
@fieldOfWork varchar(20)
As
declare @id int
insert into ExaminerEvaluateDefense([date], serialNo)
values (@DefenseDate,@ThesisSerialNo)
set @ID=(select id 
from ExaminerEvaluateDefense
where serialNo = @ThesisSerialNo)
update examiner 
set [name] = @ExaminerName
where ID = @ID 
update examiner 
set fieldOfWork = @fieldOfWork
where ID = @ID 
update examiner 
set isNational= @National
where ID = @ID 
;
--4 g
Go
create proc CancelThesis
@ThesisSerialNo int
AS
Declare @returnedbit Bit
begin
if(Exists (select GS.* 
    from GUCianProgressReport GS
    where GS.thesisSerialNumber = @ThesisSerialNo))
    set @returnedbit = '1'
    else
    set @returnedbit = '0';
    return @returnedbit
    end
if(@returnedbit='1')
	begin
	DELETE thesis
     FROM thesis INNER JOIN GUCianProgressReport
     ON GUCianProgressReport.thesisSerialNumber = thesis.serialNumber
     WHERE thesis.serialNumber=@ThesisSerialNo and GUCianProgressReport.eval=0;
	end
else if (@returnedbit='0')
	begin
	DELETE thesis
     FROM thesis INNER JOIN NonGUCianProgressReport
     ON NonGUCianProgressReport.thesisSerialNumber = thesis.serialNumber
     WHERE thesis.serialNumber=@ThesisSerialNo and NonGUCianProgressReport.eval=0;
	end

---4h
go
Create Proc AddGrade
@ThesisSerialNo int,
@grade decimal(10,6)
as
update thesis 
set thesis.grade =@grade 
where thesis.serialNumber = @ThesisSerialNo
;


----5
go
create PROC AddDefenseGrade
@ThesisSerialNo int,
@DefenseDate datetime,
@grade decimal
As
update defense 
set defense.grade = @grade 
where defense.serialNumber = @ThesisSerialNo
;

go
Create PROC AddCommentsGrade
@ThesisSerialNo int,
@DefenseDate datetime,
@comments varchar(300)
As
update ExaminerEvaluateDefense
set ExaminerEvaluateDefense.comment = @comments
where ExaminerEvaluateDefense.serialNo = @ThesisSerialNo
;
;






-- User story 6 a we check if gucian or not then retuen data accordingly
Go
Create function checkstudenttype
(@studentid int)
Returns Bit
Begin
Declare @returnedbit Bit
if(Exists (select GS.* 
	from GucianStudent GS
	where GS.id = @studentid))
	set @returnedbit = 1
	else
	set @returnedbit = 0;
	return @returnedbit
	end;

Go
Create proc viewMyProfile
@studentId int
as
if (dbo.checkstudenttype(@studentid) = 1) 
select *
from GucianStudent
where id=@studentid

else
select *
from NonGucianStudent
where id=@studentid;

--User strory 6 b
Go
create proc editMyProfile
@studentID int,
@firstName varchar(10),
@lastName varchar(10),
@password varchar(10),
@email varchar(10),
@address varchar(10),
@type varchar(10)
as
Update PostGradUser
set email = @email , password = @password
if (dbo.checkstudenttype(@studentid) = 1) 
Update GucianStudent
set firstName = @firstName , lastName=@lastName ,address = @address , type = @type
where id=@studentID
else
Update NonGucianStudent
set firstName = @firstName , lastName=@lastName ,address = @address , type = @type
where id=@studentID

--User story 6 c
Go
create Proc addUndergradID
@studentID int,
@undergradID varchar(10)
as
Update GucianStudent
Set UndergradID = @undergradID
where id = @studentID

--User story 6 d
Go
create proc ViewCoursesGrades
@studentid int
as
select NGTC.grade,C.code
from NonGucianStudentTakeCourse NGTC inner join NonGucianStudent NG on NGTC.sid=NG.id inner join Course C on C.id=NGTC.cid
where NG.id = @studentid

--user story 6 e
Go
create proc ViewCoursePaymentsInstall
@studentID int
as
select C.code,P.*,I.*
from NonGucianStudentPayForCourse NGPC inner join NonGucianStudent NG on NG.id=NGPC.sid inner join Course C on C.id=NGPC.cid inner join Payment P on NGPC.paymentNo = P.id inner join Installment I on I.paymentId = P.id
where NG.id=@studentID

Go
Create proc ViewThesisPaymentsInstall
@studentID int
as
if (dbo.checkstudenttype(@studentid) = 1)
select T.*,P.*,I.*
from GUCianStudentRegisterThesis GSRT inner join Thesis T on T.serialNumber = GSRT.serial_no inner join Payment P on P.id = T.payment_id inner join Installment I on I.paymentId = P.id
where GSRT.sid = @studentID

else
select T.*,P.*,I.*
from NonGUCianStudentRegisterThesis GSRT inner join Thesis T on T.serialNumber = GSRT.serial_no inner join Payment P on P.id = T.payment_id inner join Installment I on I.paymentId = P.id
where GSRT.sid = @studentID

Go
create proc  ViewUpcomingInstallments
@studentID int
as
if (dbo.checkstudenttype(@studentid) = 1)
select I.*
from GUCianStudentRegisterThesis GSRT inner join Thesis T on T.serialNumber = GSRT.serial_no inner join Payment P on P.id = T.payment_id inner join Installment I on I.paymentId = P.id
where GSRT.sid = @studentID and I.date > current_timestamp

else
select I.*
from NonGUCianStudentRegisterThesis NGRT inner join Thesis T on T.serialNumber = NGRT.serial_no inner join Payment P on P.id = T.payment_id inner join Installment I on I.paymentId = P.id inner join NonGucianStudentPayForCourse NGPC on NGPC.sid = NGRT.sid  inner join NonGucianStudent NG on NG.id=NGPC.sid inner join Course C on C.id = NGPC.cid
where NG.id = @studentID and I.date > current_timestamp

Go
create proc  ViewMissedInstallments
@studentID int
as
if (dbo.checkstudenttype(@studentid) = 1)
select I.*
from GUCianStudentRegisterThesis GSRT inner join Thesis T on T.serialNumber = GSRT.serial_no inner join Payment P on P.id = T.payment_id inner join Installment I on I.paymentId = P.id
where GSRT.sid = @studentID and I.date < current_timestamp and I.done = 'Not'

else
select I.*
from NonGUCianStudentRegisterThesis NGRT inner join Thesis T on T.serialNumber = NGRT.serial_no inner join Payment P on P.id = T.payment_id inner join Installment I on I.paymentId = P.id inner join NonGucianStudentPayForCourse NGPC on NGPC.sid = NGRT.sid  inner join NonGucianStudent NG on NG.id=NGPC.sid inner join Course C on C.id = NGPC.cid
where NG.id = @studentID and I.date < current_timestamp and I.done = 'Not'

--User story 6 f
Go
create Function getstudentid
(@thesisSerialNo int)
Returns int
Begin
declare @returnedid int
 set @returnedid = (Select GPR.sid
	from GUCianProgressReport GPR inner join Thesis T on GPR.thesisSerialNumber = T.serialNumber inner join NonGUCianProgressReport NGPR on NGPR.thesisSerialNumber=T.serialNumber
	where GPR.thesisSerialNumber = @thesisSerialNo OR NGPR.thesisSerialNumber = @thesisSerialNo)

return @returnedid
END

Go
Create proc AddProgressReport
@thesisSerialNo int,
@progressReportDate date
as
declare @studentid int
set @studentid = dbo.getstudentid(@thesisSerialNo)
if (dbo.checkstudenttype(@studentid) = 1)
begin
Update GUCianProgressReport
set date = @progressReportDate
where sid = @studentid
Update GUCianProgressReport
set thesisSerialNumber = @thesisSerialNo
where sid = @studentid
end
else
Update NonGUCianProgressReport
set date = @progressReportDate
where sid = @studentid
Update NonGUCianProgressReport
set thesisSerialNumber = @thesisSerialNo
where sid = @studentid

Go
create proc FillProgressReport
@thesisSerialNo int,
@progressReportNo int,
@state int,
@description varchar(500)
as
declare @studentid int
set @studentid = dbo.getstudentid(@thesisSerialNo)
if (dbo.checkstudenttype(@studentid) = 1)
begin
Update GUCianProgressReport
set thesisSerialNumber = @thesisSerialNo
where sid = @studentid
Update GUCianProgressReport
set no = @progressReportNo
where sid = @studentid
Update GUCianProgressReport
set state = @state
where sid = @studentid
Update GUCianProgressReport
set description = @description
where sid = @studentid
end

else
Update NonGUCianProgressReport
set thesisSerialNumber = @thesisSerialNo
where sid = @studentid
Update NonGUCianProgressReport
set no = @progressReportNo
where sid = @studentid
Update NonGUCianProgressReport
set state = @state
where sid = @studentid
Update NonGUCianProgressReport
set description = @description
where sid = @studentid

-- user story 6 g
Go
Create proc ViewEvalProgressReport
@thesisSerialNo int,
@progressReportNo int
as
declare @studentid int
set @studentid = dbo.getstudentid(@thesisSerialNo)
if (dbo.checkstudenttype(@studentid) = 1)
select GPR.eval
from GUCianProgressReport GPR
where GPR.thesisSerialNumber = @thesisSerialNo and GPR.no = @progressReportNo

--User Story 6 h
Go
create proc addPublication
@title varchar(40),
@pubDate datetime,
@host varchar(30),
@place varchar(40),
@accepted bit
as
insert into Publication(title , date , place , accepted , host)
values(@title , @pubDate , @place , @accepted , @host)

--User Story 6 i
Go
Create proc linkPubThesis
@PubID int,
@thesisSerialNo int
as
insert into ThesisHasPublication(serialNo , pubid)
values(@thesisSerialNo , @PubID)