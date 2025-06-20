class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\.-]+@[a-z\d\.-]+\.[a-z]+\z/i
  ARG_PHONE_REGEX = /\A(\+54\s?9?\s?\d{2,4}\s?\d{3,4}-?\d{4}|\d{10,11})\z/
  DNI_REGEX = /\A\d{8}\z/
  NOMBRE_REGEX = /\A[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+\z/
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}\z/
  CUIT_REGEX = /\A\d{2}-\d{8}-\d{1}\z/
  TARJETA_REGEX = /\A\d{4}-?\d{4}-?\d{4}-?\d{4}\z/

  validate :email_valido
  validate :telefono_argentino_valido
  validate :dni_valido
  validate :nombre_valido
  validate :password_valido
  validate :fecha_nacimiento_valida
  validate :cuit_valido
  validate :tarjeta_credito_valida

  def email_valido
    errors.add(:email, "no es válido") unless email.match?(EMAIL_REGEX)
  end

  def telefono_argentino_valido
    clean_phone = telefono.gsub(/\s+/, '') if telefono
    errors.add(:telefono, "no es válido") unless clean_phone.match?(ARG_PHONE_REGEX)
  end

  def dni_valido
    errors.add(:dni, "no es válido") unless dni.match?(DNI_REGEX)
  end

  def nombre_valido
    if nombre.present?
      errors.add(:nombre, "no es válido") unless nombre.match?(NOMBRE_REGEX)
    else
      errors.add(:nombre, "no puede estar en blanco")
    end
  end

  def password_valido
    if password.present?
      errors.add(:password, "debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número") unless password.match?(PASSWORD_REGEX)
    else
      errors.add(:password, "no puede estar en blanco")
    end
  end

  def fecha_nacimiento_valida
    if fecha_nacimiento.present?
      unless Date.parse(fecha_nacimiento) > Date.new(1900, 1, 1) && Date.parse(fecha_nacimiento) <= Date.today
        errors.add(:fecha_nacimiento, "no es válida")
      end
    else
      errors.add(:fecha_nacimiento, "no puede estar en blanco")
    end
  end

  def cuit_valido
    if cuit.present?
      errors.add(:cuit, "no es válido") unless cuit.match?(CUIT_REGEX)
    else
      errors.add(:cuit, "no puede estar en blanco")
    end
  end

  def tarjeta_credito_valida
    if tarjeta_credito.present?
      errors.add(:tarjeta_credito, "no es válida") unless tarjeta_credito.match?(TARJETA_REGEX)
    else
      errors.add(:tarjeta_credito, "no puede estar en blanco")
    end
  end
end
