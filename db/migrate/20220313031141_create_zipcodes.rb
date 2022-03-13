class CreateZipcodes < ActiveRecord::Migration[7.0]
  def change
    create_table :zipcodes do |t|
      t.integer :zipcode
      t.string :locality
      t.string :federal_entity
      t.string :municipality

      t.timestamps
    end
  end
end
