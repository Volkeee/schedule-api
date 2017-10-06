class RenameLessonidInTasks < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :lesson_id, :lesson_name
  end
end
