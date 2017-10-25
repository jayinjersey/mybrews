class CreateHops < ActiveRecord::Migration[5.0]
  def change
    create_table :hops do |t|
      t.string :name
      t.text :description
      t.string :type
      t.string :form
      t.string :alpha
      t.string :beta
    end
  end
end
