INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(1,'mechanics', 'PHD', 'Study of the detailed mechanics of car suspension system',10/12/2003,11/11/2006,12/12/2006,2.6,20,2)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(2,'mechanics', 'PHD', 'Study of the detailed mechanics of car brake system',10/12/2005,11/11/2007,12/12/2007,3.2,21,1)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(3,'Computer Science', 'Master', 'Study of the detailed schematics of database management systems',09/08/2005,08/11/2006,12/12/2006,2.4,23,0)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(4,'Computer Science', 'PHD', 'Study of the science behind graphical user interfaces',08/11/2004,11/11/2008,12/12/2008,2.9,24,5)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(5,'Computer Science', 'Master', 'Study of networks and their infrastructure',06/07/2007,08/06/2008,11/12/2008,1.4,25,3)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(6,'Computer Science', 'PHD', 'Study of the back-end development of applications',03/06/2008,05/06/2009,12/12/2009,4.2,26,1)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(7,'Computer Science', 'Master', 'Study of front-end development of applications',04/05/2009,05/07/2010,01/12/2010,3.9,27,0)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(8,'Mathematics', 'PHD', 'Study of universal identifiers',03/07/2010,02/06/2011,01/02/2012,2.6,28,1)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(9,'Mathematics', 'PHD', 'Study of statistical analysis',02/03/2011,04/06/2013,08/09/2013,3.7,29,3)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(10,'Mathematics', 'Master', 'Study of functions and relations',10/12/2013,11/11/2015,12/12/2015,3.8,30,3)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(11,'Computation', 'PHD', 'Study of finite automata',02/04/2014,11/11/2015,03/06/2016,3.7,32,2)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(12,'Computation', 'Master', 'Study of non-finite automata',10/12/2013,05/08/2015,12/12/2015,1.8,33,0)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(13,'Computation', 'Master', 'Study of regular languages',07/05/2013,09/09/2015,12/12/2015,2.6,34,1)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(14,'Computation', 'PHD', 'Study of pumping lemma',10/12/2015,11/11/2017,12/12/2017,2.7,35,2)

INSERT INTO Thesis(serialNumber,field,[type], title, startDate,endDate,defenseDate,grade,payment_id,noExtension)
VALUES(15,'Computation', 'Master', 'Study of Context free languages',08/09/2015,09/10/2017,05/06/2018,1.9,36,4)

INSERT INTO PostGradUser(id,email,[password])
VALUES(1,'7amadayel3ab@gmail.com','123456')

INSERT INTO [Admin](id)
VALUES(2)

INSERT INTO GucianStudent(id,firstName,lastName,[type],faculty,[address],GPA,undergradID)
VALUES(3,'Ahmed','Mohammed','PHD','mechatronics','99 whatever avenue los angeles california',4.0,345)

INSERT INTO NonGucianStudent(id,firstName,lastName,[type],faculty,[address],GPA)
VALUES(4,'Omar','Mohammed','PHD','mechatronics','69 whatever avenue los angeles california',3.9)

INSERT INTO Supervisor(id,[name],faculty)
VALUES(5,'Abdulrahman Ahmed','MET')

INSERT INTO PostGradUser(id,email,[password])
VALUES(6,'testtest123@gmail.com','password')

INSERT INTO [Admin](id)
VALUES(7)

INSERT INTO GucianStudent(id,firstName,lastName,[type],faculty,[address],GPA,undergradID)
VALUES(8,'Amr','Mohy','Master','DMET','66 whatever avenue los angeles california',3.2,360)

INSERT INTO NonGucianStudent(id,firstName,lastName,[type],faculty,[address],GPA)
VALUES(9,'Omar','Emad','PHD','Production','420 whatever avenue los angeles california',2.2)

INSERT INTO Supervisor(id,[name],faculty)
VALUES(10,'Abdullah Hazem','Materials Engineering')

INSERT INTO PostGradUser(id,email,[password])
VALUES(11,'ahmedgoated@gmail.com','123456dd')

INSERT INTO [Admin](id)
VALUES(12)

INSERT INTO GucianStudent(id,firstName,lastName,[type],faculty,[address],GPA,undergradID)
VALUES(13,'Hany','Mohammed','Master','mechatronics','29 whatever avenue los angeles california',3.0,3450)

INSERT INTO NonGucianStudent(id,firstName,lastName,[type],faculty,[address],GPA)
VALUES(14,'Omar','Mohammed','PHD','MET','47 whatever avenue los angeles california',3.5)

INSERT INTO Supervisor(id,[name],faculty)
VALUES(15,'Abdulrahman Mohammed','MET')

INSERT INTO GucianProgressReport([sid],[no],[date],eval,[state],thesisSerialNumber,supid)
VALUES(8,10,08/07/2012,'123',10,6,10)

INSERT INTO NonGucianProgressReport([sid],[no],[date],eval,[state],thesisSerialNumber,supid)
VALUES(14,12,09/10/2013,'487',09,7,5)

INSERT INTO GucianProgressReport([sid],[no],[date],eval,[state],thesisSerialNumber,supid)
VALUES(3,11,09/10/2013,'69',08,9,5)

INSERT INTO NonGucianProgressReport([sid],[no],[date],eval,[state],thesisSerialNumber,supid)
VALUES(4,13,11/12/2014,'420',69,10,15)

INSERT INTO Payment(id,amount,no_installments,fundpercentage)
VALUES(20,69000,3,14)

INSERT INTO Installment([date],paymentId,amount,done)
VALUES(08/12/2015,20,23000,'YES')

INSERT INTO Payment(id,amount,no_installments,fundpercentage)
VALUES(21,4200,2,4)

INSERT INTO Installment([date],paymentId,amount,done)
VALUES(04/09/2014,21,2100,'No')

INSERT INTO NonGucianStudentTakeCourse([sid],cid,grade)
VALUES(4,2,3)

INSERT INTO NonGucianStudentTakeCourse([sid],cid,grade)
VALUES(9,3,4)

INSERT INTO NonGucianStudentTakeCourse([sid],cid,grade)
VALUES(14,5,3)

INSERT INTO Defense(serialNumber,[date],[location],grade)
VALUES(132,09/03/2012,'H17','A')

INSERT INTO Examiner(id,[name],fieldOfWork,isNational)
VALUES(69,'7amo','Mechatronics','Yes')

INSERT INTO ExaminerEvaluateDefense([date],serialNo,examinerId,comment)
VALUES(09/03/2012,132,69,'No Comment')

INSERT INTO Defense(serialNumber,[date],[location],grade)
VALUES(157,08/09/2011,'H19','B')

INSERT INTO Examiner(id,[name],fieldOfWork,isNational)
VALUES(78,'Amr Macgyver','Computer Science','No')

INSERT INTO ExaminerEvaluateDefense([date],serialNo,examinerId,comment)
VALUES(08/09/2011,157,78,'Excellent work')