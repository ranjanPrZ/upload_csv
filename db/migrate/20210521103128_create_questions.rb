class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :team_stages
      t.integer :appears
      t.integer :frequency
      t.string :rate_type
      t.boolean :required
      t.string :condition
      t.references :role, foreign_key: true
      t.references :mapping, foreign_key: true

      t.timestamps
    end
  end
end
