# Prostate Cancer Database Management System

This project involved designing a relational database for prostate cancer patient management, using structured clinical data to model key healthcare workflows. The repository includes the full schema, sample data, SQL queries, and ER diagrams developed for a realistic hospital and patient-record system.

## Project overview

The database was designed to support essential clinical and administrative functions, including:
- patient and user records
- diagnosis and cancer staging
- lab test and result tracking
- treatments and care plans
- doctor and hospital information management
- appointment scheduling and patient follow-up

This project highlights data modeling, relationship design, normalization, and SQL implementation in a healthcare context, demonstrating practical database management skills relevant to data-driven biomedical research.

## Core principles used

This project follows the main principles of relational database design used in health information systems:

- entity modeling
- primary and foreign key relationships
- normalization to reduce redundancy
- separation of clinical and administrative data
- structured storage of longitudinal patient information

The analytical thought process behind this schema was to model the real-world workflow of prostate cancer care. A patient does not exist in isolation; they have medical history, lab results, diagnoses, treatments, appointments, and clinician interactions. To reflect this accurately, the database was designed with separate but connected tables so that each clinical event is stored in a logical place and can be linked back to the correct patient and clinician. This reduces data duplication and improves consistency, which is essential in any healthcare or biomedical dataset.

The design also distinguishes between operational and clinical records. For example, user accounts and role assignments are separated from patient information, while diagnoses and treatments are represented as linked records rather than embedded in a single table. This makes querying easier and supports future expansion, such as adding billing, prescriptions, pathology reports, or patient monitoring data.

The intended result was a clean and scalable database structure that can support clinical decision-making and patient management. In practical terms, the system is designed to answer questions such as:

- which patients are associated with a specific diagnosis?
- what lab results were recorded for a patient?
- which treatment was prescribed and by whom?
- how often has a patient had appointments or follow-up visits?

This structure is useful not only for record keeping but also for downstream analysis, where clinical data may later be connected to patient outcomes, treatment response, or biomarker studies.

## Included files
- `prostate_cancer_db.sql` — main database creation script
- `prostate_cancer_db_schema_forward_engineered_script.sql` — forward-engineered database schema
- `script_for_inserting_sample_data.sql` — sample data insertion script
- `script_for_querying_data.sql` — example SQL queries for database use
- `ER diagram updated.png` — final entity relationship diagram
- `ER diagram before forward engineering.png` — earlier design iteration
- `reverse_engineered_version_ER_diagram.png` — reverse-engineered ER model
