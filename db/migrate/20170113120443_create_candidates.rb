class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :gender
      t.integer :age
      t.string :party

      t.timestamps
    end
  end
end
