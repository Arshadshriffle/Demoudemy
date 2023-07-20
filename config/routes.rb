Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :instructors, :controller => "users", :type => "Instructor", only: [:create, :update, :destroy]
  # resources :students, :controller => "users", :type => "Student", only: [:create, :update, :destroy]
  resources :users
  resources :courses
  resources :enrollments
  post "/auth/login", to: "authentication#login"
  get "mycourse", to: "enrollments#search_in_my_course"
end
