-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema LEICA
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LEICA` ;

-- -----------------------------------------------------
-- Schema LEICA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LEICA` DEFAULT CHARACTER SET utf8mb4 ;
USE `LEICA` ;

-- -----------------------------------------------------
-- Table `LEICA`.`AREA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`AREA` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`AREA` (
  `ID_AREA` INT NOT NULL,
  `DESC_AREA` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL COMMENT 'Informática\nTelecomunicaciones\n',
  PRIMARY KEY (`ID_AREA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`GRUPO_USUARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`GRUPO_USUARIO` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`GRUPO_USUARIO` (
  `ID_GRUPO_USUARIO` INT NOT NULL AUTO_INCREMENT,
  `DESC_GRUPO_USU` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL COMMENT 'ADMINISTRADOR\nDOCENTE\nALUMNO',
  PRIMARY KEY (`ID_GRUPO_USUARIO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`USUARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`USUARIO` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`USUARIO` (
  `RUT_USU` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL,
  `NOM_USU` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `APE_USU` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `SEXO_USU` VARCHAR(10) CHARACTER SET 'utf8' NOT NULL,
  `FECHA_NAC_USU` DATETIME NOT NULL,
  `TELEFONO_USU` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL,
  `CORREO_USU` VARCHAR(128) CHARACTER SET 'utf8' NOT NULL,
  `ESTADO_USU` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL COMMENT 'ACTIVO\nINACTIVO\n\n',
  `CLAVE_USUARIO` VARCHAR(128) CHARACTER SET 'utf8' NOT NULL,
  `AREA_ID_AREA` INT NOT NULL,
  `GRUPO_USUARIO_ID_TIPO_USUARIO` INT NOT NULL,
  PRIMARY KEY (`RUT_USU`, `AREA_ID_AREA`, `GRUPO_USUARIO_ID_TIPO_USUARIO`),
  INDEX `fk_USUARIO_AREA1_idx` (`AREA_ID_AREA` ASC),
  INDEX `fk_USUARIO_GRUPO_USUARIO1_idx` (`GRUPO_USUARIO_ID_TIPO_USUARIO` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`ASIGNATURA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`ASIGNATURA` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`ASIGNATURA` (
  `ID_ASIG` VARCHAR(8) CHARACTER SET 'utf8' NOT NULL,
  `DESC_ASIG` VARCHAR(80) CHARACTER SET 'utf8' NOT NULL,
  `SECCION_ASIG` VARCHAR(50) CHARACTER SET 'utf8' NULL,
  `AREA_ID_AREA` INT NOT NULL,
  PRIMARY KEY (`ID_ASIG`, `AREA_ID_AREA`),
  INDEX `fk_ASIGNATURA_AREA1_idx` (`AREA_ID_AREA` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`LABORATORIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`LABORATORIO` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`LABORATORIO` (
  `ID_LAB` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL,
  `DESC_LAB` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `ESTADO_LAB` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL COMMENT 'ESTADO \nDISPONIBLE \nEN MANTENCION\nNO DISPONIBLE',
  `NUMEQUIP_LAB` INT NOT NULL,
  PRIMARY KEY (`ID_LAB`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`ESTADO_SOLICITUD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`ESTADO_SOLICITUD` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`ESTADO_SOLICITUD` (
  `ID_EST` INT NOT NULL,
  `ESTADO_APROB` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL COMMENT 'APROBADA\nRECHAZADA\nPENDIENTE\n',
  PRIMARY KEY (`ID_EST`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`TIPO_MATERIAL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`TIPO_MATERIAL` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`TIPO_MATERIAL` (
  `ID_TIPO_MATERIAL` INT NOT NULL AUTO_INCREMENT,
  `DESC_TIPO_MATERIAL` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL COMMENT 'INSUMO\nEQUIPAMIENTO',
  PRIMARY KEY (`ID_TIPO_MATERIAL`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`MATERIALES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`MATERIALES` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`MATERIALES` (
  `ID_MAT` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `TIPO_MATERIAL_ID_TIPO_MATERIAL` INT NOT NULL,
  `NOM_MAT` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `DESC_MAT` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `FECHA_REC_MAT` DATETIME NOT NULL,
  `MODELO_MAT` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `ESTADO_MAT` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL COMMENT 'NUEVO\nE - EXCELENTE\nB - BUENO\nR - REGULAR\nM - MALO\n',
  `UNIDADES` INT NOT NULL,
  `COMENTARIO_MAT` VARCHAR(150) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`ID_MAT`, `TIPO_MATERIAL_ID_TIPO_MATERIAL`),
  INDEX `fk_MATERIALES_TIPO_MATERIAL1_idx` (`TIPO_MATERIAL_ID_TIPO_MATERIAL` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`SOLICITUD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`SOLICITUD` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`SOLICITUD` (
  `ID_SLT` INT NOT NULL AUTO_INCREMENT,
  `FECHA_SLT` DATETIME NOT NULL,
  `HORA_INI_SLT` TIME(6) NOT NULL,
  `HORA_FIN_SLT` TIME(6) NOT NULL,
  `DESC_SLT` VARCHAR(80) CHARACTER SET 'utf8' NOT NULL,
  `LABORATORIO_ID_LAB` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL,
  `ASIGNATURA_ID_ASIG` VARCHAR(8) CHARACTER SET 'utf8' NOT NULL,
  `ASIGNATURA_AREA_ID_AREA` INT NOT NULL,
  `ESTADO_ID_EST` INT NOT NULL,
  `MATERIALES_ID_MAT` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `MATERIALES_TIPO_MATERIAL_ID_TIPO_MATERIAL` INT NOT NULL,
  `USUARIO_RUT_USU` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL,
  `USUARIO_AREA_ID_AREA` INT NOT NULL,
  `USUARIO_GRUPO_USUARIO_ID_TIPO_USUARIO` INT NOT NULL,
  PRIMARY KEY (`ID_SLT`, `LABORATORIO_ID_LAB`, `ASIGNATURA_ID_ASIG`, `ASIGNATURA_AREA_ID_AREA`, `ESTADO_ID_EST`, `MATERIALES_ID_MAT`, `MATERIALES_TIPO_MATERIAL_ID_TIPO_MATERIAL`, `USUARIO_RUT_USU`, `USUARIO_AREA_ID_AREA`, `USUARIO_GRUPO_USUARIO_ID_TIPO_USUARIO`),
  INDEX `fk_SOLICITUD_LABORATORIO1_idx` (`LABORATORIO_ID_LAB` ASC),
  INDEX `fk_SOLICITUD_ASIGNATURA1_idx` (`ASIGNATURA_ID_ASIG` ASC, `ASIGNATURA_AREA_ID_AREA` ASC),
  INDEX `fk_SOLICITUD_ESTADO1_idx` (`ESTADO_ID_EST` ASC),
  INDEX `fk_SOLICITUD_MATERIALES1_idx` (`MATERIALES_ID_MAT` ASC, `MATERIALES_TIPO_MATERIAL_ID_TIPO_MATERIAL` ASC),
  INDEX `fk_SOLICITUD_USUARIO1_idx` (`USUARIO_RUT_USU` ASC, `USUARIO_AREA_ID_AREA` ASC, `USUARIO_GRUPO_USUARIO_ID_TIPO_USUARIO` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LEICA`.`HIST_SESSION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LEICA`.`HIST_SESSION` ;

CREATE TABLE IF NOT EXISTS `LEICA`.`HIST_SESSION` (
  `ID_HIST_SESSION` INT NOT NULL AUTO_INCREMENT,
  `FECHA_INICIO` DATETIME NOT NULL,
  `HORA_INICIO` TIME(6) NOT NULL,
  `ESTADO` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL COMMENT '\nCONECTADO\nDESCONECTADO\n',
  `USUARIO_RUT_USU` VARCHAR(12) CHARACTER SET 'utf8' NOT NULL,
  `USUARIO_AREA_ID_AREA` INT NOT NULL,
  `USUARIO_GRUPO_USUARIO_ID_TIPO_USUARIO` INT NOT NULL,
  PRIMARY KEY (`ID_HIST_SESSION`, `USUARIO_RUT_USU`, `USUARIO_AREA_ID_AREA`, `USUARIO_GRUPO_USUARIO_ID_TIPO_USUARIO`),
  INDEX `fk_HIST_SESSION_USUARIO1_idx` (`USUARIO_RUT_USU` ASC, `USUARIO_AREA_ID_AREA` ASC, `USUARIO_GRUPO_USUARIO_ID_TIPO_USUARIO` ASC))
ENGINE = InnoDB;

USE `LEICA` ;

-- -----------------------------------------------------
-- Placeholder table for view `LEICA`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LEICA`.`view1` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `LEICA`.`view2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LEICA`.`view2` (`id` INT);

-- -----------------------------------------------------
-- View `LEICA`.`view1`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `LEICA`.`view1` ;
DROP TABLE IF EXISTS `LEICA`.`view1`;
USE `LEICA`;


-- -----------------------------------------------------
-- View `LEICA`.`view2`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `LEICA`.`view2` ;
DROP TABLE IF EXISTS `LEICA`.`view2`;
USE `LEICA`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `LEICA`.`AREA`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`AREA` (`ID_AREA`, `DESC_AREA`) VALUES (1, 'INFORMATICA');
INSERT INTO `LEICA`.`AREA` (`ID_AREA`, `DESC_AREA`) VALUES (2, 'TELECOMUNICACIONES');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LEICA`.`GRUPO_USUARIO`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`GRUPO_USUARIO` (`ID_GRUPO_USUARIO`, `DESC_GRUPO_USU`) VALUES (1, 'Administrador');
INSERT INTO `LEICA`.`GRUPO_USUARIO` (`ID_GRUPO_USUARIO`, `DESC_GRUPO_USU`) VALUES (2, 'Alumno');
INSERT INTO `LEICA`.`GRUPO_USUARIO` (`ID_GRUPO_USUARIO`, `DESC_GRUPO_USU`) VALUES (3, 'Docente');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LEICA`.`USUARIO`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`USUARIO` (`RUT_USU`, `NOM_USU`, `APE_USU`, `SEXO_USU`, `FECHA_NAC_USU`, `TELEFONO_USU`, `CORREO_USU`, `ESTADO_USU`, `CLAVE_USUARIO`, `AREA_ID_AREA`, `GRUPO_USUARIO_ID_TIPO_USUARIO`) VALUES ('18932123-6', 'Luigi', 'Zuñiga', 'masculino', '1990-07-04', '569772626', 'luis.alberto.zuniga@outlook.com', 'ACTIVO', '1234', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LEICA`.`ASIGNATURA`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`ASIGNATURA` (`ID_ASIG`, `DESC_ASIG`, `SECCION_ASIG`, `AREA_ID_AREA`) VALUES ('IT0001', 'IT Essentials ', '01', 1);
INSERT INTO `LEICA`.`ASIGNATURA` (`ID_ASIG`, `DESC_ASIG`, `SECCION_ASIG`, `AREA_ID_AREA`) VALUES ('TI0002', 'Taller de Integracion', '01', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LEICA`.`LABORATORIO`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`LABORATORIO` (`ID_LAB`, `DESC_LAB`, `ESTADO_LAB`, `NUMEQUIP_LAB`) VALUES ('LAB7', 'Taller de Neworking', 'DISPONIBLE', 20);
INSERT INTO `LEICA`.`LABORATORIO` (`ID_LAB`, `DESC_LAB`, `ESTADO_LAB`, `NUMEQUIP_LAB`) VALUES ('LK01', 'Planta externa', 'NO DISPONIBLE', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LEICA`.`ESTADO_SOLICITUD`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`ESTADO_SOLICITUD` (`ID_EST`, `ESTADO_APROB`) VALUES (1, 'PENDIENTE');
INSERT INTO `LEICA`.`ESTADO_SOLICITUD` (`ID_EST`, `ESTADO_APROB`) VALUES (2, 'APROBADA');
INSERT INTO `LEICA`.`ESTADO_SOLICITUD` (`ID_EST`, `ESTADO_APROB`) VALUES (3, 'RECHAZADA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LEICA`.`TIPO_MATERIAL`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`TIPO_MATERIAL` (`ID_TIPO_MATERIAL`, `DESC_TIPO_MATERIAL`) VALUES (1, 'INSUMOS');
INSERT INTO `LEICA`.`TIPO_MATERIAL` (`ID_TIPO_MATERIAL`, `DESC_TIPO_MATERIAL`) VALUES (2, 'EQUIPAMIENTO');
INSERT INTO `LEICA`.`TIPO_MATERIAL` (`ID_TIPO_MATERIAL`, `DESC_TIPO_MATERIAL`) VALUES (3, 'OTROS');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LEICA`.`MATERIALES`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`MATERIALES` (`ID_MAT`, `TIPO_MATERIAL_ID_TIPO_MATERIAL`, `NOM_MAT`, `DESC_MAT`, `FECHA_REC_MAT`, `MODELO_MAT`, `ESTADO_MAT`, `UNIDADES`, `COMENTARIO_MAT`) VALUES ('PV7V5D4011038', 1, 'Wireless USB Adapter', 'USB Connect a desktop o notebook', '2015-06-12', 'N 150', 'B', 5, 'Equipo con todos los implementos');
INSERT INTO `LEICA`.`MATERIALES` (`ID_MAT`, `TIPO_MATERIAL_ID_TIPO_MATERIAL`, `NOM_MAT`, `DESC_MAT`, `FECHA_REC_MAT`, `MODELO_MAT`, `ESTADO_MAT`, `UNIDADES`, `COMENTARIO_MAT`) VALUES ('lOCOm5', 1, 'Nano Station ', 'Ubiquiti Networks', '2014-03-25', 'M5', 'B', 3, 'Equipo sin manual');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LEICA`.`SOLICITUD`
-- -----------------------------------------------------
START TRANSACTION;
USE `LEICA`;
INSERT INTO `LEICA`.`SOLICITUD` (`ID_SLT`, `FECHA_SLT`, `HORA_INI_SLT`, `HORA_FIN_SLT`, `DESC_SLT`, `LABORATORIO_ID_LAB`, `ASIGNATURA_ID_ASIG`, `ASIGNATURA_AREA_ID_AREA`, `ESTADO_ID_EST`, `MATERIALES_ID_MAT`, `MATERIALES_TIPO_MATERIAL_ID_TIPO_MATERIAL`, `USUARIO_RUT_USU`, `USUARIO_AREA_ID_AREA`, `USUARIO_GRUPO_USUARIO_ID_TIPO_USUARIO`) VALUES (1, '2016-07-12', '11:10', '12:40', 'Se realizara la clase de IT Essentials', 'LAB7', 'IT0001', 1, 1, 'PV7V5D4011038', 1, '18932123-6', 1, 1);

COMMIT;

