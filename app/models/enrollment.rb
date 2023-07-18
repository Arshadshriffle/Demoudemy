class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  before_validation :set_default_status, on: :create

  validates :course_id, uniqueness: { scope: :student_id }

  validates :cou_status, inclusion: { in: %w[pending completed] }

  private

  def set_default_status
    self.cou_status ||= "pending"
  end
end
