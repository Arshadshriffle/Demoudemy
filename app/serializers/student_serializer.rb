class StudentSerializer < ActiveModel::Serializer
  attributes :id ,:name , :email, :username

  has_many :courses
  has_many :enrollments, through: :courses
end
