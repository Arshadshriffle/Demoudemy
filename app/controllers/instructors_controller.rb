class InstructorsController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    # before_action :set_user, only: [:show]
  
    def create
      @instructor = Instructor.new(user_params)
      if @instructor.save
        render json: @instructor, status: :created
      else
        render json: { errors: @instructor.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # def show
    #   all_courses = Course.where(instructor_id: @current_user).where("title LIKE ?", "%#{params[:title]}%")
    
    #   if all_courses.empty?
    #     render json: { message: "At this moment, no courses available with your seach query" }, status: :ok
    #   else
    #     render json: all_courses
    #     end
    # rescue => e
    #   render json: { error: e.message }, status: :unprocessable_entity
    # end
    
    def update
      @instructor = Instructor.where(id: @current_user.id).find_by(id:params[:id])
      if !@instructor.blank?
        if @instructor.update(params.permit(:password))
          render json: { message: "Password updated successfully" } ,status: :ok
        else
          render json: { errors: @instructor.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "You are Pretending to someone" }, status: :unprocessable_entity
      end 
    end
  
    # def update
    #   if @instructor.update(instructor_params)
    #     render json: @instructor
    #   else
    #     render json: { errors: @instructor.errors.full_messages }, status: :unprocessable_entity
    #   end
    # end
  
    # def destroy
    #   @instructor.destroy
    #   head :no_content
    # end

    def destroy
      @instructor = Instructor.where(id: @current_user.id).find_by(id:params[:id])
      if !@instructor.blank?
        if @instructor.destroy
          render json: { message: "Instructor Deleted" }, status: :ok
        else
          render json: { errors: @instructor.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "You are Pretending to someone else" }, status: :unprocessable_entity
      end 
    end
  
    private

    # def set_user
    #   @instructor = Instructor.find(params[:id])
    # end
  
    def user_params
      params.permit(:name, :email, :password, :username, :type)
    end
  end
  