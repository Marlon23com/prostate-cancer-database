-- Show all diagnoses with patient names
SELECT p.first_name, p.last_name, cs.stage_name, d.psa_level
FROM diagnoses d
JOIN patients p ON d.patient_id = p.patient_id
JOIN cancer_stages cs ON d.stage_id = cs.stage_id;

-- Show all biomarkers reported by bioinformatician
SELECT p.first_name, p.last_name, b.gene, b.mutation_type, b.clinical_significance
FROM biomarkers b
JOIN patients p ON b.patient_id = p.patient_id
WHERE b.reported_by = 4;


SELECT * FROM users;