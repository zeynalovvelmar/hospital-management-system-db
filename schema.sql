create table Departments(
  dept_id serial primary key,
  dept_code varchar(20) not null unique,
  name varchar(50) not null,
  floor_num int,
  phone varchar(20) not null
);



create table Patients(
  patient_id serial primary key,
  national_id varchar(20) not null unique,
  name varchar(50) not null,
  surname varchar(50) not null,
  birth_date date not null,
  gender varchar(10),
  phone varchar(20) not null,
  address varchar(100),
  blood_type varchar(10),
  emergency_contact varchar(50)
);


create table Doctors(
  doctor_id serial primary key,
  license_num varchar(20) not null unique,
  name varchar(50) not null,
  surname varchar(50) not null,
  speciality varchar(50) not null,
  phone varchar(20),
  email varchar(50) unique,
  work_hour varchar(50),
  dept_id int not null,
  foreign key (dept_id) references Departments(dept_id)
);

create table Appointments(
  appointment_id serial primary key,
  date timestamp not null,
  doctor_id int not null ,
  foreign key (doctor_id) references Doctors(doctor_id),
  patient_id int not null ,
  foreign key (patient_id) references Patients(patient_id),
  status varchar(50) not null CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),
  note varchar(250)
);

create table Examinations(
  examination_id serial primary key,
  diagnosis varchar(100),
  treat_plan varchar(250),
  date date,
  fee decimal(10, 2),
  appointment_id int not null unique,
  foreign key (appointment_id) references Appointments(appointment_id)
);

create table Medications (
  med_id serial primary key,
  barcode varchar(100) unique,
  name varchar(100),
  dosage varchar(50),
  instructions varchar(100)
);

create table Prescriptions(
  prescription_id serial primary key,
  examination_id int not null,
  foreign key (examination_id) references Examinations(examination_id),
  med_id int not null,
  foreign key (med_id) references Medications(med_id)
);

CREATE INDEX idx_patients_national_id ON Patients(national_id);

CREATE INDEX idx_appointments_date ON Appointments(date);

CREATE INDEX idx_doctors_surname ON Doctors(surname);

insert into departments (dept_code, name, floor_num, phone) values
('CARDIO', 'Cardiology', 3, '012-111-11-11'),
('NEURO', 'Neurology', 2, '012-222-22-22');

insert into patients (national_id, name, surname, birth_date, gender, phone, address, blood_type, emergency_contact) values
('ID001', 'Ali', 'Aliyev', '1990-05-15', 'Male', '050-123-45-67', 'Baku', 'A+', 'Father: 055-432-12-00'),
('ID002', 'Leyla', 'Mammadova', '1995-08-20', 'Female', '051-987-65-43', 'Sumqayit', 'O-', 'Husband: 070-123-45-67');

INSERT INTO Doctors (license_num, name, surname, speciality, phone, email, work_hour, dept_id) VALUES 
('DOC001', 'Tofig', 'Aliyev', 'Cardiologist', '055-000-00-01', 'tofig.aliyev@hospital.com', '09:00-17:00', 1),
('DOC002', 'Aysel', 'Badalova', 'Neurologist', '055-000-00-02', 'aysel.badalova@hospital.com', '12:00-20:00', 2);

INSERT INTO Appointments (date, doctor_id, patient_id, status, note) VALUES 
('2023-10-25 10:30:00', 1, 1, 'Completed', 'Routine Checkup'),
('2023-10-26 14:00:00', 2, 2, 'Scheduled', 'Headache complaint');

INSERT INTO Examinations (diagnosis, treat_plan, date, fee, appointment_id) VALUES 
('Hypertension', 'Diet and Sport', '2023-10-25', 50.00, 1),
('Migraine', 'MRI Scan required', '2023-10-26', 70.00, 2);

INSERT INTO Medications (barcode, name, dosage, instructions) VALUES 
('BAR111', 'Paracetamol', '500mg', 'After meal'),
('BAR222', 'Aspirin', '100mg', 'Before sleep');

INSERT INTO Prescriptions (examination_id, med_id) VALUES 
(1, 2), 
(2, 1);