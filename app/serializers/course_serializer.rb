class CourseSerializer < ActiveModel::Serializer
  attributes :id ,:instructor_id , :title ,:about , :video
 

  def video
    object.video.url 
  end





end
