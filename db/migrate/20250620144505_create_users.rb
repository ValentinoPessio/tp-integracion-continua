class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :telefono
      t.string :fecha_nacimiento
      t.string :password
      t.string :dni
      t.string :cuit
      t.string :tarjeta_credito
      t.string :nombre
      t.timestamps
    end
  end
end
