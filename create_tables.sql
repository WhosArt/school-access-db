-- создание базы данных
CREATE DATABASE school_access;

-- Создание таблицы-справочника с помощью которой мы свяжем другие таблицы
CREATE TABLE students_registery (
	student_id SERIAL PRIMARY KEY,
	id_card VARCHAR(20) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 1. Личные данные школьника
CREATE TABLE student_personal_data (
	student_id INT PRIMARY KEY, 
	last_name VARCHAR(50) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	middle_name VARCHAR(50),
	birth_date DATE, 
	gender CHAR(1),
	
	FOREIGN KEY (student_id)
		REFERENCES students_registery(student_id)
		ON DELETE CASCADE
);


-- 2. Районы
CREATE TABLE districts (
	districts_id SERIAL PRIMARY KEY,
	district_name VARCHAR(100) UNIQUE NOT NULL
);

-- 3.Адрес школьника
CREATE TABLE student_addresses (
	student_id INT PRIMARY KEY,
	district_id INT NOT NULL,
	street VARCHAR(100),
	house VARCHAR(20),
	apartment VARCHAR(20),
	
	FOREIGN KEY (student_id)
		REFERENCES students_registery(student_id),
		
	FOREIGN KEY (district_id)
		REFERENCES districts(districts_id)
);

-- 4. Контакты родителей
CREATE TABLE parent_contacts (
	contact_id SERIAL PRIMARY KEY, 
	student_id INT NOT NULL,
	parent_name VARCHAR(100),
	phone VARCHAR(20),
	email VARCHAR(100),
	relationship VARCHAR(30),
	
	FOREIGN KEY (student_id)
		REFERENCES students_registery(student_id)
		ON DELETE CASCADE
);

-- 5. Социальный статус семьи
CREATE TABLE social_statuses (
	status_id SERIAL PRIMARY KEY,
	status_name VARCHAR(100) UNIQUE NOT NULL
);

-- 6. Социальный статус ученика 
CREATE TABLE student_social_status (
	student_id INT PRIMARY KEY,
	status_id INT NOT NULL,
	
	FOREIGN KEY (student_id)
		REFERENCES students_registery(student_id),
	
	FOREIGN KEY (status_id)
		REFERENCES social_statuses(status_id)
);

--7. Класс ученика
CREATE TABLE school_classes (
	class_id SERIAL PRIMARY KEY,
	class_name VARCHAR(20) UNIQUE NOT NULL,
	class_teacher VARCHAR(100)
);

--8. Принадлежность ученика к классу
CREATE TABLE student_classes (
	student_id INT PRIMARY KEY,
	class_id INT NOT NULL,
	academic_year VARCHAR(9),
	
	FOREIGN KEY (student_id)
		REFERENCES students_registery(student_id),
	FOREIGN KEY (class_id)
		REFERENCES school_classes(class_id)
);

--9. Успеваемость
CREATE TABLE academic_performance (
	performance_id SERIAL PRIMARY KEY, 
	student_id int NOT NULL,
	subject_name VARCHAR(100),
	grade SMALLINT,
	quarter SMALLINT,
	academic_year VARCHAR(9),
	
	FOREIGN KEY (student_id)
		REFERENCES students_registery(student_id)
		ON DELETE CASCADE
	);

-- Справочник турникетов
CREATE TABLE turnstiles (
	turnstile_id SERIAL PRIMARY KEY,
	location VARCHAR(100)
);
	
-- Журнал проходов
CREATE TABLE school_turnstile_logs (
	log_id BIGSERIAL PRIMARY KEY,
	
	student_id INT NOT NULL,
	id_card VARCHAR(20) NOT NULL,
	timestamp TIMESTAMP  NOT NULL,
	
	turnstile_id INT NOT NULL,
	
	full_name VARCHAR(200) NOT NULL,
	district VARCHAR(100),
	class_name VARCHAR(20),
	social_status VARCHAR(100),
	
	FOREIGN KEY (student_id)
		REFERENCES students_registery(student_id),
	FOREIGN KEY (turnstile_id)
		REFERENCES turnstiles(turnstile_id)
);