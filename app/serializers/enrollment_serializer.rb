class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id ,:cou_status , :student_id, :course

  belongs_to :course

  # belongs_to :student
end
