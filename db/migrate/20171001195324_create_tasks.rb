class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :title
      t.text :description
      t.integer :lesson_id
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
