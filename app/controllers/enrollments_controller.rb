class EnrollmentsController < ApiController
  def create
    user = User.find(@current_user.id)
    authorize Enrollment
    @enroll = @current_user.enrollments.new(enroll_params)
    if @enroll.save
      render json: @enroll, status: :ok
    else
      render json: { error: "Course not avilable or you already have it" }
    end
  end

  def index
    all_courses = @current_user.enrollments
    authorize Enrollment
    if all_courses.present?
      render json: all_courses, c_user: @current_user, status: :ok
    else
      render json: { message: "At this moment, no course is enrolled by you" }, status: :ok
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    begin
      enrollment = Enrollment.find(params[:id])
      authorize Enrollment
      new_status = params[:cou_status]

      if enrollment.update(cou_status: new_status)
        render json: { message: "sucessfully updated", cour_de: enrollment }, status: :ok
      else
        render json: enrollment.errors, status: :unprocessable_entity
      end
    rescue
      render json: { error: "Enrollment not found" }, status: :not_found
    end
  end

  def search_in_my_course
    course = Course.where("title LIKE ?", "%#{params[:title]}%").pluck(:id)
    authorize Enrollment

    all_courses = Enrollment.where(course_id: course, student_id: @current_user.id)

    render json: all_courses
  end

  private

  def enroll_params
    params.permit(:course_id)
  end
end
