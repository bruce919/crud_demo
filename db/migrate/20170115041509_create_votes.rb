class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :ip_address
      t.integer :candidate_id

      t.timestamps
    end
  end
end
