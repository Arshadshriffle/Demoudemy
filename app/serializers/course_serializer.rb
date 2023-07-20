class CourseSerializer < ActiveModel::Serializer
  attributes :id, :instructor_id, :title, :about, :video

  def current_log_user
    @current_user = @instance_options[:c_user]
  end

  def video
    if current_log_user.type == "Student"
      enrollment = @current_user&.enrollments.where(course_id: object.id)
      if enrollment.present?
        object.video.url
      else
        "You are not enroll for this course"
      end
    else
      object.video.url
    end
  end
end
