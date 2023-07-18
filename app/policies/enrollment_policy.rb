class EnrollmentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :enrollment

  def initialize(user, enrollment)
    @user = user
    @enrollment = enrollment
  end

  def create?
    user.Student?
    end
  
    def index?
      user.Student?
    end
  
    def update?
      user.Student?
    end
  
    def search_in_my_course?
      user.Student?
    end
end
