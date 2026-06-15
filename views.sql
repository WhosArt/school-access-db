-- Создание VIEW для анонимизации
CREATE VIEW turnstile_logs_anonymized AS
SELECT 
	log_id, 
	student_id,
	id_card, 
	timestamp,
	turnstile_id
FROM school_turnstile_logs;