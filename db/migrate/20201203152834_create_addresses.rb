class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :zip
      t.string :street
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :uf
      t.string :ibge_code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
