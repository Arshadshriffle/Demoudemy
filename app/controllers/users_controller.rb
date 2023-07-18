class UsersController < ApiController
  skip_before_action :authenticate_request, only: [:create]
  before_action :authenticate_request, only: [:destroy, :update]

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.where(id: @current_user.id).find_by(id: params[:id])
    if !@user.blank?
      # if @user.update(password_update)
      if @user.update(user_params { password })
        render json: { message: "Password updated successfully" }, status: :ok
      else
        render json: { errors: @instructor.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "You are Pretending to someone" }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.where(id: @current_user.id).find_by(id: params[:id])
    if !@user.blank?
      if @user.destroy
        render json: { message: "Instructor Deleted" }, status: :ok
      else
        render json: { errors: @instructor.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "You are Pretending to someone else" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :username, :type)
  end

  # def password_update
  #   params.permit(:password)
  # end
end
