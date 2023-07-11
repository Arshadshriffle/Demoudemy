class EnrollmentsController < ApplicationController
    # def show
    #   @all_courses = Course.where(status: "active")
    #   render json: @all_courses, status: :ok
    # end

    def create
      user = User.find(@current_user.id)
      if user.type == "Student"
        @enroll = @current_user.enrollments.new(enroll_params)
        if @enroll.save
          render json: {content:@enroll , video_url:@enroll.course.video.url}, status: 200
        else
          render json: {error: "Course not avilable or you already have it"}
        end
      else
        render json: { errors: "Only Student Can Enroll For Courses" }, status: :unprocessable_entity
      end
    end
  
    def index
      all_courses = Enrollment.where(student_id: @current_user.id)
    
      if all_courses.empty?
        render json: { message: "At this moment, no course is enrolled by you" }, status: :ok
      else
        courses_data = all_courses.map do |enrollment|
          {
            details: enrollment,
            video: enrollment.course.video.url
          }
        end
    
        render json: courses_data, status: :ok
      end
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
    
  
    def update
      begin
      enrollment = Enrollment.find(params[:id])
      new_status = params[:cou_status]
  
      if enrollment.update(cou_status: new_status)
        render json: enrollment
      else
        render json: enrollment.errors, status: :unprocessable_entity
      end
    rescue 
      render json: { error: "Enrollment not found" }, status: :not_found
    end
    end
   







    def my_course
      # byebug
      course=Course.where("title LIKE ?", "%#{params[:title]}%").pluck(:id)

      all_courses = Enrollment.where(id:course).find_by(student_id: @current_user.id)

render json: all_courses
      # if all_courses.length != 0
      #   cou=[]
      #   all_courses.each do |value|
      #   h=Hash.new
      #   h[:details]=value
      #   h[:video]=value.course.video.url
      #   cou.push(h)
      #   end
      #   render json: cou, status: 200
        
      # else 
      #   render json: {message: "At this movement no courses avilable "}
      # end
  end

  # all_courses = Course.joins(:enrollments).where("courses.title LIKE ? AND enrollments.student_id = ?", "%#{params[:title]}%", @current_user)


# def my_course
#   course_ids = Course.where("title LIKE ?", "%#{params[:title]}%").select(:id)

#   all_courses = Enrollment.where(id: course_ids, student_id: @current_user.id).first

#   if all_courses.nil?
#     render json: { message: "No courses available with the provided search field for the current user" }, status: :ok
#   else
#     render json: all_courses, status: :ok
#   end
# rescue => e
#   render json: { error: e.message }, status: :unprocessable_entity
# end
    private
  
    def enroll_params
      params.permit(:course_id)
    end
  end
  