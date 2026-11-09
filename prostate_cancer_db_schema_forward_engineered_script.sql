-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema prostate_cancer_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema prostate_cancer_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `prostate_cancer_db` DEFAULT CHARACTER SET utf8 ;
USE `prostate_cancer_db` ;

-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`users` (
  `user_id` INT NOT NULL DEFAULT (None),
  `username` VARCHAR(50) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `role` ENUM('admin', 'doctor', 'nurse', 'lab_technician', 'bioinformatician') NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`patients` (
  `patient_id` INT NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `date_of_birth` ENUM('male', 'female') NOT NULL,
  `address` TEXT NULL,
  `created_by` INT NULL,
  `phone` VARCHAR(20) NULL,
  PRIMARY KEY (`patient_id`),
  INDEX `fk_patient_created_by_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `fk_patient_created_by`
    FOREIGN KEY (`created_by`)
    REFERENCES `prostate_cancer_db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`medical_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`medical_history` (
  `history_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `condition` VARCHAR(100) NOT NULL,
  `diagnosis_date` DATE NOT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`history_id`),
  INDEX `fk_medical_history_patient_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_medical_history_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `prostate_cancer_db`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`lab_tests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`lab_tests` (
  `test_id` INT NOT NULL,
  `test_name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(45) NULL,
  `normal_range` VARCHAR(100) NULL,
  `unit` VARCHAR(20) NULL,
  PRIMARY KEY (`test_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`lab_results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`lab_results` (
  `result_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `test_id` INT NOT NULL,
  `test_date` DATE NOT NULL,
  `result_value` VARCHAR(100) NOT NULL,
  `conducted_by` INT NULL,
  PRIMARY KEY (`result_id`),
  INDEX `fk_lab_result_patient_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_lab_result_test_idx` (`test_id` ASC) VISIBLE,
  INDEX `fk_lab_result_conducted_by_idx` (`conducted_by` ASC) VISIBLE,
  CONSTRAINT `fk_lab_result_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `prostate_cancer_db`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lab_result_test`
    FOREIGN KEY (`test_id`)
    REFERENCES `prostate_cancer_db`.`lab_tests` (`test_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lab_result_conducted_by`
    FOREIGN KEY (`conducted_by`)
    REFERENCES `prostate_cancer_db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`cancer_stages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`cancer_stages` (
  `stage_id` INT NOT NULL,
  `stage_name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`stage_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`diagnoses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`diagnoses` (
  `diagnoses_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `stage_id` INT NOT NULL,
  `psa_level` DECIMAL(5,2) NULL,
  `gleason_score` INT NULL,
  `diagnosis_date` DATE NOT NULL,
  `diagnosed_by` INT NOT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`diagnoses_id`),
  INDEX `fk_diagnosis_patient_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_diagnosis_stage_idx` (`stage_id` ASC) VISIBLE,
  CONSTRAINT `fk_diagnosis_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `prostate_cancer_db`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diagnosis_stage`
    FOREIGN KEY (`stage_id`)
    REFERENCES `prostate_cancer_db`.`cancer_stages` (`stage_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diagnosis_doctor`
    FOREIGN KEY (`patient_id`)
    REFERENCES `prostate_cancer_db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`treatments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`treatments` (
  `treatment_id` INT NOT NULL,
  `treatment_name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`treatment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`patient_treatments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`patient_treatments` (
  `pt_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `treatment_id` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `prescribed_by` INT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`pt_id`),
  INDEX `fk_pt_patient_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_pt_treatment_idx` (`treatment_id` ASC) VISIBLE,
  INDEX `fk_pt_prescribed_by_idx` (`prescribed_by` ASC) VISIBLE,
  CONSTRAINT `fk_pt_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `prostate_cancer_db`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pt_treatment`
    FOREIGN KEY (`treatment_id`)
    REFERENCES `prostate_cancer_db`.`treatments` (`treatment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pt_prescribed_by`
    FOREIGN KEY (`prescribed_by`)
    REFERENCES `prostate_cancer_db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`doctors` (
  `doctors_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `specialization` VARCHAR(100) NULL,
  `license_number` VARCHAR(50) NULL,
  PRIMARY KEY (`doctors_id`),
  INDEX `fk_doctor_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `prostate_cancer_db`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`appointments` (
  `appointment_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  `appointment_date` DATETIME NOT NULL,
  `reason` TEXT NULL,
  `status` ENUM('scheduled', 'completed', 'cancelled') NULL,
  PRIMARY KEY (`appointment_id`),
  INDEX `fk_appointment_patient_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_appointment_doctor_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `prostate_cancer_db`.`patients` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_doctor`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `prostate_cancer_db`.`doctors` (`doctors_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `prostate_cancer_db`.`hospitals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prostate_cancer_db`.`hospitals` (
  `hospital_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `address` TEXT NULL,
  `phone` VARCHAR(20) NULL,
  `type` ENUM('hospital', 'clinic') NOT NULL,
  PRIMARY KEY (`hospital_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
