class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :course

  def initialize(user, course)
    @user = user
    @course = course
  end

  def create?
    user.Instructor?
  end

  def index?
    user.Instructor?
  end

  def show?
    user.Instructor?
  end

  def single_course_with_name?
    user.Instructor?
  end

  def course_status?
    user.Instructor?
  end

  # All the Students Works

  def allcourses?
    user.Student?
  end

  def course_category?
    user.Student?
  end

  def name_and_category?
    user.Student?
  end

  def course_with_name?
    user.Student?
  end


end
