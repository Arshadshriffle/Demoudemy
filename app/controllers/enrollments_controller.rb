class EnrollmentsController < ApplicationController

    def create
      user = User.find(@current_user.id)
      if user.type == "Student" 
        @enroll = @current_user.enrollments.new(enroll_params)
        if @enroll.save
          render json: @enroll, status: :ok
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
        render json: all_courses, status: :ok
      end
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
    
  
    def update
      begin
       
      enrollment = Enrollment.find(params[:id])
      new_status = params[:cou_status]
  
      if enrollment.update(cou_status: new_status)
        render json: @enroll,  status: :ok
      else
        render json: enrollment.errors, status: :unprocessable_entity
      end
    rescue 
      render json: { error: "Enrollment not found" }, status: :not_found
    end
    end
   

    def search_in_my_course
      # byebug
        course=Course.where("title LIKE ?", "%#{params[:title]}%").pluck(:id)

        all_courses = Enrollment.where(course_id:course,student_id:@current_user.id)

    render json: all_courses
     
    end

    private
  
    def enroll_params
      params.permit(:course_id)
    end
  end
  
