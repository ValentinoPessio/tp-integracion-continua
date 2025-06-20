require "test_helper"

class UserTest < ActiveSupport::TestCase

  def usuario_valido
    {
      email: "usuario@test.com",
      telefono: "+54 9 11 1234-5678",
      dni: "12345678",
      nombre: "Juan Perez",
      password: "Seguro1235",
      fecha_nacimiento: "1990-01-01",
      cuit: "20-12345678-9",
      tarjeta_credito: "1234-5678-9012-3456",
      direccion: "Calle Falsa 123, Ciudad, Provincia",
      sexo: "masculino"
    }
  end

  def usuario_invalido
    {
      email: "invalido.com",
      telefono: "12345678",
      dni: "00000",
      nombre: "Juan123",
      password: "1234",
      fecha_nacimiento: "1899-12-31",
      cuit: "12345678",
      tarjeta_credito: "1234-5678-9012-3456-7890",
      direccion: "calle",
      sexo: ""
    }
  end

  def test_email_valido
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con email válido"
  end

  def test_email_invalido
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba  usuario con email inválido "
    assert_includes user.errors[:email], "no es válido"
  end

  def test_sexo_valido
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con sexo válido"
  end

  def test_sexo_invalido
    user = User.new(usuario_invalido.merge(sexo: "invalido"))
    refute user.valid?, "Se esperaba usuario con sexo inválido"
    assert_includes user.errors[:sexo], "debe ser 'masculino', 'femenino' o 'otro'"
  end


  def test_dni_valido
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba suario con DNI valido"
  end

  def test_dni_invalido
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba usuario con DNI inválido fuera inválido"
    assert_includes user.errors[:dni], "no es válido"
  end

  def test_telefono_argentino_valido
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con teléfono argentino válido"
  end

  def test_telefono_argentino_invalido
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba usuario con teléfono argentino inválido"
    assert_includes user.errors[:telefono], "no es válido"
  end

  def test_nombre_valido
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con nombre válido"
  end

  def test_nombre_invalido
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba usuario con nombre inválido"
    assert_includes user.errors[:nombre], "no es válido"
  end

  def test_nombre_en_blanco
    user = User.new(usuario_valido.merge(nombre: ""))
    refute user.valid?, "Se esperaba usuario con nombre en blanco"
    assert_includes user.errors[:nombre], "no puede estar en blanco"
  end

  def test_password_valido
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con contraseña válida"
  end

  def test_password_invalido
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba usuario con contraseña inválida"
    assert_includes user.errors[:password], "debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número"
  end

  def test_password_en_blanco
    user = User.new(usuario_valido.merge(password: ""))
    refute user.valid?, "Se esperaba usuario con contraseña en blanco"
    assert_includes user.errors[:password], "no puede estar en blanco"
  end

  def test_fecha_nacimiento_valida
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con fecha de nacimiento válida"
  end

  def test_fecha_nacimiento_invalida
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba usuario con fecha de nacimiento inválida"
    assert_includes user.errors[:fecha_nacimiento], "no es válida"
  end

  def test_fecha_nacimiento_en_blanco
    user = User.new(usuario_valido.merge(fecha_nacimiento: ""))
    refute user.valid?, "Se esperaba usuario con fecha de nacimiento en blanco"
    assert_includes user.errors[:fecha_nacimiento], "no puede estar en blanco"
  end

  def test_cuit_valido
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con CUIT válido"
  end

  def test_cuit_invalido
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba usuario con CUIT inválido"
    assert_includes user.errors[:cuit], "no es válido"
  end

  def test_cuit_en_blanco
    user = User.new(usuario_valido.merge(cuit: ""))
    refute user.valid?, "Se esperaba usuario con CUIT en blanco"
    assert_includes user.errors[:cuit], "no puede estar en blanco"
  end

  def test_tarjeta_credito_valida
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con tarjeta de crédito válida"
  end

  def test_tarjeta_credito_invalida
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba usuario con tarjeta de crédito inválida"
    assert_includes user.errors[:tarjeta_credito], "no es válida"
  end

  def test_direccion_valida
    user = User.new(usuario_valido)
    assert user.valid?, "Se esperaba usuario con dirección válida"
  end

  def test_direccion_invalida
    user = User.new(usuario_invalido)
    refute user.valid?, "Se esperaba usuario con dirección inválida"
    assert_includes user.errors[:direccion], "debe tener al menos 6 caracteres"
  end

  def test_direccion_en_blanco
    user = User.new(usuario_valido.merge(direccion: ""))
    refute user.valid?, "Se esperaba usuario con dirección en blanco"
    assert_includes user.errors[:direccion], "no puede estar en blanco"
  end

end
