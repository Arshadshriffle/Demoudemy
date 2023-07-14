class StudentsController < ApiController
  def enrolled_courses
    student = Student.find(params[:id])
    courses = student.courses

    render json: courses
  end
end
