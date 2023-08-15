-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(100) NOT NULL,
  `Telefone` CHAR(11) NOT NULL,
  `E-mail` VARCHAR(45) NULL,
  `CPF/CNPJ` CHAR(15) NOT NULL,
  `Data Nascimento` DATE NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF/CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `Placa` VARCHAR(7) NOT NULL,
  `Cor` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Montadora` VARCHAR(45) NULL,
  `Tipo Combustível` ENUM('Gasolina', 'Etanol', 'Flex', 'Óleo Diesel') NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`, `Cliente_idCliente`),
  INDEX `fk_Veículo_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  UNIQUE INDEX `Placa_UNIQUE` (`Placa` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mecanico` (
  `idMecanico` INT NOT NULL AUTO_INCREMENT,
  `CPF Mecanico` CHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(100) NULL,
  `Especialidade` ENUM('Carro', 'Moto', 'Caminhão') NOT NULL,
  PRIMARY KEY (`idMecanico`),
  UNIQUE INDEX `CPF Mecânico_UNIQUE` (`CPF Mecanico` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ordem_de_Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ordem_de_Serviço` (
  `idOrdem de Serviço` INT NOT NULL AUTO_INCREMENT,
  `Data emissão` DATE NOT NULL,
  `Status` ENUM('Aguardando confirmação', 'Em andamento', 'Concluído') NOT NULL DEFAULT 'Aguardando confirmação',
  `Data conclusão` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idOrdem de Serviço`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Serviço` (
  `idServiço` INT NOT NULL AUTO_INCREMENT,
  `Tipo de serviço` ENUM('Conserto', 'Revisão Periódica') NOT NULL,
  `Valor do serviço` FLOAT NOT NULL,
  `Ordem de Serviço_idOrdem de Serviço` INT NOT NULL,
  PRIMARY KEY (`idServiço`, `Ordem de Serviço_idOrdem de Serviço`),
  UNIQUE INDEX `Descrição do serviço_UNIQUE` (`Tipo de serviço` ASC) VISIBLE,
  INDEX `fk_Serviço_Ordem de Serviço1_idx` (`Ordem de Serviço_idOrdem de Serviço` ASC) VISIBLE,
  UNIQUE INDEX `Valor do serviço_UNIQUE` (`Valor do serviço` ASC) VISIBLE,
  CONSTRAINT `fk_Serviço_Ordem de Serviço1`
    FOREIGN KEY (`Ordem de Serviço_idOrdem de Serviço`)
    REFERENCES `Ordem_de_Serviço` (`idOrdem de Serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Peça` (
  `idPeça` INT NOT NULL AUTO_INCREMENT,
  `Descrição` VARCHAR(45) NOT NULL,
  `Valor` FLOAT NOT NULL,
  `Ordem de Serviço_idOrdem de Serviço` INT NOT NULL,
  PRIMARY KEY (`idPeça`, `Ordem de Serviço_idOrdem de Serviço`),
  INDEX `fk_Peça_Ordem de Serviço1_idx` (`Ordem de Serviço_idOrdem de Serviço` ASC) VISIBLE,
  CONSTRAINT `fk_Peça_Ordem de Serviço1`
    FOREIGN KEY (`Ordem de Serviço_idOrdem de Serviço`)
    REFERENCES `Ordem_de_Serviço` (`idOrdem de Serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Equipe_Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Equipe_Mecanico` (
  `Mecanico_idMecanico` INT NOT NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Serviço_idServiço` INT NOT NULL,
  PRIMARY KEY (`Mecanico_idMecanico`, `Veiculo_idVeiculo`, `Serviço_idServiço`),
  INDEX `fk_Mecânico_has_Veículo_Veículo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  INDEX `fk_Mecânico_has_Veículo_Mecânico1_idx` (`Mecanico_idMecanico` ASC) VISIBLE,
  INDEX `fk_Mecânico tem Equipe_Serviço1_idx` (`Serviço_idServiço` ASC) VISIBLE,
  CONSTRAINT `fk_Mecânico_has_Veículo_Mecânico1`
    FOREIGN KEY (`Mecanico_idMecanico`)
    REFERENCES `Mecanico` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mecânico_has_Veículo_Veículo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mecânico tem Equipe_Serviço1`
    FOREIGN KEY (`Serviço_idServiço`)
    REFERENCES `Serviço` (`idServiço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
