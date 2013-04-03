class CreateAddressbooks < ActiveRecord::Migration
  def change
    create_table :addressbooks do |t|
      t.string :name
      t.text :url

      t.timestamps
    end
  end
end
