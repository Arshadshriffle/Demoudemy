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
end