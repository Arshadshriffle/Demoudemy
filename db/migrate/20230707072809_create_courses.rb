class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :about
      t.string :status
      # t.string :course_content
      t.references :instructor
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
