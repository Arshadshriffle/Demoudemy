class StudentsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  # before_action :set_user, only: [:show,:update , :destroy]

  #   def create
  #     @student = Student.new(user_params)
  #     if @student.save
  #       render json: @student, status: :created
  #     else
  #       render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
  #     end
  #   end

  #   def update
  #     @student = Student.where(id: @current_user.id).find_by(id:params[:id])
  #     if !@student.blank?
  #       if @student.update!(params.permit(:password))
  #         render json: { message: "Password updated successfully" }, status: :ok
  #       else
  #         render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
  #       end
  #     else
  #       render json: { errors: "You are Pretending to someone" }, status: :unprocessable_entity
  #     end
  #   end

  #   def destroy
  #     @student = Student.where(id: @current_user.id).find_by(id:params[:id])
  #     if !@student.blank?
  #       if @student.destroy
  #         render json: { message: "student Deleted" }, status: :ok
  #       else
  #         render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
  #       end
  #     else
  #       render json: { errors: "You are Pretending to someone else" }, status: :unprocessable_entity
  #     end
  #   end

  #   def enrolled_courses
  #     student = Student.find(params[:id])
  #     courses = student.courses

  #     render json: courses
  #   end

  #   private

  #   def user_params
  #     params.permit(:name, :email, :password, :username, :type)
  #   end
end
