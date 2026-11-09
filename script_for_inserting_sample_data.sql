-- inserting sample data into users
INSERT INTO users (username, password_hash, role) VALUES
('dr.smith', 'hashedpassword1', 'doctor'),
('nurse.jane', 'hashedpassword2', 'nurse'),
('lab.mike', 'hashedpassword3', 'lab_technician'),
('bio.anna', 'hashedpassword4', 'bioinformatician'),
('admin.john', 'hashedpassword5', 'admin');

-- add additional role to users table
ALTER TABLE users
MODIFY role ENUM('admin', 'doctor', 'bioinformatician', 'nurse', 'lab_technician', 'researcher') NOT NULL;

-- insert into sample patients
INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone, address, created_by) VALUES
('John', 'Doe', '1970-05-15', 'male', '+1234567890', '123 Health St, MedCity', 1),
('Alice', 'Smith', '1968-11-22', 'female', '+1987654321', '456 Wellness Ave, CareTown', 1);

INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone, address, created_by) VALUES
('Robert', 'Brown', '1965-08-10', 'male', '+1122334455', '789 Genetics Lane, BioCity', 1);

-- altering table due to issue of not having an autoincrement key
ALTER TABLE lab_tests MODIFY test_id INT NOT NULL AUTO_INCREMENT;

-- inserting data into lab tests
INSERT INTO lab_tests (test_name, description, normal_range, unit) VALUES
('PSA Test', 'Prostate-Specific Antigen blood test', '0 - 4 ng/mL', 'ng/mL'),
('Biopsy', 'Tissue sample analysis for cancer cells', 'Benign / Malignant', ''),
('CBC', 'Complete Blood Count', 'Varies', ''),
('Creatinine', 'Kidney function test', '0.6 - 1.2 mg/dL', 'mg/dL');

-- altering table due to issur of not havning an autoincrement key
ALTER TABLE cancer_stages MODIFY stage_id INT NOT NULL AUTO_INCREMENT;

INSERT INTO cancer_stages (stage_name, description) VALUES
('Stage I', 'Localized cancer, low grade'),
('Stage II', 'Localized cancer, higher grade'),
('Stage III', 'Locally advanced cancer'),
('Stage IV', 'Metastatic cancer');

-- inserting patient diagnoses, linking patient id with a diagnosis
INSERT INTO diagnoses (patient_id, stage_id, psa_level, gleason_score, diagnosis_date, diagnosed_by, notes) VALUES
(1, 4, 12.5, 7, '2024-03-15', 1, 'Elevated PSA levels; Gleason score indicates intermediate risk.'),
(2, 2, 3.8, 6, '2024-04-01', 1, 'Early-stage cancer detected via biopsy.');

-- inserting lab results data for each patient currently in patients table linking with their id's
INSERT INTO lab_results (patient_id, test_id, test_date, result_value, conducted_by) VALUES
(1, 1, '2024-03-10', '12.5 ng/mL', 3),  -- PSA Test
(1, 2, '2024-03-12', 'Malignant', 3),   -- Biopsy
(1, 3, '2024-03-14', 'Normal', 3),      -- CBC
(2, 1, '2024-04-01', '3.8 ng/mL', 3),   -- PSA Test
(2, 2, '2024-04-03', 'Benign', 3);      -- Biopsy

-- insert doctors using the existing users list 
INSERT INTO doctors (user_id, specialization, license_number) VALUES
(1, 'Urology', 'MED123456');

-- alter table for treatments id to set to auto increment
ALTER TABLE treatments MODIFY treatment_id INT NOT NULL AUTO_INCREMENT;

-- inserting treatments
INSERT INTO treatments (treatment_name, description) VALUES
('Radical Prostatectomy', 'Surgical removal of the prostate'),
('Radiation Therapy', 'Use of high-energy rays to kill cancer cells'),
('Hormone Therapy', 'Reduces male hormones that fuel cancer growth'),
('Active Surveillance', 'Monitoring cancer without immediate treatment');

-- insert patient treatments by linking a patient and their treatment
INSERT INTO patient_treatments (patient_id, treatment_id, start_date, end_date, prescribed_by, notes) VALUES
(1, 2, '2024-03-20', NULL, 1, 'Started radiation therapy.'),
(1, 3, '2024-03-25', '2024-06-25', 1, 'Hormone therapy for 3 months.'),
(2, 4, '2024-04-10', NULL, 1, 'Active surveillance recommended.');

-- inserting appointment sample data
INSERT INTO appointments (patient_id, doctor_id, appointment_date, reason, status) VALUES
(1, 1, '2024-05-01 10:00:00', 'Follow-up after diagnosis', 'scheduled'),
(2, 1, '2024-05-05 14:30:00', 'Biopsy results discussion', 'scheduled');

-- inserting dna sequences for patients
INSERT INTO dna_sequences (patient_id, sample_type, sequence_file_url, sequencing_date, sequenced_by) VALUES
(1, 'tumor', '/data/sequences/patient1_tumor_GRCh38.bam', '2024-03-20', 4),
(1, 'normal', '/data/sequences/patient1_normal_GRCh38.bam', '2024-03-20', 4),
(2, 'tumor', '/data/sequences/patient2_tumor_GRCh38.bam', '2024-04-10', 4),
(2, 'normal', '/data/sequences/patient2_normal_GRCh38.bam', '2024-04-10', 4),
(3, 'tumor', '/data/sequences/patient3_tumor_GRCh38.bam', '2024-05-01', 4);

-- insert rna sequnces for patients
INSERT INTO rna_sequences (patient_id, tissue_type, expression_data_url, analysis_date, analyzed_by) VALUES
(1, 'Prostate Tumor', '/data/rnaseq/patient1_tumor_expression.tsv', '2024-03-25', 4),
(1, 'Normal Prostate', '/data/rnaseq/patient1_normal_expression.tsv', '2024-03-25', 4),
(2, 'Prostate Tumor', '/data/rnaseq/patient2_tumor_expression.tsv', '2024-04-15', 4),
(3, 'Prostate Tumor', '/data/rnaseq/patient3_tumor_expression.tsv', '2024-05-05', 4);

-- inserting biomarker data
INSERT INTO biomarkers (patient_id, gene, mutation_type, chromosome, position, clinical_significance, reported_by) VALUES
(1, 'TMPRSS2-ERG', 'Gene Fusion', 'chr21', 38675432, 'Likely pathogenic', 4),
(1, 'PTEN', 'Deletion', 'chr10', 89765432, 'Pathogenic', 4),
(2, 'SPOP', 'Missense Mutation', 'chr17', 45678901, 'Likely pathogenic', 4),
(3, 'FOXA1', 'Nonsense Mutation', 'chr14', 32109876, 'Pathogenic', 4),
(3, 'BRCA2', 'Frameshift Mutation', 'chr13', 98765432, 'High risk for aggressive disease', 4);

-- altering biormakers table -> report_date column to use current_date when inserting
ALTER TABLE biomarkers
MODIFY report_date DATE DEFAULT CURRENT_DATE;


-- Sample codes
CREATE TABLE IF NOT EXISTS role_verification (
    role ENUM('admin', 'doctor', 'bioinformatician') NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    expires_at DATETIME DEFAULT NULL
);

-- Insert default codes (you can change these later)
INSERT INTO role_verification (role, code, expires_at) VALUES
('doctor', 'DOC-VERIFY-2025', NULL),
('bioinformatician', 'BIO-SEQ-2025', NULL),
('admin', 'ADMIN-ACCESS-2025', NULL)
ON DUPLICATE KEY UPDATE code = code;