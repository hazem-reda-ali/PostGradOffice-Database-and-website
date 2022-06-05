-- User Story 1 a
Exec StudentRegister 'Omar','Ashraf', 'testtest123' ,'management', 1, 'omardagoat@gmail.com', '37 downing street'
Exec StudentRegister 'Ahmed','Ashraf', 'testtest345' ,'management', 0, 'omardagoat@gmail.com', '37 downing street'

Exec SupervisorRegister 'Ahmed', 'Hossam' ,'testing345', 'engineering' ,'ahmedhos@gmail.com'

-- User Story 2 a
declare @success bit
Exec userLogin 2 ,'testtest345' ,@success output
print @success

declare @success bit
Exec userLogin 1 ,'Karim69420' ,@success output
print @success

--2 b
Exec addMobile 1 ,'01092837375'


--3 a
Exec AdminListSup

--3 b
Exec AdminViewSupervisorProfile 10
Exec AdminViewSupervisorProfile 5
Exec AdminViewSupervisorProfile 15
--3 c
Exec  AdminViewAllTheses

--3 d
declare @thesesCount int
Exec AdminViewOnGoingTheses @thesesCount output
print @thesesCount
--3 e
Exec AdminViewStudentThesisBySupervisor

--3 f
Exec AdminListNonGucianCourse 2
Exec AdminListNonGucianCourse 3
Exec AdminListNonGucianCourse 5

--3 g
Exec AdminUpdateExtension 3

--3 h
declare @success bit
Exec AdminIssueThesisPayment 2 ,460.20, 3, 10.3, @success output
print @success 
--3 i
Exec AdminViewStudentProfile 3
Exec AdminViewStudentProfile 4
Exec AdminViewStudentProfile 8

--3 j
Exec AdminIssueInstallPayment 38 ,'10/10/2014'

--3 k
Exec AdminListAcceptPublication

--3 l
Exec AddCourse 'CS501' ,10, 100.40

Exec linkCourseStudent 6 ,5

Exec  addStudentCourseGrade 7 ,8 ,10.76

--3 m
Exec  ViewExamSupDefense '08/09/2011'
Exec  ViewExamSupDefense '09/03/2012'

--4 a
Exec EvaluateProgressReport 15 ,12 ,13 ,15

Exec EvaluateProgressReport 69 ,10 ,90 ,34

Exec EvaluateProgressReport 420 ,19 ,35 ,65

--4 b
Exec ViewSupStudentsYears 15

Exec ViewSupStudentsYears 67

Exec ViewSupStudentsYears 69

--4 c
Exec SupViewProfile 15

Exec UpdateSupProfile 15 ,'Mohammed', 'Material engineering'

Exec SupViewProfile 23

Exec UpdateSupProfile 23 ,'Ahmed', 'Computer engineering'

Exec SupViewProfile 42

Exec UpdateSupProfile 42 ,'Abbas', 'Applied Arts'


--4 d
Exec ViewAStudentPublications 9

Exec ViewAStudentPublications 21

Exec ViewAStudentPublications 10

--4 e
Exec AddDefenseGucian 14, '10/10/2013' ,'Hall 13'

Exec AddDefenseNonGucian 12, '09/08/2015', 'Hall 15'


Exec AddDefenseGucian 43, '11/02/2015' ,'Hall 04'

Exec AddDefenseNonGucian 26, '04/11/2015', 'Hall 03'


Exec AddDefenseGucian 74, '10/10/2010' ,'Hall 18'

Exec AddDefenseNonGucian 31, '06/05/2019', 'Hall 17'

-- 4 f
Exec AddExaminer 8 ,'04/10/2011', 'Ahmed Helmy' ,0, 'Architecture'

Exec AddExaminer 5 ,'07/09/2012', 'Rodayna Alaa' ,1, 'Engineering'

Exec AddExaminer 2 ,'05/12/2015', 'Mustafah Mohamed' ,0, 'Architecture'

--4 g
Exec CancelThesis 15

Exec CancelThesis 11

Exec CancelThesis 23

--4 h
Exec AddGrade 14, 59.50

Exec AddGrade 23, 83.00

Exec AddGrade 15, 75.00

--5 a
Exec AddDefenseGrade 11, '01/10/2015' ,12.46

Exec AddDefenseGrade 15, '09/11/2011' ,28.96

Exec AddDefenseGrade 17, '03/03/2013' ,39.00

--5 b
Exec AddCommentsGrade 7 ,'09/10/2018' ,'Great Job yay go you'

Exec AddCommentsGrade 15 ,'03/12/2014' ,'Nice Improvement'

Exec AddCommentsGrade 8 ,'08/09/2011' ,'Try harder'
--6 a
Exec viewMyProfile 2

Exec dbo.checkstudenttype 1

--6 b
Exec editMyProfile 8 ,'Karim', 'Hatem', 'Karim69420' ,'Kh@gmail' ,'38 street' ,'PHD'

--6 c
Exec addUndergradID 3 ,'a4356'

--6 d
Exec ViewCoursesGrades 4

--6 e
Exec ViewCoursePaymentsInstall 3

Exec ViewThesisPaymentsInstall 3

Exec ViewUpcomingInstallments 3

Exec ViewMissedInstallments 3

--6 f
Exec AddProgressReport 11, '08/09/2011'

Exec FillProgressReport 11 ,13 ,10 ,'horrendous work you fail'

Exec dbo.getstudentid 13
--6 g
Exec ViewEvalProgressReport 6 ,13

--6 h
Exec addPublication 'The study of databases and their functions', '08/09/2012' ,'Hmty65', 'Narnia', 1

--6 i
Exec  linkPubThesis 15 ,6