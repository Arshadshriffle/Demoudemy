Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :instructors ,:controller=>"users" ,:type=>"Instructor", only: [:create ,:update,:destroy ]
  resources :students  ,:controller=>"users" ,:type=>"Student", only: [:create ,:update,:destroy ]
  # resources :user  , only: [:create ,:update,:destroy]
  resources :courses
  resources :enrollments
  post "/auth/login", to: "authentication#login"

  get "/instructor" , to: "courses#single_course_with_name"
  get "/instructor/status" , to: "courses#course_status"


  get  "student/allcourses", to: "courses#allcourses"
  get  "student/category", to: "courses#course_category"
  get  "student/name", to: "courses#course_with_name"
  get  "student/tac" , to: "courses#name_and_category"

  

  get  "mycourse" , to: "enrollments#search_in_my_course"

  # get  "student/allcourses/:category_id", to: "courses#course_category"
    # get  "student/:category_id/:title" , to: "courses#course_with_name"
# All the instructor works
  # post "/instructor/course", to: "courses#create"
  
  # get "/instructor/course", to: "courses#show"
  # get "/instructor/single_course/:id" , to: "courses#single_course"

 
  # get "/showto" , to: "courses/showto"
 

  # Enrollment
  # post "enrollments/create", to: "enrollments#create"
  # get "/student/category_course/:category_id" , to: "courses#category_course"
  # get "enrollments/show"
  # get 'student/enrolled_courses/:id', to: 'students#enrolled_courses'

  # patch 'update_status', on: :member

 
  # patch "enrollment/updated_status/:id" , to: "enrollments#update_status"


 
end




# resources :instructors, only: [:index, :show, :create, :update, :destroy]
# resources :students, only: [:index, :show, :create, :update, :destroy]

# post "/auth/login", to: "authentication#login"

# scope "/instructor" do
#   resources :courses, only: [:create, :show]
#   get "/single_course/:id", to: "courses#single_course"
#   get "/:title", to: "courses#single_course_with_name"
#   get "/show/:status", to: "courses#course_status"
# end

# scope "/student" do
#   get "/allcourses", to: "courses#allcourses"
#   get "/allcourses/:category_id", to: "courses#course_category"
#   get "/:title", to: "courses#course_with_name"
#   get "/enrolled_courses/:id", to: "students#enrolled_courses"
# end

# post "enrollments/create", to: "enrollments#create"