Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :instructors, :controller => "users", :type => "Instructor", only: [:create, :update, :destroy]
  resources :students, :controller => "users", :type => "Student", only: [:create, :update, :destroy]
  resources :courses
  resources :enrollments
  post "/auth/login", to: "authentication#login"

  get "/instructor", to: "courses#single_course_with_name"
  get "/instructor/status", to: "courses#course_status"

  get "student/allcourses", to: "courses#allcourses"
  get "student/category", to: "courses#course_category"
  get "student/name", to: "courses#course_with_name"
  get "student/tac", to: "courses#name_and_category"

  get "mycourse", to: "enrollments#search_in_my_course"
end
