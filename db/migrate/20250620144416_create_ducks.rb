class CreateDucks < ActiveRecord::Migration[7.1]
  def change
    create_table :ducks do |t|

      t.timestamps
    end
  end
end
