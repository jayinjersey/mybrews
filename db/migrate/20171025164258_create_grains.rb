class CreateGrains < ActiveRecord::Migration[5.0]
  def change
    create_table :grains do |t|
      t.string :name
      t.text :description
      t.string :color
      t.string :potential
      t.string :yield
      t.string :origin
    end
  end
end
