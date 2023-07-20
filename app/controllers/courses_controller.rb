class CoursesController < ApiController
  before_action :authenticate_request

  def create
    user = User.find(@current_user.id)
    authorize Course
    course = @current_user.courses.new(course_params)
    # return json: course if course.save
    # render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
    if course.save
      render json: course
    else
      render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    if @current_user.type == "Instructor"
      courses = @current_user.courses
      courses = courses.where(status: params[:status]) if params[:status].present?
      courses = courses.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    else
      courses = Course.where(status: "active")
      courses = courses.where(category_id: params[:category_id]) if params[:category_id].present?
      courses = courses.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    end
    course_list(courses)
  end

  def show
    @single_course = Course.find_by(instructor_id: @current_user.id, id: params[:id])
    authorize Course

    if @single_course.present?
      render json: @single_course, each_serializer: CourseSerializer, c_user: @current_user, status: :ok
    else
      render json: { errors: "Course with id #{params[:id]} is not available or not yet created" }, status: :unprocessable_entity
    end
  end

  private

  def course_list(var)
    if var.present?
      render json: var, each_serializer: CourseSerializer, c_user: @current_user, status: :ok
    else
      render json: { message: "No courses Available right now" }
    end
  end

  def course_params
    params.permit(:title, :about, :video, :category_id, :status)
  end
end
