# ruby
require "test_helper"
require Rails.root.join("db/migrate/20250620144505_create_users.rb")

class CreateUsersMigrationTest < ActiveSupport::TestCase
  def setup
    @connection = ActiveRecord::Base.connection
    # Drop the table if it already exists to ensure a clean test
    @connection.drop_table(:users) if @connection.table_exists?(:users)
  end

  def teardown
    @connection.drop_table(:users) if @connection.table_exists?(:users)
  end

  test "should create users table with correct columns" do
    # Run the migration
    CreateUsers.new.change

    assert @connection.table_exists?(:users), "users table should exist"

    columns = @connection.columns(:users).map(&:name)
    expected_columns = [
      "id", "email", "telefono", "fecha", "dni", "cuit",
      "tarjeta_credito", "nombre", "created_at", "updated_at"
    ]
    expected_columns.each do |col|
      assert_includes columns, col, "users table should have column #{col}"
    end
  end
end