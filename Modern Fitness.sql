CREATE DATABASE modern_fintness ;


CREATE TABLE person (
    per_id INT PRIMARY KEY,
    name VARCHAR(100),
    con_info VARCHAR(255),
    type VARCHAR(50)
)

CREATE TABLE member (
    per_id INT,
    reg_date DATE,
    sub_plan VARCHAR(100),
    schedule VARCHAR(255),
    type VARCHAR(50),
    FOREIGN KEY (per_id) REFERENCES person(per_id)
)


CREATE TABLE staff (
    per_id INT,
    salary DECIMAL(10, 2),
    shift VARCHAR(50),
	type varchar(50),
    FOREIGN KEY (per_id) REFERENCES person(per_id)
)



CREATE TABLE regular (
    per_id INT,
    goal varchar(20),
    FOREIGN KEY (per_id) REFERENCES person(per_id)
)


CREATE TABLE vip_client (
    per_id INT,
    personal_trainer VARCHAR(100),
    priv_program VARCHAR(255),
    FOREIGN KEY (per_id) REFERENCES person(per_id)
)


CREATE TABLE receptionist (
    per_id INT,
    sales_num INT,
    bonus DECIMAL(10, 2),
    FOREIGN KEY (per_id) REFERENCES person(per_id)
)


CREATE TABLE trainer (
    per_id INT,
    training_zone VARCHAR(100),
    FOREIGN KEY (per_id) REFERENCES person(per_id)
)


INSERT INTO person (per_id, name, con_info, type) VALUES
(1, 'Hisham', 'hisham@example.com', 'member'),
(2, 'Menna ', 'menna@example.com', 'VIP member'),
(3, 'Abdelrahman', 'abdelrahman@example.com', 'VIP member'),
(4, 'Mariam', 'mariam@example.com', 'receptionist'),
(5, 'Fatma', 'fatma@example.com', 'trainer'),
(6 ,'Esraa', 'esraa@example.com', 'trainer'),
(7 ,'Shahd', 'shahd@example.com', 'receptionist'),
(8 ,'Mohammed', 'mohammed@example.com', 'member');


INSERT INTO member (per_id, reg_date, sub_plan, schedule, type) VALUES
(1, '2025-01-01', 'Monthly', 'MWF 6-7 PM', 'regular'),
(2, '2025-04-01', 'Unnual', 'MWF 6-7 PM', 'VIP'),
(3, '2025-02-08', 'Unnual', 'MWF 6-7 PM', 'VIP'),
(8, '2025-04-18','Monthly', 'MWF 6-7 PM', 'regular');


INSERT INTO staff (per_id, salary, shift) VALUES
(4, 3000.00, 'Morning'),
(5, 4000.00, 'Evening'),
(6, 5000.00, 'Evening'),
(7, 3700.00, 'Morning');


INSERT INTO regular (per_id, goal) VALUES
(1, 'weight loss'),
(8, 'weight gain');


INSERT INTO vip_client (per_id, personal_trainer, priv_program) VALUES
(2, 'Esraa', 'VIP PPL'),
(3, 'Fatma', 'VIP UL');


INSERT INTO receptionist (per_id, sales_num, bonus) VALUES
(4, 50, 500.00),
(7, 24, 360.00);


INSERT INTO trainer (per_id, training_zone) VALUES
(5, 'Cardio'),
(6, 'Legs');

select p.name, salary , bonus, training_zone
from staff as s
left join person as p on p.per_id = s.per_id
left join receptionist as r on p.per_id = r.per_id
left join trainer as t on p.per_id = t.per_id;

select (m.per_id), name , personal_trainer, goal
from member as m
left join person as p on p.per_id = m.per_id
left join vip_client as v on v.per_id = m.per_id
left join regular as r on r.per_id = p.per_id;

create view highpaid as
select s.per_id, p.name, s.salary
from staff as s
join person as p on p.per_id = s.per_id
where salary >3750;

select * from highpaid;

BEGIN TRANSACTION 

BEGIN TRY

	INSERT INTO	person(per_id,name,con_info,type)
	VALUES (11, 'Khaled', 'Khaled@examle.com', 'VIP member');

	INSERT INTO member (per_id, reg_date, sub_plan, schedule, type) 
	VALUES (11, '2025-05-01', 'Annual', 'TTS 8-9 PM', 'VIP');
	INSERT INTO vip_client (per_id, personal_trainer, priv_program)
	VALUES (11, 'Esraa', 'VIP PPL');

	COMMIT TRANSACTION

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION;
	PRINT 'Tranaction failed' + ERROR_MESSAGE();
END CATCH;