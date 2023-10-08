CREATE TABLE IF NOT EXISTS patient(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
	cpf VARCHAR(20) UNIQUE NOT NULL,
	phone VARCHAR(50) NOT NULL,
	birthday TIMESTAMP,
    created_on TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS template(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
	message VARCHAR(300) NOT NULL,
	is_file BOOL,
	url_file VARCHAR(200),
    created_on TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS program(
    id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	created_on TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_day INT,
	id_template INT,
	CONSTRAINT fk_id_template FOREIGN KEY(id_template) REFERENCES template(id)
);

CREATE TABLE IF NOT EXISTS program_patient(
    id SERIAL PRIMARY KEY,
	created_on TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_program INT,
	id_patient INT,
	CONSTRAINT fk_id_template FOREIGN KEY(id_program) REFERENCES program(id),
	CONSTRAINT fk_id_patient_program FOREIGN KEY(id_patient) REFERENCES patient(id)
);

CREATE TABLE IF NOT EXISTS events(
    id SERIAL PRIMARY KEY,
	created_on TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_patient INT,
	id_type_event INT,
	dstart TIMESTAMP,
	dend TIMESTAMP,
	CONSTRAINT fk_id_event_id_pat FOREIGN KEY(id_patient) REFERENCES patient(id),
	CONSTRAINT fk_id_event_type_event FOREIGN KEY(id_type_event) REFERENCES type_events(id)
);

CREATE TABLE IF NOT EXISTS type_events(
    id SERIAL PRIMARY KEY,
	created_on TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	name varchar(50),
	name_program varchar(50)
);

CREATE TABLE IF NOT EXISTS notification_events(
    id SERIAL PRIMARY KEY,
	created_on TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_program INT,
	id_template INT,
	id_patient INT,
	id_event INT,
	CONSTRAINT fk_id_program_not_eve FOREIGN KEY(id_program) REFERENCES program(id),
	CONSTRAINT fk_id_patient_not_eve FOREIGN KEY(id_patient) REFERENCES patient(id),
	CONSTRAINT fk_id_event_not_eve FOREIGN KEY(id_event) REFERENCES events(id),
	CONSTRAINT fk_id_template_not_eve FOREIGN KEY(id_template) REFERENCES template(id)
);

CREATE TABLE IF NOT EXISTS notification(
    id SERIAL PRIMARY KEY,
	created_on TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	id_patient INT,
	id_template INT,
	id_program INT,
	name_program varchar(50),
	CONSTRAINT fk_id_not_id_pat FOREIGN KEY(id_patient) REFERENCES patient(id),
	CONSTRAINT fk_id_not_id_pro FOREIGN KEY(id_program) REFERENCES program(id),
	CONSTRAINT fk_id_not_id_tem FOREIGN KEY(id_template) REFERENCES template(id),
);