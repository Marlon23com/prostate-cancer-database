-- Create Database
CREATE DATABASE IF NOT EXISTS prostate_cancer_db;
USE prostate_cancer_db;

-- Table 1: users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'doctor', 'nurse', 'lab_technician') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: patients
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other'),
    phone VARCHAR(20),
    address TEXT,
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Table 3: medical_history
CREATE TABLE medical_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    condition VARCHAR(100),
    diagnosis_date DATE,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Table 4: lab_tests
CREATE TABLE lab_tests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    test_name VARCHAR(100),
    description TEXT,
    normal_range VARCHAR(100),
    unit VARCHAR(20)
);

-- Table 5: lab_results
CREATE TABLE lab_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    test_id INT,
    test_date DATE,
    result_value VARCHAR(100),
    conducted_by INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (test_id) REFERENCES lab_tests(test_id),
    FOREIGN KEY (conducted_by) REFERENCES users(user_id)
);

-- Table 6: cancer_stages
CREATE TABLE cancer_stages (
    stage_id INT AUTO_INCREMENT PRIMARY KEY,
    stage_name VARCHAR(20),
    description TEXT
);

-- Table 7: diagnoses
CREATE TABLE diagnoses (
    diagnosis_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    stage_id INT,
    psa_level DECIMAL(5,2),
    gleason_score INT,
    diagnosis_date DATE,
    diagnosed_by INT,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (stage_id) REFERENCES cancer_stages(stage_id),
    FOREIGN KEY (diagnosed_by) REFERENCES users(user_id)
);

-- Table 8: treatments
CREATE TABLE treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    treatment_name VARCHAR(100),
    description TEXT
);

-- Table 9: patient_treatments
CREATE TABLE patient_treatments (
    pt_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    treatment_id INT,
    start_date DATE,
    end_date DATE,
    prescribed_by INT,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id),
    FOREIGN KEY (prescribed_by) REFERENCES users(user_id)
);

-- Table 10: doctors
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    specialization VARCHAR(100),
    license_number VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table 11: appointments
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    reason TEXT,
    status ENUM('scheduled', 'completed', 'cancelled'),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Table 12: hospitals
CREATE TABLE hospitals (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    type ENUM('hospital', 'clinic')
);