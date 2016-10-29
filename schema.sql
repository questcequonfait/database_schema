-- MySQL Script generated by MySQL Workbench
-- sam. 29 oct. 2016 03:51:34 CEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hackathon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hackathon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hackathon` DEFAULT CHARACTER SET utf8 ;
USE `hackathon` ;

-- -----------------------------------------------------
-- Table `hackathon`.`users_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`users_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `displayname` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`users_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`users_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `displayname` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `biographie` VARCHAR(45) NULL DEFAULT NULL,
  `sexe` TINYINT(1) NULL,
  `birthdate` VARCHAR(45) NULL,
  `type` INT NULL,
  `status` INT NULL,
  `lastlogin` DATETIME NULL,
  `cookie` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_1_idx` (`status` ASC),
  INDEX `fk_users_2_idx` (`type` ASC),
  CONSTRAINT `fk_users_1`
    FOREIGN KEY (`status`)
    REFERENCES `hackathon`.`users_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_2`
    FOREIGN KEY (`type`)
    REFERENCES `hackathon`.`users_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`commerces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`commerces` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idusers` INT NULL,
  `displayname` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `linksocial` VARCHAR(45) NULL,
  `telnumber` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `siret` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `siret`),
  INDEX `fk_commerces_1_idx` (`idusers` ASC),
  CONSTRAINT `fk_commerces_1`
    FOREIGN KEY (`idusers`)
    REFERENCES `hackathon`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idcommerce` INT NULL DEFAULT NULL,
  `idusers` INT NULL,
  `datestart` DATETIME NULL,
  `dateend` DATETIME NULL,
  `slots` INT NULL DEFAULT NULL,
  `requirebook` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_events_1_idx` (`idcommerce` ASC),
  INDEX `fk_events_2_idx` (`idusers` ASC),
  CONSTRAINT `fk_events_1`
    FOREIGN KEY (`idcommerce`)
    REFERENCES `hackathon`.`commerces` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_events_2`
    FOREIGN KEY (`idusers`)
    REFERENCES `hackathon`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`users_booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`users_booking` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_users` INT NULL,
  `id_events` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_booking_1_idx` (`id_users` ASC),
  INDEX `fk_users_booking_2_idx` (`id_events` ASC),
  CONSTRAINT `fk_users_booking_1`
    FOREIGN KEY (`id_users`)
    REFERENCES `hackathon`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_booking_2`
    FOREIGN KEY (`id_events`)
    REFERENCES `hackathon`.`events` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`users_experience`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`users_experience` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_users` INT NULL,
  `experience` INT NULL,
  `date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_experience_1_idx` (`id_users` ASC),
  CONSTRAINT `fk_users_experience_1`
    FOREIGN KEY (`id_users`)
    REFERENCES `hackathon`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`users_feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`users_feedback` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idevents` INT NULL,
  `postive` TINYINT(1) NULL,
  `negatif` TINYINT(1) NULL,
  `publish` TINYINT(1) NULL,
  `text` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_feedback_1_idx` (`idevents` ASC),
  CONSTRAINT `fk_users_feedback_1`
    FOREIGN KEY (`idevents`)
    REFERENCES `hackathon`.`events` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`users_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`users_permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `requireexp` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`events_restrictions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hackathon`.`events_restrictions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idevents` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_events_restrictions_1_idx` (`idevents` ASC),
  CONSTRAINT `fk_events_restrictions_1`
    FOREIGN KEY (`idevents`)
    REFERENCES `hackathon`.`events` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
