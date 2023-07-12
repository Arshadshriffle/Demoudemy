class InstructorSerializer < ActiveModel::Serializer
  attributes :id ,:name , :email, :username

  has_many :courses
end
