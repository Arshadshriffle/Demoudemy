class AddNewToEnrollment < ActiveRecord::Migration[7.0]
  def change
    add_column :enrollments, :cou_status, :string
  end
end
