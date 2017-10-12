class ChangeTypeOfLessonName < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :lesson_name, :string
  end
end
