class CoursesController < ApiController
  before_action :authenticate_request

  def create
    user = User.find(@current_user.id)
    authorize Course
    # if user.type == "Instructor"
    course = @current_user.courses.new(course_params)

    if course.save
      # render json: {content:@course , video_url:@course.video.url}, status: 200
      render json: course
    else
      render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
    end
    # else
    #   render json: { errors: "Only Teacher Can Create Courses" }, status: :unprocessable_entity
    # end
  end

  # All the Instructor works

  def index
    @all_courses = Course.where(instructor_id: @current_user.id)
    authorize @allcourses
    if @all_courses.empty?
      render json: { message: "At this moment, no courses available" }, status: :ok
    else
      render json: @all_courses
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def show
    @single_course = Course.find_by(instructor_id: @current_user.id, id: params[:id])
    authorize @single_course
    if @single_course.nil?
      render json: { errors: "Course with id #{params[:id]} is not available or not yet created" }, status: :not_found
    else
      render json: @single_course
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def single_course_with_name
    all_courses = Course.where(instructor_id: @current_user).where("title LIKE ?", "%#{params[:title]}%")
    authorize all_courses
    if all_courses.empty?
      render json: { message: "At this moment, no courses available with your seach query" }, status: :ok
    else
      render json: all_courses
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def course_status
    all_courses = Course.where(instructor_id: @current_user.id, status: params[:status])
    authorize all_course
    if all_courses.empty?
      render json: { message: "No courses available with #{params[:status]} status" }, status: :ok
    else
      render json: all_courses
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # All the Students Works

  def allcourses
    all_courses = Course.where(status: "active")
    authorize all_course
    if all_courses.empty?
      render json: { message: "No courses available yet for you" }, status: :ok
    else
      render json: all_courses, each_serializer: FstudSerializer, status: :ok
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def course_category
    all_courses = Course.where(category_id: params[:category_id], status: "active")
    authorize all_courses
    if all_courses.empty?
      render json: { message: "No courses available with your this category id" }, status: :ok
    else
      render json: all_courses, each_serializer: FstudSerializer, status: :ok
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def name_and_category
    all_courses = Course.where("title LIKE ?", "%#{params[:title]}%").where(category_id: params[:category_id], status: "active")
    authorize all_courses
    if all_courses.empty?
      render json: { message: "No courses available with your search field in this category and name" }, status: :ok
    else
      render json: all_courses, each_serializer: FstudSerializer, status: :ok
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def course_with_name
    all_courses = Course.where("title LIKE ?", "%#{params[:title]}%").where(status: "active")
    authorize all_courses
    if all_courses.empty?
      render json: { message: "No courses available with your search field in this name" }, status: :ok
    else
      render json: all_courses, each_serializer: FstudSerializer, status: :ok
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def course_params
    params.permit(:title, :about, :video, :category_id, :status)
  end
end
